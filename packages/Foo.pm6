use v6;


unit class Foo;

method foo { "foo" }

sub ucfirst($thing) is export(:DEFAULT) { 'overridden ucfirst' }   #OK not used
sub dies() is export { die 'Death from class Foo' }
