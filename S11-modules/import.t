use v6;
use Test;

plan 4;

# L<S11/"Compile-time Importation"/>

{
    use t::spec::packages::S11-modules::Foo;

    ok( &t::spec::packages::S11-modules::Foo::foo, 'Foo::foo is defined' );
    ok( &foo, 'Foo::foo is defined' );
    is( foo(), 'Foo::foo', 'Foo::foo is the sub we expect' );

}

ok( ! &foo,
    'Foo::foo is undefined in outer scope' );

