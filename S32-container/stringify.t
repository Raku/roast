use v6;
use Test;

plan 16;

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

# XXX Should ~Set and Set.Str return something specific?  For now
# just make sure they don't die

is Set.gist, '(Set)', 'Set.gist';
is Set.perl, 'Set', 'Set.perl';
#?niecza 2 todo "Don't know what Set.Str should do"
lives_ok { ~Set }, '~Set does not die';
lives_ok { Set.Str }, 'Set.Str does not die';

is KeySet.gist, '(KeySet)', 'KeySet.gist';
is KeySet.perl, 'KeySet', 'KeySet.perl';
#?niecza 2 todo "Don't know what KeySet.Str should do"
lives_ok { ~KeySet }, '~KeySet does not die';
lives_ok { KeySet.Str }, 'KeySet.Str does not die';

is Bag.gist, '(Bag)', 'Bag.gist';
is Bag.perl, 'Bag', 'Bag.perl';
#?niecza 2 todo "Don't know what Bag.Str should do"
lives_ok { ~Bag }, '~Bag does not die';
lives_ok { Bag.Str }, 'Bag.Str does not die';

is KeyBag.gist, '(KeyBag)', 'KeyBag.gist';
is KeyBag.perl, 'KeyBag', 'KeyBag.perl';
#?niecza 2 todo "Don't know what KeyBag.Str should do"
lives_ok { ~KeyBag }, '~KeyBag does not die';
lives_ok { KeyBag.Str }, 'KeyBag.Str does not die';

# vim: ft=perl6
done;
