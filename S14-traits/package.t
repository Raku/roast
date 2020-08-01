use v6;
use Test;

plan 4;

# L<S14/Traits/>

role Description[Any $desc] {
    has $.description is rw = $desc;
}

multi trait_mod:<is>(Mu:U $c is raw, Str:D :$description, ) {
    $c.HOW does Description[$description];
}
multi trait_mod:<is>(Mu:U $c, Any :$description!) {
    $c.HOW does Description["missing description!"];
}

class Monkey is description('eats bananas, awesome') { }
class Walrus is description { }
is Monkey.HOW.description, 'eats bananas, awesome', 'description role applied to class and set with argument';
is Walrus.HOW.description, 'missing description!',  'description role applied to class without argument';

role Nom is description('eats and eats') { }
role Loser is description { }
is Nom.^candidates[0].HOW.description,   'eats and eats',        'description role applied to role and set with argument';
is Loser.^candidates[0].HOW.description, 'missing description!', 'description role applied to role without argument';

# vim: expandtab shiftwidth=4
