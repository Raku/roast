use v6;
use Test;
plan 16;

# L<S05/Transliteration/"If the right side of the arrow is a closure">

my $x = 0;

is 'aXbXcXd'.trans('X' => { ++$x }), 'a1b2c3d', 'Can use a closure on the RHS';
#?rakudo todo 'nom regression'
#?niecza todo 'Closure executed three times'
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

#?rakudo todo 'nom regression'
#?niecza todo 'can use closures in pairs'
is $s.trans([<X Y>] => [{++$x},{++$y}]), 'a3b3c4d4', 'can use closures in pairs of arrays';
is $s,                              'aXbYcYdX', 'Source string unchanged';

$x = 0;
$y = 0;

my $s2 = 'ABC111DEF111GHI';

is $s2.trans([<1 111>] => [{++$x},{++$y}]), 'ABC1DEF2GHI', 'can use closures in pairs of arrays';
is $s2,                              'ABC111DEF111GHI', 'Source string unchanged';
is $x, 0,                            'Closure not invoked (only longest match used)';
#?rakudo todo 'nom regression'
#?niecza todo 'Closure invoked twice'
is $y, 2,                            'Closure invoked twice (once per replacement)';

{
    # combined regex / closure
    my $count = 0;
    is 'hello'.trans(/l/ => { ++$count }), 'he12o', 'regex and closure mix';
    #?rakudo todo 'nom regression'
    #?niecza todo 'regex and closure mix (with $/ as topic)'
    is 'hello'.trans(/l/ => { $_ x 2 }), 'hellllo', 'regex and closure mix (with $/ as topic)';
    my $x = 'hello';
    #?rakudo todo 'nom regression'
    #?niecza todo 'regex and closure mix (with $/ as topic and capture)'
    is $x.trans(/(l)/ => { $_[0] x 2 }), 'hellllo', 'regex and closure mix (with $/ as topic and capture)';
    is $x, 'hello', 'Original string not modified';
}

my $orig = 'hello'; 
#?rakudo skip 'Unable to resolve method ord in class Any'
#?niecza skip 'Unable to resolve method ord in class Any'
is $orig.trans(/(l)/ => { $_[0].ord }), 'he108108o', 'capturing regex + closure with .ord on $_';
is $orig, 'hello', 'original string unchanged';

# vim: ft=perl6
