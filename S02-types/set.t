use v6;
use Test;

plan 39;

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = set <a b foo>;
    isa_ok $s, Set, '&set produces a Set';
    is showset($s), 'a b foo', '...with the right elements';

    is $s<a>, True, 'Single-key subscript (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    is $s.exists('a'), True, '.exists with existing element';
    is $s.exists('santa'), False, '.exists with nonexistent element';

    dies_ok { $s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies_ok { $s.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $s.values = <True False> }, "Can't assign to .values";

    is ($s<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $s.elems, 3, '.elems gives number of keys';
    is +$s, 3, '+$set gives number of keys';
}

{
    my $s = set 2, 'a', False;
    my @ks = $s.keys;
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is +$s, 3, 'Keys are counted correctly even when a key is False';
}

# RT #77760
{
    my %h = set <a b o p a p o o>;
    ok %h ~~ Hash, 'A hash to which a Set has been assigned remains a hash';
    is %h.keys.sort.join, 'abop', '...with the right keys';
    is %h.values, (True, True, True, True), '...and values all True';
}

{
    my $s = set <foo bar foo bar baz foo>;
    is showset($s), 'bar baz foo', '&set discards duplicates';
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := set <a b c b>;
    isa_ok %s, Set, 'A Set bound to a %var is a Set';
    is showset(%s), 'a b c', '...with the right elements';

    is %s<a>, True, 'Single-key subscript (existing element)';
    is %s<santa>, False, 'Single-key subscript (nonexistent element)';

    dies_ok { %s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies_ok { %s = a => True, b => True }, "Can't assign to a %var implemented by Set";
}

# L<S03/Hyper operators/'unordered type'>

{
    is showset(set(1, 2, 3) »+» 6), '7 8 9', 'Set »+» Int';
    is showset("a" «~« set(<pple bbot rmadillo>)), 'abbot apple armadillo', 'Str «~« Set';
    is showset(-« set(3, 9, -4)), '-9 -3 4', '-« Set';
    #?rakudo skip 'Hyper-method calls on Sets NYI'
    is showset(set(<b e g k z>)».pred), 'a d f j y', 'Set».pred';

    dies_ok { set(1, 2) »+« set(3, 4) }, 'Set »+« Set is illegal';
    dies_ok { set(1, 2) «+» set(3, 4) }, 'Set «+» Set is illegal';
    dies_ok { set(1, 2) »+« [3, 4] }, 'Set »+« Array is illegal';
    dies_ok { set(1, 2) «+» [3, 4] }, 'Set «+» Array is illegal';
    dies_ok { [1, 2] »+« set(3, 4) }, 'Set »+« Array is illegal';
    dies_ok { [1, 2] «+» set(3, 4) }, 'Set «+» Array is illegal';
}

# L<S32::Containers/Set/pick>

{
    my $s = set <a b c d e f g h>;
    my @a = $s.pick: *;
    is @a.sort.join, 'abcdefgh', 'Set.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'Set.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
}

# vim: ft=perl6
