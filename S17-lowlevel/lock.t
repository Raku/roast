use v6;
use Test;

#-------------------------------------------------------------------------------
# Tests for low level async functionality in Perl 6.  Please do *not* use this
# as inspiration for a way to do things.  Please look at using Promises (aka
# start {...}), Channels and Supplies.  Thank you!
#-------------------------------------------------------------------------------

plan 8;

{
    my $l = Lock.new;
    $l.protect({
        pass "Running code under lock";
    });
    $l.protect({
        pass "Running another piece of code under lock";
    });
}

{
    my $l = Lock.new;
    dies_ok { $l.protect({ die "oops" }) }, "code that dies under lock throws";
    $l.protect({
        pass "Code that dies in run does release the lock";
    });
    Thread.start({
        $l.protect({
            pass "Even from another thread";
        });
    }).finish();
}

{
    # Attempt to check lock actually enforces some locking.
    my $output = '';
    my $l = Lock.new;
    my $t1 = Thread.start({
        $l.protect({ 
            for 1..10000 {
                $output ~= 'a'
            }
        });
    });
    my $t2 = Thread.start({
        $l.protect({ 
            for 1..10000 {
                $output ~= 'b'
            }
        });
    });
    $t1.finish;
    $t2.finish;
    ok $output ~~ /^ [ a+: b+: | b+: a+: ] $/, 'Lock is at least somewhat effective'; 
}

{
    my $l = Lock.new;
    my $c = $l.condition;
    my $now1;
    my $now2 = now;
    my @log;

    my $t1 = Thread.start({
        $l.protect({
            @log.push('ale');
            $c.wait();
            @log.push('stout');
            $now1 = now;
        });
    });

    until $l.protect({ @log.elems }) == 1 { }

    my $t2 = Thread.start({
        $l.protect({
            @log.push('porter');
            $c.signal();
        });
    });

    $t1.join();
    $now2 = now;
    $t2.join();

    diag "log = {@log}{ $now1>$now2 ?? ', thread was running *after* join' !! ''}" if !
      is @log.join(','), 'ale,porter,stout', 'Condition variable worked';
}

#?rakudo skip 'not sure this test is valid'
{
    my $times = 100;
    my $tried;
    my $failed;
    for ^$times {
        my $l = Lock.new;
        my $c = $l.condition;
        my $now1;
        my $now2;
        my $t1 = Thread.start({
            $l.protect({
                $c.wait();
                $now1 = now;
            });
        });

        my $t2 = Thread.start({
            $l.protect({
                $c.signal();
            });
        });

        $t1.join();
        $now2 = now;
        $t2.join();

        $tried++;
        last if $failed = ( !$now1.defined or $now1 > $now2 );
    }
    ok !$failed, "Thread 1 never ran after it was tried $tried times";
}
