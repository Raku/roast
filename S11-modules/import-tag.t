use v6;

use lib $?FILE.IO.parent(2).child("packages");

use Test;

plan 12;

# L<S11/"Compile-time Importation"/>

{
    use S11-modules::Foo :others;

    dies-ok { EVAL 'foo()' }, 'foo() not imported - not tagged :others';

    ok( &bar, 'Foo::bar is defined (explicitly :DEFAULT and :others)' );
    is( bar(), 'Foo::bar', 'Foo::bar is the sub we expect' );

    ok( &baz, 'Foo::baz is defined (:MANDATORY)' );
    is( baz(), 'Foo::baz', 'Foo::baz is the sub we expect' );

    dies-ok { EVAL 'bop()' }, 'bop() not imported';

    ok( &qux, 'Foo::qux is defined (explicitly :others)' );
    is( qux(), 'Foo::qux', 'Foo::qux is the sub we expect' );

    dies-ok { EVAL 'waz()' }, 'waz() not imported';

    ok( &gaz, 'Foo::gaz multi is defined (implicitly :others)' );
    is( gaz(), 'Foo::gaz1', 'Foo::gaz is the sub we expect' );
    is( gaz(1), 'Foo::gaz2', 'Foo::gaz($x) is the sub we expect' );
    
}

# vim: ft=perl6
