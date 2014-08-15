use v6;
use Test;
plan 12;

class Dog {
    has $.name;
}

sub check(Dog $d) {
    return "Yup, that's a dog for sure.";
}

my $name = 'Fido';
my Dog $dog .= new(:$name);
ok check($dog), 'call with instance';
ok check(Dog),  'call with type object';

is Dog.gist, '(Dog)', '.gist';

nok Dog, 'Type object is False';
nok defined(Dog), 'Type object is undefined';
ok $dog, 'instance is True';
ok defined($dog), 'instance is defined';
is $dog.name, 'Fido', 'Attribute access on instance';
throws_like { Dog.name },
  X::AdHoc,  # does not have an Exception object yet
  'Cannot access attribute on type object';

multi sniff(Dog:U $dog) {
    return "a type object, of course"
}
multi sniff(Dog:D $dog) {
    return "definitely a real dog instance"
}

is sniff(Dog) , 'a type object, of course', 'multi with instance';
is sniff($dog), 'definitely a real dog instance', 'multi with type object';

is ((my @a = "Hip " x 2), @a.^name, "!").join, 'Hip Hip Array!', 'corniest one-liner';

