use v6;

use Test;

plan 13;

# L<S02/Names and Variables/special variables of Perl 5 are going away>

lives_ok { EVAL 'my $!' },
  '$! can be declared again';
lives_ok { EVAL 'my $/' },
  'as can $/';

#?rakudo skip 'NYI'
dies_ok { EVAL '$/ = "foo"' },
  'S05: Perl 6\'s $/ variable may not be assigned to directly.';

#?niecza todo
lives_ok { EVAL 'my proto $!' },
  '$! can be declared again if proto is used though';
#?niecza todo
lives_ok { EVAL 'my proto $/' },
  'as can $/';

throws_like { EVAL 'my $f!ao = "beh";' },
  X::AdHoc,
  "normal varnames can't have ! in their name";
throws_like { EVAL 'my $fo:o::b:ar = "bla"' },
  X::Syntax::Confused,
  "var names can't have colons in their names either";

{
    throws_like "my Int a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws_like "my Int a;", X::Syntax::Malformed, message => / sigilless /;
    throws_like "my a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws_like "my a;", X::Syntax::Malformed, message => / sigilless /;
}

{
    class MyMatch {
        method postcircumfix:<[ ]>($x) {  # METHOD TO SUB CASUALTY
            "foo$x";
        }
    }
    $/ := MyMatch.new;
    #?rakudo 2 todo "cannot easily override [] at the moment"
    is $0, 'foo0', 'Aliasing of $0 into $/ (1)';
    is $4, 'foo4', 'Aliasing of $0 into $/ (2)';
}

# vim: ft=perl6
