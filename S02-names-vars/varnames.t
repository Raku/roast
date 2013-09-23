use v6;

use Test;

plan 8;

# L<S02/Names and Variables/special variables of Perl 5 are going away>

eval_lives_ok 'my $!', '$! can be declared again';
eval_lives_ok 'my $/', 'as can $/';

#?niecza todo
eval_lives_ok 'my proto $!', '$! can be declared again if proto is used though';
#?niecza todo
eval_lives_ok 'my proto $/', 'as can $/';

eval_dies_ok 'my $f!ao = "beh";', "normal varnames can't have ! in their name";
eval_dies_ok 'my $fo:o::b:ar = "bla"', "var names can't have colons in their names either";

#?pugs skip "Can't modify constant item: VObject"
{
    class MyMatch {
        method postcircumfix:<[ ]>($x) {  # METHOD TO SUB CASUALTY
            "foo$x";
        }
    }
    $/ := MyMatch.new;
    #?rakudo 2 skip "cannot easily override [] at the moment"
    is $0, 'foo0', 'Aliasing of $0 into $/ (1)';
    is $4, 'foo4', 'Aliasing of $0 into $/ (2)';
}


# vim: ft=perl6
