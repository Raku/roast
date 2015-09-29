use v6;

use Test;

plan 4;

sub double ($x) { $x * 2 };
sub invert ($x) { 1 / $x };

is (&invert o &double)(0.25), 2, 'Basic function composition (1)';
is (&double o &invert)(0.25), 8, 'Basic function composition (2)';
is (&invert ∘ &double)(0.25), 2, 'Basic function composition (Unicode)';

#?rakudo skip 'function composition with more-than-one-arg functions'
{
    my &composed = *.join('|') o &infix:<xx>;
    is composed('a', 3), 'a|a|a', 'function composition with primed method';
}
