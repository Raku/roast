use v6;
use Test;

plan 40;

throws-like { await }, Exception, "a bare await should not work";

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        42
    });
    sleep 1;
    isa-ok $p, Promise, '.start gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = start {
        pass "Promise.start actually runs";
        42
    };
    sleep 1;
    isa-ok $p, Promise, 'start {} gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        die "trying";
    });
    sleep 1;
    dies-ok { $p.result }, "result throws exception";
    is $p.status, Broken, "Promise was broken";
    is $p.cause.message, "trying", "Correct exception stored";
}

{
    my $p = start (1, 2, 3, 4);  # does start handle a blorst
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', 'can returns a List from a start block';
}

# RT #122715
{
    my $p = start {
        (0..3).map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', 'can return a potentially lazy list from a start block';
}
{
    my @outer = 0..3;
    my $p = start {
        @outer.map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', 'can return a lazy map from a start block';
}
{
    is (await start "d\te\tf".split("\t")), ('d', 'e', 'f').Seq,
        'can return a lazy split from a start block';
}

# RT #123702
{
    my @got = await do for 1..5 { start { buf8.new } };
    ok all(@got.map(* ~~ buf8)), 'buf8.new in many start blocks does not explode';
}

# RT #125346
{
    sub worker(Any $a, Int $b) {}
    my $deaths = 0;
    for ^200 {
        my $value = Any;
        my @workers = (^4).map: {
            start { worker($value) }
        };
        try {
            await @workers;
            CATCH {
                default { $deaths++ }
            }
        }
    }
    is $deaths, 200, 'Getting signature bind failure in Promise reliably breaks the Promise';
}

# RT #125161
{
    my @p = map { start { my @a = [ rand xx 1_000 ]; @a } }, ^10;
    for @p.kv -> $i, $_ {
        ok .result, "Got result from Promise populating/returning an array ($i)";
        is .result.elems, 1000, "Correct number of results in array ($i)";
    }
}

# RT #125196
{
    sub foo() {
        my $p = start { $*E + 1 }
        return $p.result;
    }
    my $*E = 5;
    is foo(), 6, 'Code running in start can see dynamic variables of the start point';
}
