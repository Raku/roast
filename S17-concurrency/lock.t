use v6;
use Test;

plan 6;

#?rakudo.parrot skip 'NYI'
{
    my $l = Lock.new;
    $l.protect({
        pass "Running code under lock";
    });
    $l.protect({
        pass "Running another piece of code under lock";
    });
}

#?rakudo.parrot skip 'NYI'
{
    my $l = Lock.new;
    dies_ok { $l.protect({ die "oops" }) }, "code that dies under lock throws";
    $l.protect({
        pass "Code that dies in run does release the lock";
    });
    Thread.start({
        $l.protect({ pass "Even from another thread"; });
    }).join();
}

#?rakudo.parrot skip 'NYI'
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
    $t1.join;
    $t2.join;
    ok $output ~~ /^ [ a+: b+: | b+: a+: ] $/, 'Lock is at least somewhat effective'; 
}
