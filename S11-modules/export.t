use v6;
use Test;

plan 1;

# L<S11/"Exportation"/>

sub foo is export(:DEFAULT) { 'foo' }


ok( &foo === &EXPORT::ALL::foo, '&Foo::foo bound to ::EXPORT::ALL inner module' );

