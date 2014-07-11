use v6;

use Test;

plan 5;

# L<S05/"Matching against non-strings">

# String-like things...

my $fh = open($?FILE);
regex monster { dr\wgon }; # contrived pattern which does not match itself; we're going to look for it in this file
regex cheese { camembert | cheddar  };
my $stream:= cat $fh.lines;

ok($stream ~~ /<cheese>/, 'rules on streams, positive'); # should match
ok($stream !~~ /<monster>/, 'rules on streams, negative'); # shouldn't match

# And arrays...

class Dog {...}
class Cat {...}
class Fish {...}

my Dog $a;
my Cat $b;
my Fish $c;

my @array = ($a, $b, $c);
regex canine { <.isa(Dog)> }
regex herbivore { <.isa(::Antelope)> }; 

# does that work? ord does it need a Cat?
ok(@array ~~ /<canine>/, 'rules on an array - positive');
ok(@array !~~ /<herbivore>/, 'rules on an array - negative');
# These seem to be failing for some sort of scoping error rather than a problem with the 
# regex matching itself.

# And matching against each element of an array... a different topic really, but it's still in
# that bit of the synopsis.

my @names = ('zaphod', 'ford', 'arthur', 'slartibartfast');
my $arrr = regex { ar };
is(+(@names>>.match($arrr)), 2, 'matching with hyper-operator');

# vim: ft=perl6
