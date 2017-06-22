use v6;

use Test;

plan 12;

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

# RT #130891
{
    subtest 'infix:<∘> preserves .count and .arity of RHS' => {
        plan 5;
        my &one = sub ($a --> Str) { $a.uc } ∘ sub { "$^a:$^b" };
        is-deeply &one.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&one).List,
            ("A:B", "C:D", "E:F", "G:H"),
            'can 2-at-a-time map with a composed routine';

        my &two = sub { $^a.flip } ∘ &one;
        is-deeply <a b c d e f g h>.map(&two).List,
            ("B:A", "D:C", "F:E", "H:G"),
            'can 2-at-a-time map with a double-composed routine';

        my &grepper = sub { $^a.not } ∘ sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&grepper).List, ((2, 3), (4, 5)),
            'can 2-at-a-time grep with a composed routine';

        is-deeply ([∘] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            'Can use infix:<∘> as a meta';
    }

    subtest 'infix:<o> preserves .count and .arity of RHS' => {
        plan 5;
        my &one = sub ($a --> Str) { $a.uc } o sub { "$^a:$^b" };
        is-deeply &one.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&one).List,
            ("A:B", "C:D", "E:F", "G:H"),
            'can 2-at-a-time map with a composed routine';

        my &two = sub { $^a.flip } o &one;
        is-deeply <a b c d e f g h>.map(&two).List,
            ("B:A", "D:C", "F:E", "H:G"),
            'can 2-at-a-time map with a double-composed routine';

        my &grepper = sub { $^a.not } o sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&grepper).List, ((2, 3), (4, 5)),
            'can 2-at-a-time grep with a composed routine';

        is-deeply ([o] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            'Can use infix:<o> as a meta';
    }
}
