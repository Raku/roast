use v6;
use Test;

plan 1;

# L<S11/"Exportation"/>

use t::spec::S11-modules::Foo;

ok( &Foo::foo =:= &Foo::EXPORT::ALL::foo, '&Foo::foo bound to ::EXPORT::ALL inner module' );

