use v6;
use Test;

plan 13;

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pall = Promise.allof($p1, $p2);
    isa-ok $pall, Promise, "allof returns a Promise";
    nok $pall.Bool, "No result yet";
    
    $p1.keep(1);
    nok $pall.Bool, "Still not kept";
    
    $p2.keep(1);
    is $pall.result, True, "result is true after both kept";
    is $pall.status, Kept, "Promise was kept";
}

{
    my @p;
    @p[0] = Promise.new;
    @p[1] = Promise.new;
    my $pall = Promise.allof(@p);
    @p[0].keep(1);
    @p[1].break("danger danger");
    lives-ok { $pall.result }, "result on broken all-Promise does not throw";
    is $pall.status, Kept, "all-Promise was kept";
}

{
    my $a = [];
    my @p = (^10).pick(*).map: {
        start {
            sleep 2 * $_;
            cas $a, -> @current { my @ = flat @current, OUTER::<$_> };
        }
    };
    my $all = Promise.allof(@p);
    isa-ok $all, Promise, 'allof gives a Promise';
    my $b = $all.result;  # block
    isa-ok $b, Bool, 'get a bool of the result';
    is ~$a, "0 1 2 3 4 5 6 7 8 9", 'got the right order';
}

# RT #122802
{
    my $job1 = start { print "" };
    my $job2 = start { print "" };
    ok (await Promise.allof($job1, $job2)), "start + await + allof combo, RT #122802";
}

# RT #127101
{
    my $p = Promise.allof(my @promises);
    is $p.status, Kept, 'an empty list should give a kept Promise';
}

throws-like { Promise.allof(42) }, X::Promise::Combinator;
