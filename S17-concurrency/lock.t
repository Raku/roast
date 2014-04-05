use v6;
use Test;

plan 7;

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
    my @log;

    my $t1 = Thread.start({
        $l.protect({
            @log.push('ale');
            $c.wait();
            @log.push('stout');
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
    $t2.join();

    diag "log = {@log}" if !
      is @log.join(','), 'ale,porter,stout', 'Condition variable worked';
}
