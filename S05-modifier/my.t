use v6;
use Test;
plan 24;

# L<S05/Modifiers/Any grammar regex is really just a kind of method>

grammar DeclaratorTest1 {
    token TOP {
        || a <a>
        || b <b>
        || c <c>
        || d <d>
    }
    token a {
        :constant $x = 'foo';
        $x
    }
    token b {
        :my $y = ' yack';
        $y $y
    }
    token c {
        :state $z++;
        $z
    }
    token d {
        :our $our = 'zho';
        $our
    }
}

ok DeclaratorTest1.parse( 'afoo' ), 'can declare :constant in regex';
is ~$/, 'afoo', '... and it matched the constant';
ok !DeclaratorTest1.parse( 'abar' ), 'does not work with wrong text';

ok DeclaratorTest1.parse( 'b yack yack' ), 'can declare :my in regex';
is ~$/, 'b yack yack', 'correct match with "my" variable';
ok !DeclaratorTest1.parse('b yack shaving'), 'does not work with wrong text';

ok DeclaratorTest1.parse('c1'), ':state in regex (match) (1)';
is ~$/, 'c1', ':state in regex ($/) (1)';

ok DeclaratorTest1.parse('c2'), ':state in regex (match) (2)';
is ~$/, 'c2', ':state in regex ($/) (2)';
ok !DeclaratorTest1.parse('c3'), ':state in regex (no match)';

ok DeclaratorTest1.parse('dzho'), ':our in regex (match)';
is ~$/, 'dzho', ':our in regex ($/)';

is $DeclaratorTest1::our, 'zho', 'can access our variable from the outside';

{
    my $a = 1;
    regex ta { :temp $a = 5; <ma> };
    regex ma { $a $a };
    ok '11'  ~~ m/ ^ <ma> $ /, "can access variables in regex (not temp'ed)";
    ok '55' !~~ m/ ^ <ma> $ /, "(-) not temp'ed";
    is $a, 1, "temp'ed variable still 1";

    ok '55'  ~~ m/ ^ <ta> $ /, "can access temp'ed variable in regex (+)";
    ok '11' !~~ m/ ^ <ta> $ /, "(-) temp'ed";
    is $a, 1, "temp'ed variable again 1";
}

{
    my $a = 1;
    regex la { :let $a = 5; <lma> };
    regex lma { $a $a };
    ok '23' !~~ m/ ^ <la> $ /, 'can detect a non-match with :let';
    is $a, 1, 'unsuccessful match did not affect :let variable';

    ok '55' ~~ m/ ^ <la> $ /, 'can match changed :let variable';
    is $a, 5, 'successful match preserves new :let value';
}
# vim: ft=perl6 sw=4 ts=4 expandtab
