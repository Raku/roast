use v6;
use Test;
plan 10;

=begin description

Test for 'subset' with a closure

=end description

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Even of Int where { $_ % 2 == 0 };

{
    my Even $x = 2;
    is $x, 2, 'Can assign value to a type variable with subset';
};

eval_dies_ok  'my Even $x = 3',
              "Can't assing value that violates type constraint via subst";

{
    ok 2 ~~ Even,  'Can smartmatch against subsets 1';
    ok 3 !~~ Even, 'Can smartmatch against subsets 2';
}

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Digit of Int where ^10;

{
    my Digit $x = 3;
    is  $x,     3,  "Can assign to var with 'subset' type constraint";
    $x = 0;
    is  $x,     0,  "one end of range";
    $x = 9;
    is  $x,     9,  "other end of range";
}

eval_dies_ok 'my Digit $x = 10',
             'type constraints prevents assignment 1';
eval_dies_ok 'my Digit $x = -1',
             'type constraints prevents assignment 2';
eval_dies_ok 'my Digit $x = 3.1',
             'original type prevents assignment';


# vim: ft=perl6
