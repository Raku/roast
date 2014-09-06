use v6;
use Test;

plan 15;

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

{
    my $p = start {
        (1, 2, 3, 4);
    };
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', 'can returns a Parcel from a start block';
}

#?rakudo skip 'RT #122715'
{
    my $p = start {
        (0..3).map: *+1;
    };
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', 'can return a potentially lazy list from a start block';

}

#?rakudo skip 'RT #122715'
{
    my @outer = 0..3;
    my $p = start {
        @outer.map: *+1;
    };
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', 'can return a lazy map from a start block';

}
