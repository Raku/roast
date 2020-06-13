use v6;

use Test;

plan 28;

# Undeterminate Math results
# see L<"http://mathworld.wolfram.com/Indeterminate.html">
# L<S02/"Infinity and C<NaN>" /Raku by default makes standard IEEE floating point concepts visible>

is 0 * Inf  , NaN, "0 * Inf";
is Inf / Inf, NaN, "Inf / Inf";
is Inf - Inf, NaN, "Inf - Inf";
# https://github.com/Raku/old-issue-tracker/issues/3804
is NaN ** 0,  1, "NaN ** 0";

is 0**0     , 1, "0**0 is 1, _not_ NaN";
is Inf**0   , 1, "Inf**0 is 1, _not_ NaN";

ok NaN ~~ NaN, 'NaN is a NaN';
nok 4 ~~ NaN, '4 is not a NaN';
nok 4.Num ~~ NaN, "4.Num is not a NaN";

isa-ok NaN + 1i, Complex, "NaN + 1i is a Complex number";
ok NaN + 1i ~~ NaN, "NaN + 1i ~~ NaN";
ok NaN ~~ NaN + 1i, "NaN ~~ NaN + 1i";

isa-ok (NaN)i, Complex, "(NaN)i is a Complex number";
ok (NaN)i ~~ NaN, "(NaN)i ~~ NaN";
ok NaN ~~ (NaN)i, "NaN ~~ (NaN)i";

ok (NaN)i ~~ NaN + 1i, "(NaN)i ~~ NaN + 1i";
ok NaN + 1i ~~ (NaN)i, "NaN + 1i ~~ (NaN)i";

ok truncate(NaN) ~~ NaN, 'truncate(NaN) ~~ NaN';

# https://github.com/Raku/old-issue-tracker/issues/2557
is NaN.raku, 'NaN', 'NaN perlification ok';

# https://github.com/Raku/old-issue-tracker/issues/2357
ok NaN===NaN, "NaN value identity";
ok (my num $ = NaN) === (my num $ = NaN), "NaN value identity (native num)";

# https://github.com/Raku/old-issue-tracker/issues/4903
{
    throws-like ｢my Int $x = NaN｣, X::Syntax::Number::LiteralType,
        :value(NaN), :vartype(Int),
    'trying to assign NaN to Int gives a helpful error';

    my Num $x = NaN;
    is $x, NaN, 'assigning NaN to Num works without errors';
}

# https://github.com/Raku/old-issue-tracker/issues/5576
{
    my $mynan = my class MyNum is Num {}.new(NaN);
    is-deeply $mynan == NaN,  False, 'sublcass of NaN !== NaN';
    is-deeply $mynan === NaN, False, 'sublcass of NaN !=== NaN';
}

# https://irclog.perlgeek.de/perl6/2017-01-20#i_13959538
{
    my $a = NaN;
    my $b = NaN;
    is-deeply $a eqv $b,   True, 'NaN eqv NaN when stored in variables';
    is-deeply NaN eqv NaN, True, 'NaN eqv NaN when using literals';
    is-deeply (my num $ = NaN) eqv (my num $ = NaN), True,
        'NaN eqv NaN when using native nums';
}

# vim: expandtab shiftwidth=4
