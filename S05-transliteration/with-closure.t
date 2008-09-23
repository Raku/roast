use v6;
use Test;
plan 6;

# L<S05/Transliteration/"If the right side of the arrow is a closure">

my $x = 0;

is 'aXbXcXd'.trans('X' => { ++$x }), 'a1b2c3d', 'Can use a closure on the RHS';
is $x, 3,                                       'Closure executed three times';

$x = 0;
my $y = 0;
my $s = 'aXbYcYdX';
my %matcher = (
    X   => { ++$x },
    Y   => { ++$y },
);

is $s.trans(%matcher.pairs),        'a1b1c2d2', 'Can use two closures in trans';
is $s,                              'aXbYcYdX', 'Source string unchanged';

is $s.trans([<X Y>] => [{++$x},{++$y}], 'a1b1c2d2', 'can use closures in pairs of arrays';
is $s,                              'aXbYcYdX', 'Source string unchanged';
