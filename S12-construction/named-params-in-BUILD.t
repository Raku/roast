use v6;

use Test;

plan 4;
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
isa-ok($obj.v, Str, 'same arg should be of declared type' );
isa-ok($obj, Foo, 'The object was constructed of the right type');

# https://github.com/Raku/old-issue-tracker/issues/5216
#?rakudo.jvm skip 'Native attributive binding not yet implemented (in submethod BUILD)'
#?DOES 1
{
  subtest 'can bind to native type attributes in build methods' => {
    plan 4;

    my class RT127845 {
        has num32 $.a;
        has num   $.b;
        has uint8 $.x;
        has int   $.y;
        submethod BUILD(uint8 :$!x, :$!b) { }
        submethod TWEAK(num32 :$!a, :$!y) { }
    }

    my $o := RT127845.new: :a(2e0), :b(3e-1), :5x, :6y;

    is-deeply $o.x, 5,    'can bind to native type attributes in signature of BUILD (1)';
    is-deeply $o.b, 3e-1, 'can bind to native type attributes in signature of BUILD (2)';
    is-deeply $o.y, 6,    'can bind to native type attributes in signature of TWEAK (1)';
    is-deeply $o.a, 2e0,  'can bind to native type attributes in signature of TWEAK (2)';
  }
}

# vim: expandtab shiftwidth=4
