use v6;
use Test;

plan 49;

# L<S02/Mutable types/"KeyHash of Bool">

# A KeySet is a KeyHash of Bool, i.e. the values are Bool

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = KeySet.new(<a b foo>);
    isa_ok $s, KeySet, 'KeySet.new produces a KeySet';
    is showset($s), 'a b foo', '...with the right elements';

    is $s<a>, True, 'Single-key subscript (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    is $s.exists('a'), True, '.exists with existing element';
    is $s.exists('santa'), False, '.exists with nonexistent element';

    dies_ok { $s.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $s.values = <True False> }, "Can't assign to .values";

    #?niecza 2 todo 'multiple-element access NYI'
    is ($s<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $s.elems, 3, '.elems gives number of keys';
    is +$s, 3, '+$set gives number of keys';
    
    $s<baz> = True;
    lives_ok { $s<baz> = True }, 'can set an item to True';
    is showset($s), 'a b baz foo', '...and it adds it to the KeySet';
    lives_ok { $s<baz> = True }, 'can set the same item to True';
    is showset($s), 'a b baz foo', '...and it does nothing';

    lives_ok { $s<baz> = False }, 'can set an item to False';
    is showset($s), 'a b foo', 'and it removes it';
    lives_ok { $s<baz> = False }, 'can set an item which does not exist to False';
    is showset($s), 'a b foo', '... and it is not added to the set';
    
    lives_ok { $s<foo> = False }, 'can set an item to False';
    is $s.elems, 2, '... and an item is gone';
    is showset($s), 'a b', '... and the right one is gone';
    
    lives_ok { $s<foo>++ }, 'can ++ an item';
    is showset($s), 'a b foo', '++ on an item reinstates it';
    lives_ok { $s<foo>++ }, 'can ++ an item';
    is showset($s), 'a b foo', '++ on an existing item does nothing';

    lives_ok { $s<b>-- }, 'can -- an item';
    is showset($s), 'a foo', '-- on an item removes it';
    lives_ok { $s<bar>-- }, 'can -- an item';
    is showset($s), 'a foo', '... but only if they were there to start with';
}


{
    my %h := KeySet.new(<a c>);
    is +%h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = False }, 'can set an item to False';
    is %h.elems, 1, '... and an item is gone';
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %h<a>--;
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'c', '... but only if they were there from the beginning';

    # lives_ok { %h = set <Q P R> }, 'Assigning a Set to a KeySet';
    # is %h.keys.sort.join, 'PQR', '... works as expected';
}

#?niecza skip "is KeySet doesn't work yet"
{
    my %h is KeySet = a => True, b => False, c => True;
    is +%h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = False }, 'can set an item to False';
    is %h.elems, 1, '... and an item is gone';
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %h<a>--;
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'c', '... but only if they were there from the beginning';

    lives_ok { %h = set <Q P R> }, 'Assigning a Set to a KeySet';
    is %h.keys.sort.join, 'PQR', '... works as expected';
}

# vim: ft=perl6
