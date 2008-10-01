use v6;
use Test;

plan 1;

# L<S11/"Exportation"/>

use Foo;

is( &Foo::foo, &Foo::EXPORT::ALL::foo, '&Foo::foo bound to ::EXPORT::ALL inner module' );

