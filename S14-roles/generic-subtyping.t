use v6;

use Test;

role R1[Any ::T] { }

role R2[Cool ::T] is R1[T] { }

role R3[Stringy ::T] does R2[T] { }

role R4[Str ::T] does R2[T] is R3[T] { }

only infix:<checks>(Mu $a is raw, Mu $b is raw) is test-assertion {
    ok $a ~~ $b, "$a.raku() ~~ $b.raku()";
    nok $b ~~ $a, "$b.raku() !~~ $a.raku()";
}

plan 2;

subtest 'subtyped generic roles can typecheck', {
    plan 14 * 2;

    R2[Str] checks R2;
    R2[Str] checks R1;
    R2[Str] checks R1[Any];
    R2[Str] checks R2[Cool];
    R3[Str] checks R1;
    R3[Str] checks R1[Any];
    R3[Str] checks R3[Stringy];
    R4[Allomorph] checks R3;
    R4[Allomorph] checks R2;
    R4[Allomorph] checks R1;
    R4[Allomorph] checks R1[Any];
    R4[Allomorph] checks R2[Cool];
    R4[Allomorph] checks R3[Stringy];
    R4[Allomorph] checks R4[Str];
};

lives-ok({ EVAL Q:to/ROLE/ }, 'can lookup generic doees of a role before they get composed');
multi trait_mod:<is>(Mu:U \T, :roled($)!) { T.^roles[0].^roles }
role R5[Int ::T] does R2[T] is roled { }
ROLE

# vim: expandtab shiftwidth=4
