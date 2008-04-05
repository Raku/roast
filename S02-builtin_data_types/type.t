use v6-alpha;
use Test;

=begin description

Basic tests about variables having built-in types assigned

=end description

# L<S02/"Built-In Data Types"/"A variable's type is a constraint indicating what sorts">

plan 8;

ok(try{my Int $foo; 1}, 'compile my Int $foo');
ok(try{my Str $bar; 1}, 'compile my Str $bar');

ok(do{my Int $foo; $foo ~~ Int}, 'Int $foo isa Int');
ok(do{my Str $bar; $bar ~~ Str}, 'Str $bar isa Str');

my Int $foo;
my Str $bar;

#?pugs 1 todo 
is(try{$foo = 'xyz'}, undef, 'Int restricts to integers');
is(try{$foo = 42},    42,    'Int is an integer');
#?pugs 1 todo 
is(try{$bar = 42},    undef, 'Str restricts to strings');
is(try{$bar = 'xyz'}, 'xyz', 'Str is a strings');

