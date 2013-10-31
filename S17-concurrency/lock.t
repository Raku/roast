use v6;
use Test;

plan 6;

{
    my $l = Lock.new;
    $l.run({
        pass "Running code under lock";
    });
    $l.run({
        pass "Running another piece of code under lock";
    });
}

{
    my $l = Lock.new;
    dies_ok { $l.run({ die "oops" }) }, "code that dies under lock throws";
    $l.run({
        pass "Code that dies in run does release the lock";
    });
    Thread.run({
        $l.run({ pass "Even from another thread"; });
    }).join();
}

{
    # Attempt to check lock actually enforces some locking.
    my $output = '';
    my $l = Lock.new;
    my $t1 = Thread.run({
        $l.run({ 
            for 1..10000 {
                $output ~= 'a'
            }
        });
    });
    my $t2 = Thread.run({
        $l.run({ 
            for 1..10000 {
                $output ~= 'b'
            }
        });
    });
    $t1.join;
    $t2.join;
    ok $output ~~ /^ [ a+: b+: | b+: a+: ] $/, 'Lock is at least somewhat effective'; 
}
