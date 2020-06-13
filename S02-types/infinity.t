use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 21;

# L<S02/"Infinity and C<NaN>" /Raku by default makes standard IEEE floating point concepts visible>

{
    my $x = Inf;

    ok( $x == Inf  , 'numeric equal');
    ok( $x eq 'Inf', 'string equal');
}

{
    my $x = -Inf;
    ok( $x == -Inf,   'negative numeric equal' );
    ok( $x eq '-Inf', 'negative string equal' );
}

#?rakudo skip 'integer Inf'
# https://github.com/Raku/old-issue-tracker/issues/520
{
    my $x = Inf.Int;
    ok( $x == Inf,   'int numeric equal' );
    ok( $x eq 'Inf', 'int string equal' );
}

#?rakudo skip 'integer -Inf'
# https://github.com/Raku/old-issue-tracker/issues/520
{
    my $x = ( -Inf ).Int;
    ok( $x == -Inf,   'int numeric equal' );
    ok( $x eq '-Inf', 'int string equal' );
}

# Inf should == Inf. Additionally, Inf's stringification (~Inf), "Inf", should
# eq to the stringification of other Infs.
# Thus:
#     Inf == Inf     # true
# and:
#     Inf  eq  Inf   # same as
#     ~Inf eq ~Inf   # true

ok truncate(Inf) ~~ Inf,    'truncate(Inf) ~~ Inf';

# https://github.com/Raku/old-issue-tracker/issues/520
{
    fails-like {    Inf.Int }, X::Numeric::CannotConvert,
        'attempting to convert Inf to Int throws';

    fails-like { (-Inf).Int }, X::Numeric::CannotConvert,
        'attempting to convert Inf to Int throws';

    fails-like {      ∞.Int }, X::Numeric::CannotConvert,
        'attempting to convert ∞ to Int throws';

    fails-like {   (-∞).Int }, X::Numeric::CannotConvert,
        'attempting to convert -∞ to Int throws';

    fails-like {    NaN.Int }, X::Numeric::CannotConvert,
        'attempting to convert NaN to Int throws';
}

# https://github.com/Raku/old-issue-tracker/issues/1409
{
    ok ( rand * Inf ) === Inf, 'multiply rand by Inf without maximum recursion depth exceeded';
}

# https://github.com/Raku/old-issue-tracker/issues/4903
{
    throws-like ｢my Int $x = Inf｣, X::Syntax::Number::LiteralType,
        :value(Inf), :vartype(Int),
    'trying to assign Inf to Int gives a helpful error';

    my Num $x = Inf;
    is $x, Inf, 'assigning Inf to Num works without errors';
}

# https://github.com/Raku/old-issue-tracker/issues/5759
{
    is-deeply -Inf², -Inf, '-Inf² follows mathematical order of operations';
    is-deeply -∞², -Inf, '-∞² follows mathematical order of operations';
    is-deeply −Inf², -Inf,
        '−Inf² follows mathematical order of operations (U+2212 minus)';
    is-deeply −∞², -Inf,
        '−∞² follows mathematical order of operations (U+2212 minus)';
}

# vim: expandtab shiftwidth=4
