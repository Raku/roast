use v6;
use Test;

plan 33;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$^k} }).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    my $b = bag <a foo a a a a b foo>;
    isa_ok $b, Bag, '&bag produces a Bag';
    is showkv($b), 'a:5 b:1 foo:2', '...with the right elements';

    is $b<a>, 5, 'Single-key subscript (existing element)';
    is $b<santa>, 0, 'Single-key subscript (nonexistent element)';
    ok $b.exists('a'), '.exists with existing element';
    nok $b.exists('santa'), '.exists with nonexistent element';

    dies_ok { $b<a> = 5 }, "Can't assign to an element (Bags are immutable)";
    dies_ok { $b.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $b.values = 3, 4 }, "Can't assign to .values";

    is ([+] $b<a b>), 6, 'Multiple-element access';
    is ([+] $b<a santa b easterbunny>), 6, 'Multiple-element access (with nonexistent elements)';

    is $b.elems, 8, '.elems gives sum of values';
    is +$b, 8, '+$bag gives sum of values';
}

{
    my $b = bag 'a', False, 2, 'a', False, False;
    my @ks = $b.keys;
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $b{2, 'a', False}.sort.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my %h = bag <a b o p a p o o>;
    ok %h ~~ Hash, 'A hash to which a Bag has been assigned remains a hash';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = bag set <foo bar foo bar baz foo>;
    isa_ok $b, Bag, '&bag given a Set produces a Bag';
    is showkv($b), 'bar:1 baz:1 foo:1', '... with the right elements';
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag <a b c b>;
    isa_ok %b, Bag, 'A Bag bound to a %var is a Bag';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    dies_ok { %b<a> = 1 }, "Can't assign to an element (Bags are immutable)";
    dies_ok { %b = bag <a b> }, "Can't assign to a %var implemented by Bag";
}

# L<S32::Containers/Bag/pick>

{
    my $b = bag <a b b>;

    my @a = $b.pick: *;
    is +@a, 3, '.pick(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.pick(*) (1)';
    is @a.grep(* eq 'b').elems, 2, '.pick(*) (2)';
}

# L<S32::Containers/Bag/roll>

{
    my $b = bag <a b b>;

    my @a = $b.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(100) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100) (2)';
}

# vim: ft=perl6
