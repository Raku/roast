use v6;
use Test;
plan 19;

#L<S03/Smart matching/Signature-signature>
{
    my @tests=
        (:(Int),                                    :(Int),                     True,
         :(Int, Str),                               :(Int),                     False,
         :(Int, Str $?),                            :(Int),                     True,
         :(Any),                                    :(Str),                     True,
         :(*@_),                                    :(Int, Rat, &),             True,
#         :(:a(:b(:c($x)))),                         :(:a($x), :b($y)),          False,
         :(:a(:b(:c($x)))),                         :(:a($x)),                  True,
         :(Any $x ($l, Int $r)),                    :(Int $x ($y, Str $z)),     False,
         :(:x($r) (Str $g, Any $i)),                :(:x($t) (Int $f, Any $k)), False,
         :(:x($r) (Str $g, Any $i)),                :(:x($t) (Str $f, Str $k)), True,
         :(Int @x, Any $b, Rat $n?, *@_),           :(Int @, Str $, Rat, Str),  True,
         :(Str $a, Str $b),                         :(Str $a, Str $b?),         False,
         :(Any $x, :$foo!),                         :(Any $, :$foo),            False,
         :(Int, *%_),                               :(Int, Any :$x!, Str :$y),  True,
         :([Any, Str, Numeric]),                    :(@ (Complex, Str, Int)),   True,
         :(Complex $z, :$x, :$y, :$q),              :(Complex, *%rest),         False,
         :(:$x, Int :$y, Cool :$z, *%_),            :(*%_),                     False,
         :(Mu, Any, Numeric),                       :(Mu, *@_),                 False,
        );

    for @tests -> $s1, $s2, $res {
        is(($s2 ~~ $s1), $res, "{$s2.perl} ~~ {$s1.perl}");
    }

    #?rakudo skip "Parametric types"
    #?niecza skip "Parametric types"
    # Can't deal with parameters.
    ok (:(::T $x, T $y) R~~ :(Str $y, Str $z)), "Parametric types";
    #?rakudo skip "Code params with signatures"
    # No support for code params with signatures yet.
    ok (:(&foo(Str --> Bool)) R~~ :(&bar(Str --> Bool))),
        "Code params with signatures";
}

# vim: ft=perl6
