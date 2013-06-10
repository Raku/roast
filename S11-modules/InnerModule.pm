module InnerModule;
use v6;

sub foo is export(:DEFAULT) {'Inner::foo'}
sub bar is export {'Inner::bar'}
sub baz is export(:MANDATORY) {'Inner::baz'}
# sub qux is export(:sometag) {'Inner::qux'}
sub quux is export { 'Inner::quux' }
