use v6;
use Test;

plan 9;

# L<S11/"Compile-time Importation"/>

{
    use t::spec::packages::S11-modules::Foo;

    ok( &t::spec::packages::S11-modules::Foo::foo, 'Foo::foo is defined' );
    ok( &foo, 'Foo::foo is defined (explicitly :DEFAULT)' );
    is( foo(), 'Foo::foo', 'Foo::foo is the sub we expect' );

    ok( &bop, 'Foo::bop is defined (implicitly :DEFAULT)' );
    is( bop(), 'Foo::bop', 'Foo::bop is the sub we expect' );

    multi waz($x) { 'Foo::wazhere' }
    ok( &waz, 'Foo::waz multi is defined (implicitly :DEFAULT)' );
    is( waz(), 'Foo::waz', 'Foo::waz is the sub we expect' );
    is( waz(1), 'Foo::wazhere', 'Foo::waz imported does not wipe out our other waz multis' );
}

#?rakudo skip 'Importation is currently not lexical'
ok( ! &foo,
    'Foo::foo is undefined in outer scope' );
