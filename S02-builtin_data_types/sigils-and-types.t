use v6;

use Test;



=begin pod

XXX These should go in Prelude.pm but if defined there they are not visible
no matter if they are declared as builtin, export, primitive or combinations of the three.


role Positional is builtin {
  multi postcircumfix:<[ ]> {...}
}

role Abstraction is builtin {
  # TODO fill me (no defined methods in S02)
}

role Associative is builtin {
  multi postcircumfix:<{ }> {...}
}

role Callable is builtin {
  multi postcircumfix:<( )> {...}
}

# This classes actually have a definition outside of Prelude 
but this definition does not include declaration of sigil traits.
 
class List does Positional ;

class Capture does Positional does Associative;

class Hash does Associative;
class Pair does Associative;
class Set does Associative;

class Class does Abstraction;
class Role does Abstraction;
class Package does Abstraction;
class Module does Abstraction;

class Code does Callable;


=end pod

plan 38;

my $scalar;
ok $scalar.does(Object), 'unitialized $var does Object';
$scalar = 1;
ok $scalar.does(Object), 'value contained in a $var does Object';



my @array;
ok @array.does(Positional), 'unitialized @var does Positional';
my @array = [];
ok @array.does(Positional), 'value contained in a @var does Positional';
my @array = 1;
ok @array.does(Positional), 'generic val in a @var is converted to Positional';

for <List Seq Range Buf Capture> -> $c {
    ok eval($c).does(Positional), "$c does Positional";
}

my %hash;
ok %hash.does(Associative), 'uninitialized %var does Associative', :todo<feature>;
%hash = {};
ok %hash.does(Associative), 'value in %var does Associative';

for <Pair Mapping Set Bag KeyHash Capture> -> $c {
  if eval('$c') {
    ok $c.does(Associative), "$c does Associative";
  }
}

ok Class.does(Abstraction), 'a class is an Abstraction';
ok Positional.does(Abstraction), 'a Role is an Abstraction';
ok ::Main.does(Abstraction), 'a Package is an abstraction';
ok eval {$?GRAMMAR.does(Abstraction)}, 'a Grammar is an abstraction';
ok $?MODULE.does(Abstraction), 'a Module is an abstraction';

sub foo {}
ok &foo.does(Callable), 'a Sub does Callable';
#?rakudo skip 'method outside class - fix test?'
{
method meth {}
ok &meth.does(Callable), 'a Method does Callable';
}
multi mul {}
ok &mul.does(Callable), 'a multi does Callable';
proto pro {}
ok &pro.does(Callable), 'a proto does Callable';

# &token, &rule return a Method?
token bar {<?>}
ok &bar.does(Callable), 'a token does Callable', :todo<feature>;
rule baz {<?>}
ok &baz.does(Callable), 'a rule does Callable', :todo<feature>;
# &quux returns a Sub ?
macro quux {}
ok &quux.does(Callable), 'a rule does Callable', :todo<feature>;
