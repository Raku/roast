use v6;
use Test;
plan 10;

# L<S05/Transliteration/"If the right side of the arrow is a closure">

#?rakudo skip 'contigent on RT#59446'
{

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

is $s.trans([<X Y>] => [{++$x},{++$y}]), 'a3b3c4d4', 'can use closures in pairs of arrays';
is $s,                              'aXbYcYdX', 'Source string unchanged';

my $x = 0;
my $y = 0;

my $s2 = 'ABC111DEF111GHI';

is $s2.trans([<1 111>] => [{++$x},{++$y}]), 'ABC1DEF2GHI', 'can use closures in pairs of arrays';
is $s2,                              'ABC111DEF111GHI', 'Source string unchanged';
is $x, 0,                            'Closure not invoked (only longest match used)';
is $y, 2,                            'Closure invoked twice (once per replacement)';

};
