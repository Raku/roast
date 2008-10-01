use v6;

use Test;

=begin description

=head1 indirect object notation call tests

These tests are the testing for "Method" section of Synopsis 12

L<S12/Methods/Indirect object notation now requires a colon after the invocant if there are no arguments>

=end description

plan 7;


##### Without arguments
class T1
{
    method a
    {
        'test';
    }
}

{
    my T1 $o .= new;
    ok( "Still alive after new" );

    is( $o.a(), 'test', "The indirect object notation call without argument 1" );
#?rakudo skip 'unimpl parse error near $o:'
    is( (a $o:), 'test', "The indirect object notation call without arguments 2" );
}

##### With arguments
class T2
{
    method a( $x )
    {
        $x;
    }
}

{
    my T2 $o .= new;
    ok( "Still alive after new" );
    my $seed = 1000.rand;
    is( $o.a( $seed ), $seed, "The indirect object notation call with argument 1" );
#?rakudo skip 'unimpl parse error near $o:'
    is( (a $o: $seed), $seed, "The indirect object notation call with arguments 2" );
    my $name = 'a';
    eval_dies_ok('$name $o: $seed', 'Indirect object notation and indirect method calls cannot be combined');
}
