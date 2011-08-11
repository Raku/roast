use v6;

use Test;

plan 3;
# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>

class Foo {
    has $.v;
    submethod BUILD (Str :$value) {
        $!v = $value;
    }
}

my $obj = Foo.new( value => 'bar' );

is( $obj.v, 'bar', 
    'BUILD arg declared as named and invoked with literal pair should'
    ~ ' contain only the pair value' );
isa_ok($obj.v, Str, 'same arg should be of declared type' );
isa_ok($obj, Foo, 'The object was constructed of the right type');

# vim: ft=perl6
