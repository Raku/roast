# http://perl6advent.wordpress.com/2009/12/11/day-11-classes-attributes-methods-and-more/

use v6;
use Test;

plan 6;

class Dog {
    has $.name;
    method bark($times) {
        "w00f! " x $times;
    }
}

my $fido = Dog.new(name => 'Fido');
is $fido.name, 'Fido', 'correct name';
is $fido.bark(3), 'w00f! w00f! w00f! ', 'Can bark';

class Puppy is Dog {
    method bark($times) {
        "yap! " x $times;
    }
}

is Puppy.new.bark(2), 'yap! yap! ', 'a Puppy can bark, too';

class DogWalker {
    has $.name;
    has Dog $.dog handles (dog_name => 'name');
}
my $bob = DogWalker.new(name => 'Bob', dog => $fido);
is $bob.name, 'Bob', 'dog walker has a name';
#?pugs skip 'no such method'
is $bob.dog_name, 'Fido', 'dog name can be accessed by delegation';

# RT 75180
#?pugs skip 'no such ^methods'
is Dog.^methods(:local).map({.name}).sort.join('|'),
    'bark|name', 'can introspect Dog';

done;
