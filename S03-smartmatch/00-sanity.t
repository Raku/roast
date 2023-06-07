use Test;
plan 2;

my $seed = (($_ - .Int) * 1_000_000_000).Int with now;
diag "Random seed: " ~ $seed;
srand($seed);

# Make sure that smarmatch doesn't return unexpected values. In particular, it must always return Boolean except for
# when used with regexes.
# Since optimizations may result in different code for matching directly against objects, when RHS is known exactly,
# or indirectly, when RHS type is hiddent behind a symbol, – we need to test both cases.

subtest "direct" => {
    plan 11;
    isa-ok (1 ~~ 1).WHAT, Bool, "plan smartmatch return Bool";
    isa-ok (any(1,2) ~~ 1).WHAT, Bool, "a junction on LHS doesn't autothread";
    isa-ok (1 ~~ any(1,2)).WHAT, Bool, "a junction on RHS doesn't autothread";
    isa-ok ("123" ~~ /\d+/).WHAT, Match, "simple regex returns a Match object on success";
    isa-ok ("123" !~~ /\d+/).WHAT, Bool, "simple regex returns a Bool object on negated success";
    isa-ok ("123" ~~ m/\d+/).WHAT, Match, "successfull m// returns a Match object";
    isa-ok ("123" !~~ m/\d+/).WHAT, Bool, "successfull m// returns a Bool object when negated";
    my $s = "1..5";
    isa-ok ($s ~~ s/\.+/_/).WHAT, Match, "successfull s/// returns a Match object";
    cmp-ok ("abc" ~~ /\d+/), '===', Nil, "failed regex match returns Nil";
    cmp-ok ("abc" ~~ m/\d+/), '===', False, "failed m// returns False";
    cmp-ok ($s ~~ s/\.+/_/), '===', False, "failed s/// returns False";
}

subtest "indirect" => {
    # The order of tests here is randomized to ensure that any possible call-site bound caching of smartmatch outcomes,
    # akin to the one taking place with new-disp implementation on Rakudo, doesn't happen too agressively. Note that if
    # test fails then it can be reproduced with the reported above seed value.
    my sub test-sm(Mu $lhs, Mu $rhs --> Mu) is raw {
        $lhs ~~ $rhs
    }

    my sub test-sm-negated(Mu $lhs, Mu $rhs --> Mu) is raw {
        $lhs !~~ $rhs
    }

    my @tests =
        { isa-ok test-sm(1, 1).WHAT,         Bool,  "plain smartmatch return Bool"; },
        { isa-ok test-sm(any(1,2), 1).WHAT,  Bool,  "a junction on LHS doesn't autothread"; },
        { isa-ok test-sm(1, any(1,2)).WHAT,  Bool,  "a junction on RHS doesn't autothread"; },
        { isa-ok test-sm("123", /\d+/).WHAT, Match, "simple regex returns a Match object on success"; },
        { isa-ok test-sm("abc", /\d+/),      Nil,   "failed regex match returns Nil" },
        { isa-ok test-sm-negated(1, 1).WHAT,         Bool, "negated plain smartmatch return Bool"; },
        { isa-ok test-sm-negated(any(1,2), 1).WHAT,  Bool, "negated: a junction on LHS doesn't autothread"; },
        { isa-ok test-sm-negated(1, any(1,2)).WHAT,  Bool, "negated: a junction on RHS doesn't autothread"; },
        { isa-ok test-sm-negated("123", /\d+/).WHAT, Bool, "negated simple regex returns a Bool object"; },
        { isa-ok test-sm-negated("abc", /\d+/),      Bool, "negated failed regex match returns Bool" };

    plan +@tests;

    for @tests.pick(*) -> &test-code {
        test-code
    }
}


done-testing;
