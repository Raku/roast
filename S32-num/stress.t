use v6;
use Test;

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/5518

# https://github.com/rakudo/rakudo/issues/1651
subtest 'No drift when roundtripping Num -> perl -> Num -> perl' => {
    # In this test, it's fine if the original .Str gives the string that
    # doesn't match what the user has entered (since it may be a number that
    # doesn't have exact representation in a double). However, .Num.Str
    # roundtripping *that* string must produce the first string. i.e. there
    # shouldn't be drift after we figure out what the representable number is

    my @ranges := (
        (^30 .map: { 10**($_*10)}),  (^30 .map: {-10**($_*10)}),
        (^30 .map: { 10**($_*-10)}), (^30 .map: {-10**($_*-10)}),
        3e-324, 3e-320, 3e307
    );

    plan @ranges * my \iters = 500;
    for @ranges -> \r {
        for ^iters {
            my \n  := r.rand;
            my \n1 := n.raku.Num; # get first correct num
            my \n2 := n.raku.Num.raku.Num.raku.Num.raku.Num; # second
            cmp-ok n1, '===', n2, "{n} roundtrippage is stable";
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5565

subtest 'parsed literals match &val and Str.Num' =>  {
    plan 2*my $rounds = 100;
    sub gen-num {
        ('.', ^9 .roll: 20).flat.List.rotate(-19.rand.Int).join
        ~ 'e' ~ (-324..308).pick
    }

    for ^$rounds {
        my $n := gen-num;
        cmp-ok $n.EVAL, '==', $n.Num,  "parsed literal == Str.Num [$n]";
        cmp-ok $n.EVAL, '==', val($n), "parsed literal == val()   [$n]";
    }
}

# vim: expandtab shiftwidth=4
