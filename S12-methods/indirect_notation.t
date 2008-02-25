use v6-alpha;

use Test;

=kwid

=head1 indirect object notation call tests

These tests are the testing for "Method" section of Synopsis 12

L<S12/Methods/Indirect object notation now requires a colon after the invocant if there are no arguments>

=cut

plan 6;


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
my $seed = rand(1000);
is( $o.a( $seed ), $seed, "The indirect object notation call with argument 1" );
is( (a $o: $seed), $seed, "The indirect object notation call with arguments 2" );
}
