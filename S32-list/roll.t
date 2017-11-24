use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 51;

use Test::Util;

=begin description

This test tests the C<roll> builtin. See S32::Containers#roll.

=end description

# L<S32::Containers/List/=item roll>

my @array = <a b c d>;
ok ?(@array.roll eq any <a b c d>), "roll works on arrays";

ok ().roll === Nil, '.roll on the empty list is Nil';

my @arr = <z z z>;

ok ~(@arr.roll(2)) eq 'z z',   'method roll with $num < +@values';
ok ~(@arr.roll(4)) eq 'z z z z', 'method roll with $num > +@values';

is roll(2, @arr), <z z>, 'sub roll with $num < +@values, implicit no-replace';
is roll(4, @arr), <z z z z>, 'sub roll with $num > +@values';

is <a b c d>.roll(*)[^10].elems, 10, 'roll(*) generates at least ten elements';
ok <a b c d>.roll(*).is-lazy, 'roll(*) knows itself to be lazy';

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

    isa-ok @a.roll, Int, "rolling a single element from an array of Ints produces an Int";
    ok @a.roll ~~ 1..100, "rolling a single element from an array of Ints produces one of them";

    ok @a.roll(1) ~~ Iterable, "rolling 1 from an array of Ints produces something iterable";
    ok @a.roll(1)[0] ~~ 1..100, "rolling 1 from an array of Ints produces one of them";

    my @c = @a.roll(2);
    isa-ok @c[0], Int, "rolling 2 from an array of Ints produces an Int...";
    isa-ok @c[1], Int, "... and an Int";
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

    my \matches = (1..1_000_000).roll(*);
    ok (so 1 <= all(matches[^100]) <= 1_000_000), 'the first 100 elems are in range';
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

# RT #89972
{
    my $a = Test::Util::run( "print ~(1..10).pick(5)" );
    my $b = Test::Util::run( "print ~(1..10).pick(5)" );
    my $c = Test::Util::run( "print ~(1..10).pick(5)" );
    ok set($a, $b, $c) > 1, 'different results due to random random-number seed';
}

# sanity on Enums
{
    is Order.roll, any(Less,Same,More), 'simple roll on Enum type works';
    is Order.roll(1), any(Less,Same,More), 'one roll on Enum type works';
    is Order.roll(4).elems, 4, 'too many roll on Enum type works';
    is Order.roll(0), (), 'zero roll on Enum type works';

    is Less.roll, Less, 'simple roll on Enum is sane';
    is Same.roll(1), Same, 'one roll on Enum is sane';
    is Less.roll(4), (Less,Less,Less,Less), 'too many roll on Enum is sane';
    is More.roll(0), (), 'zero roll on Enum is sane';
}

# RT #126664
{
    is-deeply (1.1 .. 3.1).roll(1000).Set, set(2.1, 1.1, 3.1),
        'roll on Range uses .succ';
    subtest 'rand on ranges is implemented' => {
        plan 2;
        my ($n, $from, $to) = (1000, 0.1, 0.100001);
        my @res = ($from .. $to).rand xx $n;
        is @res.grep($from <= * <= $to).elems, $n,
            'all generated numbers are in range';

        # Look for a bit less than exact number, since there's a small chance
        # for some of them to be the same and we don't want the test to flap
        cmp-ok @res.Set.elems, '>=', $n-$n/10, 'generated elements vary';
    }
}

# vim: ft=perl6
