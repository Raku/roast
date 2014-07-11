use v6;
use Test;
plan 6;

# L<S04/The Relationship of Blocks and Declarations/"If you declare a lexical 
#  twice in the same scope">

eval_lives_ok 'my $x; my $x', 
              'it is legal to declare my $x twice in the same scope.';

eval_lives_ok 'state $x; state $x', 
              'it is legal to declare state $x twice in the same scope.';

{
    my $x = 2;
    my $y := $x;
    my $x = 3;
    is $y, 3, 'Two lexicals with the name in same scope are the same variable';
}

# this is not exactly S04 material
eval_dies_ok 'sub foo {1; }; sub foo($x) {1; };',
             'multiple declarations need multi or proto';

eval_dies_ok 'only sub foo {1; }; sub foo($x) {1; };',
             'multiple declarations need multi or proto';

#?niecza todo "MMD"
#?rakudo todo 'nom regression'
eval_lives_ok 'proto foo {1; }; sub foo {1; }; sub foo($x) {1; };',
             'multiple declarations need multi or proto';

# vim: ft=perl6
