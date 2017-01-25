use v6.d.PREVIEW;
use Test;

plan 5;

# Limit scheduler to just 4 real threads, so we'll clearly be needing the
# non-blocking await support for these to pass.
PROCESS::<$SCHEDULER> := ThreadPoolScheduler.new(max_threads => 4);

{
    sub conc-fib($n) {
        start {
            $n <= 1
                ?? 1
                !! await(conc-fib($n - 2)) + await(conc-fib($n - 1))
        }
    }
    is await(conc-fib(15)), 987, 'Recursion creating a deep await-tree completes correctly';
}

{
    sub conc-fib($n) {
        start {
            $n <= 1
                ?? die "oopsy"
                !! await(conc-fib($n - 2)) + await(conc-fib($n - 1))
        }
    }
    throws-like { await(conc-fib(15)) }, Exception,
        message => "oopsy",
        'Deep Promise tree conveys exception up to the top';
}

{
    my @proms = (1..100).map: {
        start {
            await Promise.in(0.01);
            await Promise.in(0.05);
            $_
        }
    };
    is ([+] await @proms), 5050, 'Hundreds of time-based Promises awaited completes correctly';
}

{
    my $p = Promise.new;
    my @proms = (1..100).map: {
        start {
            await Promise.in(0.1), $p;
            $_
        }
    };
    sleep 0.15;
    ok [==](flat Planned, @proms>>.status), 'await of multiple Promises suspends until all ready';
    $p.keep;
    is ([+] await @proms), 5050, 'Hundred of await on time/manual Promise completes corectly';
}
