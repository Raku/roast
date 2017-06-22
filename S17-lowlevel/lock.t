use v6;
use Test;

#-------------------------------------------------------------------------------
# Tests for low level async functionality in Perl 6.  Please do *not* use this
# as inspiration for a way to do things.  Please look at using Promises (aka
# start {...}), Channels and Supplies.  Thank you!
#-------------------------------------------------------------------------------

plan 23;

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
    dies-ok { $l.protect({ die "oops" }) }, "code that dies under lock throws";
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

{
    my $times = 100;
    my $tried;
    my $failed;
    for ^$times {
        my $l = Lock.new;
        my $c = $l.condition;
        my $now1;
        my $now2;
        my $counter = 0;
        my $t1 = Thread.start({
            $l.protect({
                while $counter == 0 {
                    $c.wait();
                }
                $now1 = now;
            });
        });

        my $t2 = Thread.start({
            $l.protect({
                $counter++;
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

{
    for 1..15 -> $iter {
        my $lock = Lock.new;
        my $cond = $lock.condition;
        my $todo = 0;
        my $done = 0;
        my @in = 1..100;
        my @out = 0 xx 100;

        loop ( my $i = 0; $i < @in; $i++ ) {
            my $in := @in[$i];
            my $out := @out[$i];
            $lock.protect( {
                $*SCHEDULER.cue( {
                    $out = $in * 10;
                    $lock.protect( {
                        $done++;
                        $cond.signal if $done == $todo;
                    } );
                } );
                $todo++;
            } );
        }
        $lock.protect( { $cond.wait unless $done == $todo; } );

        is @out, [10, 20 ... 1000],
            "Correct result and no crash in lock/condvar use ($iter)";
    }
}
