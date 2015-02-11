use v6;
use Test;
plan 24;

# L<S05/Modifiers/Any grammar regex is really just a kind of method>

{
    my token hasconstant {
        :constant $x = 'foo';
        a $x
    }
    ok 'afoo' ~~ &hasconstant, 'can declare :constant in regex';
    is ~$/, 'afoo', '... and it matched the constant';
    nok 'abar' ~~ &hasconstant, 'does not work with wrong text';
}

{
    my token hasmy {
        :my $y = ' yack';
        b $y $y
    }
    ok 'b yack yack' ~~ &hasmy, 'can declare :my in regex';
    is ~$/, 'b yack yack', 'correct match with "my" variable';
    nok 'b yack shaving' ~~ &hasmy, 'does not work with wrong text';
}

#?rakudo skip "Can't parse :state \$z++"
{
    my token hasstate {
        :state $z++;
        c $z
    }
    ok 'c1' ~~ &hasstate, ':state in regex (match) (1)';
    is ~$/, 'c1', ':state in regex ($/) (1)';

    ok 'c2' ~~ &hasstate, ':state in regex (match) (2)';
    is ~$/, 'c2', ':state in regex ($/) (2)';
    nok 'c3' ~~ &hasstate, ':state in regex (no match)';
}

{
    grammar HasOurTester {
        token TOP {
            :our $our = 'zho';
            d $our
        }
    }
    is ~HasOurTester.parse('dzho'), 'dzho', ':our in regex';

    #?rakudo todo ":our variables in regexes"
    is $DeclaratorTest1::our, 'zho', 'can access our variable from the outside';
}

{
    my $a = 1;
    my regex ta { :temp $a = 5; <&ma> };
    my regex ma { $a $a };
    ok '11'  ~~ m/ ^ <ma> $ /, "can access variables in regex (not temp'ed)";
    ok '55' !~~ m/ ^ <ma> $ /, "(-) not temp'ed";
    is $a, 1, "temp'ed variable still 1";

    ok '55'  ~~ m/ ^ <ta> $ /, "can access temp'ed variable in regex (+)";
    ok '11' !~~ m/ ^ <ta> $ /, "(-) temp'ed";
    is $a, 1, "temp'ed variable again 1";
}

{
    my $a = 1;
    my regex la { :let $a = 5; <&lma> };
    my regex lma { $a $a };
    ok '23' !~~ m/ ^ <la> $ /, 'can detect a non-match with :let';
    #?rakudo todo "unsuccessful match preserves :let value"
    is $a, 1, 'unsuccessful match did not affect :let variable';

    ok '55' ~~ m/ ^ <la> $ /, 'can match changed :let variable';
    is $a, 5, 'successful match preserves new :let value';
}

# RT #121229
{
    ok "+123.456e10" ~~ rx {
        :my token SIGN { <[+-]> }
        :my token MANTISSA { \d+ '.'? \d* | '.' \d+ }
        :my token EXPONENT { <[eE]> <SIGN>? \d+ }
        <SIGN>? <MANTISSA> <EXPONENT>?
    }, ":my terminates upon }\\n"
}
# vim: ft=perl6 sw=4 ts=4 expandtab
