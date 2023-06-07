use Test;
plan 38;

#L<S03/Smart matching/Signature-signature>
{
    my @tests=
        (:(Int),                                    :(Int),                     True,
         :(Int, Str),                               :(Int),                     False,
         :(Int, Str $?),                            :(Int),                     True,
         :(Any),                                    :(Str),                     True,
         :(*@_),                                    :(Int, Rat, &),             True,
         :(:a(:b(:c($x)))),                         :(:a($x), :b($y)),          False,
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
         :(:$x, *%_),                               :(:$x, *%_),                True,
         :(Mu, Any, Numeric),                       :(Mu, *@_),                 False,
         :($),                                      :($ ($, $)),                True,
         :($),                                      :(Int $ ($, $)),            True,
         :(Int $ ($, $)),                           :($ ($, $)),                False,
         :(*@),                                     :($ ($, $)),                True,
         :(|),                                      :($ ($, $)),                True,
         :(:$),                                     :(:$ ($, $)),               True,
         :(:$),                                     :(Int :$ ($, $)),           True,
         :(Int :$ ($, $)),                          :(:$ ($, $)),               False,
         :(*%),                                     :(:$ ($, $)),               True,
         :(|),                                      :(:$ ($, $)),               True,
         :(:$b ($, $)),                             :(:$a ($, $)),              False,
        );

    for @tests -> $s1, $s2, $res {
        is(($s2 ~~ $s1), $res, "{$s2.raku} ~~ {$s1.raku}");
    }

    #?rakudo skip "Parametric types"
    # Can't deal with parameters.
    ok (:(::T $x, T $y) R~~ :(Str $y, Str $z)), "Parametric types";

    ok (:(&foo:(Str --> Bool)) ~~ :(&bar:(Str --> Bool))),
        "Code params with signatures";

    nok (:(&foo:(Int --> Bool)) ~~ :(&bar:(Str --> Bool))),
        "Code params with different signature parameters doesn't match";

    nok (:(&foo:(Int --> Bool)) ~~ :(&bar:(Int --> Str))),
        "Code params with different signature return types doesn't match";

    # https://github.com/Raku/old-issue-tracker/issues/5028
    nok :(Int --> Int) ~~ :(), 'Can smartmatch against empty signature (False)';
    nok :() ~~ :(Int ), 'Can smartmatch an empty signature (False)';
    ok :() ~~ :(), 'Can smartmatch against empty signature (True)';

    ok none((
        :($T? is raw),
        :($T? is raw = Mu),
        :($T? is raw where $T =:= $T.WHAT = Mu),
        :(:$T? is raw),
        :(:$T? is raw = Mu),
        :(:$T? is raw where $T =:= $T.WHAT = Mu)
    ) X~~ :()), 'Optional parameters do not get dropped in a smartmatch';
}

# vim: expandtab shiftwidth=4
