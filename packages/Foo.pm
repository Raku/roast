use v6;


class Foo;

method foo { "foo" }

sub ucfirst($thing) is export(:DEFAULT) { 'overridden ucfirst' }
