use v6;

use Test;

plan 10;

sub double ($x) { $x * 2 };
sub invert ($x) { 1 / $x };

is (&invert o &double)(0.25), 2, 'Basic function composition (1)';
is (&double o &invert)(0.25), 8, 'Basic function composition (2)';
is (&invert ∘ &double)(0.25), 2, 'Basic function composition (Unicode)';

{
    my &composed = *.join('|') o &infix:<xx>;
    is composed('a', 3), 'a|a|a', 'function composition with primed method';
}

is ((* + 1) o (* * 2))(3), 7, "can use WhateverCodes on both sides";
is (* o (* * 2))(* + 1)(3), 7, "can autocurry with Whatever on left side";
is ((* + 1) o *)(* * 2)(3), 7, "can autocurry with Whatever on right side";
is (* o *)(* + 1, * * 2)(3), 7, "can autocurry with Whatever on both sides";

is ((* + *) o { $_ + 7, $_ * 6 })(5), 42, "can compose functions that pass two arguments";
is ({ [+] @_ } o *.map(* * 2))(1..10), 110, "can compose functions that pass multiple arguments";
