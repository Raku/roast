use v6;
use Test;

plan 12;

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        42
    });
    sleep 1;
    isa_ok $p, Promise, '.start gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = start {
        pass "Promise.start actually runs";
        42
    };
    sleep 1;
    isa_ok $p, Promise, 'start {} gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        die "trying";
    });
    sleep 1;
    dies_ok { $p.result }, "result throws exception";
    is $p.status, Broken, "Promise was broken";
    is $p.cause.message, "trying", "Correct exception stored";
}
