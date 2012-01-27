use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/der_grammar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 28;

grammar Other {
    regex abc { a (<.bee>) c }

    regex bee { b }

    regex def { d <eh> f }

    regex eh  { e }
}

grammar Another is Other { };

grammar Yet::Another is Another {

    regex bee { B }

    regex def { D <eh> F }
};

# Test derivation and Liskov substitutability...

ok 'abc' ~~ m/ ^ (<Another::abc>) $ /, '<Another::abc>' ;

is(~$/, "abc", 'abc $/');
is(~$0, "abc", 'abc $0');

ok('abc' ~~ m/ (<Another::bee>) /, '<Another::bee>');
is(~$/, "b", 'bee $/');
is(~$0, "b", 'bee $0');

ok('b' ~~ m/ (<Another::bee>) /, '<Another::bee>');

ok('def' ~~ m/^ (<Another::def>) $/, '(<Another::def>)');
is(~$/, "def", 'def $/');
is(~$0, "def", 'def $0');

ok('def' ~~ m/^ <.Another::def> $/, '<.Another::def>');
is(~$/, "def", '.def $/');
ok($0 ne "def", '.def $0');


# Test rederivation and polymorphism...

ok('aBc' ~~ m/^ (<Yet::Another::abc>) $/, '<Yet::Another::abc>');
is(~$/, "aBc", 'abc $/');
is(~$0, "aBc", 'abc $0');

ok('abc' !~~ m/ (<Yet::Another::bee>) /, 'abc <Yet::Another::bee>');
ok('aBc' ~~ m/ (<Yet::Another::bee>) /, 'aBc <Yet::Another::bee>');
is(~$/, "B", 'Yet::Another::bee $/');
is(~$0, "B", 'Yet::Another::bee $0');

ok('def' !~~ m/^ (<Yet::Another::def>) $/, 'def (<Yet::Another::def>)');
ok('DeF' ~~ m/^ (<Yet::Another::def>) $/, 'DeF (<Yet::Another::def>)');
is(~$/, "DeF", 'DeF $/');
is(~$0, "DeF", 'DeF $0');

ok('DeF' ~~ m/^ <.Yet::Another::def> $/, '<?Yet::Another::def>');
is(~$/, "DeF", '.Yet::Another.def $/');


# Non-existent rules...

eval_dies_ok q{ 'abc' ~~ m/ (<Another.sea>) /  }, '<Another.sea>';

# RT #63466
{
    #?rakudo todo 'RT #63466'
    eval_dies_ok q{ 'x' ~~ / <No::Such::Rule> / },
            'match against No::Such::Rule dies';
}

# vim: ft=perl6
