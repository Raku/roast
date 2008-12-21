use v6;
use Test;
plan 8;

# L<S02/"Built-In Data Types" /Perl 6 should by default make standard IEEE floating point concepts visible>

{
    my $x = Inf;

    ok( $x == Inf  , 'numeric equal');
    #?rakudo skip 'Inf stringification'
    ok( $x eq 'Inf', 'string equal');
}

{
    my $x = -Inf;
    ok( $x == -Inf,   'negative numeric equal' );
    #?rakudo skip 'Inf stringification'
    ok( $x eq '-Inf', 'negative string equal' );
}

#?rakudo todo 'integer Inf'
{
    my $x = int( Inf );
    ok( $x == Inf,   'int numeric equal' );
    ok( $x eq 'Inf', 'int string equal' );
}

#?rakudo todo 'integer Inf'
{
    my $x = int( -Inf );
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
