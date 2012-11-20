use v6;

use Test;

plan 40;

=begin description

This test tests the C<roll> builtin. See S32::Containers#roll.

=end description

# L<S32::Containers/List/=item roll>

my @array = <a b c d>;
ok ?(@array.roll eq any <a b c d>), "roll works on arrays";

#?niecza skip '.roll on empty list'
ok ().roll === Nil, '.roll on the empty list is Nil';

my @arr = <z z z>;

ok ~(@arr.roll(2)) eq 'z z',   'method roll with $num < +@values';
ok ~(@arr.roll(4)) eq 'z z z z', 'method roll with $num > +@values';

#?pugs 2 todo 'feature'
is roll(2, @arr), <z z>, 'sub roll with $num < +@values, implicit no-replace';
is roll(4, @arr), <z z z z>, 'sub roll with $num > +@values';

is <a b c d>.roll(*)[^10].elems, 10, 'roll(*) generates at least ten elements';

{
  my @items = <1 2 3 4>;
  my @shuffled_items_10;
  push @shuffled_items_10, @items.roll(4) for ^10;
  isnt(@shuffled_items_10, @items xx 10,
       'roll(4) returned the items of the array in a random order');
}

is (0, 1).roll(*).[^10].elems, 10, '.roll(*) returns at least ten elements';

{
    # Test that List.roll doesn't flatten array refs
    ok ?([[1, 2], [3, 4]].roll.join('|') eq any('1|2', '3|4')), '[[1,2],[3,4]].roll does not flatten';
}

{
    ok <5 5>.roll() == 5,
       '.roll() returns something can be used as single scalar';
}

{
    my @a = 1..100;
    my @b = roll(100, @a);
    is @b.elems, 100, "roll(100, @a) returns the correct number of elements";
    is ~@b.grep(Int).elems, 100, "roll(100, @a) returns Ints (if @a is Ints)";
    is ~@b.grep(1..100).elems, 100, "roll(100, @a) returns numbers in the correct range";

    isa_ok @a.roll, Int, "rolling a single element from an array of Ints produces an Int";
    ok @a.roll ~~ 1..100, "rolling a single element from an array of Ints produces one of them";

    isa_ok @a.roll(1), Int, "rolling 1 from an array of Ints produces an Int";
    ok @a.roll(1) ~~ 1..100, "rolling 1 from an array of Ints produces one of them";

    my @c = @a.roll(2);
    isa_ok @c[0], Int, "rolling 2 from an array of Ints produces an Int...";
    isa_ok @c[1], Int, "... and an Int";
    ok (@c[0] ~~ 1..100) && (@c[1] ~~ 1..100), "rolling 2 from an array of Ints produces two of them";

    is @a.roll("25").elems, 25, ".roll works Str arguments";
    is roll("25", @a).elems, 25, "roll works Str arguments";
}

# enums + roll
{
    is Bool.roll(3).grep(Bool).elems, 3, 'Bool.roll works';

    enum A <b c d>;
    is A.roll(4).grep(A).elems, 4, 'RandomEnum.roll works';
}

# ranges + roll
{
    ok 1 <= (1..1_000_000).roll() <= 1_000_000, 'no argument roll works';
    
    my @matches := (1..1_000_000).roll(*);
    ok (so 1 <= all(@matches[^100]) <= 1_000_000), 'the first 100 elems are in range';
}

{
    my @matches = (1..1_000_000).roll(20);
    is @matches.elems, 20, 'right number of elements from Range.roll';
    ok (so 1 <= all(@matches) <= 1_000_000), 'all the elems are in range';
}

{
    my @matches = (1^..1_000_000).roll(20);
    is @matches.elems, 20, 'right number of elements from Range.roll (min exclusive)';
    ok (so 1 < all(@matches) <= 1_000_000), 'all the elems are in range';
}

{
    my @matches = (1..^1_000_000).roll(20);
    is @matches.elems, 20, 'right number of elements from Range.roll (max exclusive)';
    ok (so 1 <= all(@matches) < 1_000_000), 'all the elems are in range';
}

{
    my @matches = (1^..^1_000_000).roll(20);
    is @matches.elems, 20, 'right number of elements from Range.roll (both exclusive)';
    ok (so 1 < all(@matches) < 1_000_000), 'all the elems are in range';
}

{
    my @matches = (1..(10**1000)).roll(20);
    is @matches.elems, 20, 'right number of elements from Range.roll, huge range';
    ok (so 1 <= all(@matches) <= 10**1000), 'all the elems are in range';
}


is (1..^2).roll, 1, '1-elem Range roll';
ok ('a' .. 'z').roll ~~ /\w/, 'Str-Range roll';

# RT 89972
{
    my $a = qqx{$*EXECUTABLE_NAME -e "print ~(1..10).pick(5)"};
    my $b = qqx{$*EXECUTABLE_NAME -e "print ~(1..10).pick(5)"};
    my $c = qqx{$*EXECUTABLE_NAME -e "print ~(1..10).pick(5)"};
    ok ($a leg $b || $b leg $c), 'different results due to random random-number seed';
}

# vim: ft=perl6
