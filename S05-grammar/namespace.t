use v6;
use Test;

plan 5;

# TODO: smart match against a grammar to get a Match object 
# isn't specced and will likely change; see
#
# http://rt.perl.org/rt3/Public/Bug/Display.html?id=58676
#
# http://irclog.perlgeek.de/parrot/2008-05-31#i_322527

=begin description

S05-Grammar namespace-related tests

=end description

=begin description

check that grammar and regex namespaces don't collide, RT #58678

=end description

grammar A {
    rule TOP {\d+};
};

my regex b {\d+};

isa_ok(A.WHAT, A, 'regex defined in separate namespace from grammar');

isa_ok(&b.WHAT, Regex, 'regex defined in separate namespace from grammar');

is('1245' ~~ &b, '1245', 'Match against regex');


=begin description

check that multi-jointed namespaces work with grammars

=end description

grammar Foo::Bar {
    token foo { foo }
}
is("foo" ~~ &Foo::Bar::foo, 'foo', 'regex in a namespace callable');

grammar Grammar::Deep { token foo { 'foo' }; }
grammar GrammarShallow { token TOP { <Grammar::Deep::foo> 'bar' }; }
ok('foobar' ~~ /<GrammarShallow::TOP>/, 'regex can call regex in nested namespace');

# vim: ft=perl6
