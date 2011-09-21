use v6;
use Test;

plan 8;

# L<S14/Traits/>

my @attr_names;
multi trait_mod:<is>(Attribute $a, :$noted!) {
    push @attr_names, $a.name;
}

role doc { has $.doc is rw }
multi trait_mod:<is>(Attribute $a, doc, $arg) {
    $a.container.VAR does doc($arg);
}


class T1 {
    has $!a is noted;
}
class T2 is T1 {
    has %!b is noted;
    has @!c is noted;
}

# Force class to create itself and thus apply the traits, for implementations
# that do such things lazily.
ok T2.new ~~ T2, 'class with traits applied to attributes by name instantiated ok';
@attr_names .= sort;
is +@attr_names, 3, 'have correct number of attributes';
is @attr_names, ['$!a','%!b','@!c'], 'trait was applied to each attribute';
T2.new;
is +@attr_names, 3, 'second instantiation of the classes does not re-apply traits';


class T3 {
    has $.dog is doc('barks');
    has @.birds is doc('tweet');
    has %.cows is doc('moooo');
}

my $x = T3.new;
ok $x ~ T3, 'class with traits applied to attributes by role instantiated ok';
is $x.dog.VAR.doc, 'barks', 'trait applied to scalar attribute correctly';
is $x.birds.doc,   'tweet', 'trait applied to array attribute correctly';
is $x.cows.doc,    'moooo', 'trait applied to hash attribute correctly';

# vim: ft=perl6
