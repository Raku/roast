use v6;
use Test;

plan 8;

# L<S14/Traits/>

role description {
    has $.description is rw;
}

multi trait_mod:<is>(Mu:U $c, description, $arg) {
    $c.HOW does description($arg);
}
multi trait_mod:<is>(Mu:U $c, description) {
    $c.HOW does description("missing description!");
}
multi trait_mod:<is>(Mu:U $c, :$described!) {
    $c.HOW does description($described ~~ Str ?? $described !! "missing description");
}

class Monkey is description('eats bananas, awesome') { }
class Walrus is description { }
is Monkey.HOW.description, 'eats bananas, awesome', 'description role applied to class and set with argument';
is Walrus.HOW.description, 'missing description!',  'description role applied to class without argument';

class Badger is described('mushroom mushroom') { }
class Snake is described { }
is Badger.HOW.description, 'mushroom mushroom',    'named trait handler applied other role to class set with argument';
is Snake.HOW.description,  'missing description!', 'named trait handler applied other role to class without argument';


role Nom is description('eats and eats') { }
role Loser is description { }
is Nom.HOW.description,   'eats and eats',        'description role applied to role and set with argument';
is Loser.HOW.description, 'missing description!', 'description role applied to role without argument';

role DamBuilding is described('dam good!') { }
role Slither is described { }
is DamBuilding.HOW.description, 'dam good!',            'named trait handler applied other role to role set with argument';
is Slither.HOW.description,     'missing description!', 'named trait handler applied other role to role without argument';

# vim: ft=perl6
