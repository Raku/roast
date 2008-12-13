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

regex B {\d+};

is(A.WHAT, 'A', 'regex defined in separate namespace from grammar');

is('12345' ~~ A, '12345', 'Match against grammar');

#?rakudo todo 'Regex not implemented as separate class yet'
is(&B.WHAT, 'Regex', 'regex defined in separate namespace from grammar');

is('1245' ~~ &B, '1245', 'Match against regex');


=begin description

check that multi-jointed namespaces work with grammars

=end description

grammar Foo::Bar {
    token foo { foo }
}
is("foo" ~~ &Foo::Bar::foo, 'foo', 'regex in a namespace callable');
