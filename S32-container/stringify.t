use v6;
use Test;

plan 16;

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

# XXX Should ~Set and Set.Str return something specific?  For now
# just make sure they don't die

is Set.gist, '(Set)', 'Set.gist';
is Set.perl, 'Set', 'Set.perl';
is Set.Str, "", "Set.Str is empty string";
is ~Set, "", "~Set is empty string";

is KeySet.gist, '(KeySet)', 'KeySet.gist';
is KeySet.perl, 'KeySet', 'KeySet.perl';
is KeySet.Str, "", "KeySet.Str is empty string";
is ~KeySet, "", "~KeySet is empty string";

is Bag.gist, '(Bag)', 'Bag.gist';
is Bag.perl, 'Bag', 'Bag.perl';
is Bag.Str, "", "Bag.Str is empty string";
is ~Bag, "", "~Bag is empty string";

is KeyBag.gist, '(KeyBag)', 'KeyBag.gist';
is KeyBag.perl, 'KeyBag', 'KeyBag.perl';
is KeyBag.Str, "", "KeyBag.Str is empty string";
is ~KeyBag, "", "~KeyBag is empty string";

# vim: ft=perl6
done;
