use v6;
use Test;
plan 13;

# L<S02/"Built-In Data Types" /Perl 6 should by default make standard IEEE floating point concepts visible>

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

#?rakudo todo 'integer Inf'
{
    my $x = Inf.Int;
    ok( $x == Inf,   'int numeric equal' );
    ok( $x eq 'Inf', 'int string equal' );
}

#?rakudo todo 'integer Inf'
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

#?rakudo 4 todo 'truncate(Inf)'
ok truncate(Inf) ~~ Inf,    'truncate(Inf) ~~ Inf';
ok NaN.Int === NaN,         'Inf.Int === Int';
ok Inf.Int === Inf,         'Inf.Int === Int';
ok (-Inf).Int === (-Inf),   'Inf.Int === Int';

# RT #70730
{
    ok ( rand * Inf ) === Inf, 'multiply rand by Inf without maximum recursion depth exceeded';
}

# vim: ft=perl6
