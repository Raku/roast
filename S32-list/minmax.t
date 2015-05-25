use v6;

use Test;

plan 97;

# L<S32::Containers/List/=item min>
# L<S32::Containers/List/=item max>

=begin description

As per S32, the sub form requires a comparison function. The form without
comparison function is spelled [min]

=end description

my @array = (5,-3,7,0,1,-9); #NOTICE! The <> don't work like they should, rakudo devels! That's why we use this :/ --lue

# Tests for C<min>:
is @array.min,  -9, "basic method form of min works";
is min(@array), -9, 'min(list)'; 

is (@array.min: { $^a <=> $^b }), -9,
  "method form of min with identity comparison block works";

is (@array.min:{ $^a <=> $^b }), -9,
  "adverbial block form of min with identity comparison block works (RT #53804)";

is min(:by({ $^a <=> $^b }), @array), -9,
  "subroutine form of min with identity comparison block works";

is (@array.min: { abs($^a) <=> abs($^b) }), 0,
  "method form of min taking a comparison block works";
is min(:by({ abs($^a) <=> abs($^b) }), @array), 0,
  "subroutine form of min taking a comparison block works";

is (@array.min: { abs $^a }), 0,
  "method form of min taking a comparison block works";
is min(:by({ $^a.abs }), @array), 0,
  "subroutine form of min taking a comparison block works";

# Tests for C<max>:
is (@array.max),  7, "basic method form of max works";
is max(:by({ $^a <=> $^b }), @array), 7, "basic subroutine form of max works";

is (@array.max: { $^a <=> $^b }), 7,
  "method form of max with identity comparison block works";

is max(@array), 7, 'sub form of max';

is max(:by({ $^a <=> $^b }), @array), 7,
  "subroutine form of max with identity comparison block works";

is (@array.max: { $^a.abs <=> $^b.abs }), -9,
  "method form of max taking a comparison block works";
is max(:by({ $^a.abs <=> $^b.abs }), @array), -9,
  "subroutine form of max taking a comparison block works";
is (@array.max: { $^a.abs }), -9,
  "method form of max taking a modifier block works";
is max(:by({ $^a.abs }), @array), -9,
  "subroutine form of max taking a modifier block works";

# Tests for C<minmax>:
is @array.minmax,  -9..7, "basic method form of minmax works";
is minmax(@array), -9..7,  'minmax(list)';

is (@array.minmax: { $^a <=> $^b }), -9..7,
  "method form of minmax with identity comparison block works";

is minmax(:by({ $^a <=> $^b }), @array), -9..7,
  "subroutine form of minmax with identity comparison block works";

is (@array.minmax: { $^a.abs <=> $^b.abs }), 0..-9,
  "method form of minmax taking a comparison block works";
is minmax(:by({ $^a.abs  <=> $^b.abs }), @array), 0..-9,
  "subroutine form of minmax taking a comparison block works";
is (@array.minmax: { abs $^a }), 0..-9,
  "method form of minmax taking a comparison block works";
is minmax(:by({ $^a.abs }), @array), 0..-9,
  "subroutine form of minmax taking a comparison block works";

is ((-10..9).minmax: { $^a.abs <=> $^b.abs }), 0..-10,
  "method form of minmax on Ranges taking a comparison block works";

is ((1..10).minmax: { ($_-3) * ($_-5) }), 4..10,
  "method form of minmax taking an arity-1 comparison block works";

# Error cases:
is 42.min, 42, ".min should work on scalars";
is 42.max, 42, ".max should work on scalars";
is (42,).min, 42, ".min should work on one-elem arrays";
is (42,).max, 42, ".max should work on one-elem arrays";

# Tests with literals:
is (1,2,3).max, 3, "method form of max with literals works";
is (1,2,3).min, 1, "method form of min with literals works";
is max(:by({$^a <=> $^b}), 1,2,3),  3, "subroutine form of max with literals works";
is min(:by({$^a <=> $^b}), 1,2,3),  1, "subroutine form of min with literals works";

# Try to read numbers from a file
{
    my $fh = open "t/spec/S32-list/numbers.data";
    @array = $fh.lines();
    is @array.max, 5, "max of strings read from a file works";
    is @array.min, -1, "min of strings read from a file works";

    # Same, but numifying the numbers first
    {
        @array = map { +$_ }, @array;
        is @array.max, 28, "max of strings read from a file works";
        is @array.min, -80, "min of strings read from a file works";
    }

}

is (1, Inf).max, Inf,"Inf is greater than 1";
is (-1, -Inf).min, -Inf,"-Inf is less than -1";
is (-Inf, Inf).min, -Inf,"-Inf is less than Inf";
is (-Inf, Inf).max, Inf,"Inf is greater than -Inf";

#############
#SIN FOUND!
#############
#The four below do not work in ANY implementation so far (the `right one' depends on your way of ordering the values 0, NaN, and Inf from least to greatest) The number of tests has been minused 4, from 46 to 42, for the time being.
#None of the three implementations (pugs, rakudo/alpha, rakudo/master) return what's set below. A trip to the Spec is the only solution, but I haven't enough time.
#for details, see http://irclog.perlgeek.de/perl6/2010-02-23#i_2022557
#sin found 22 Feb. 2010, 21:55 PST
#--lue
#############
#is (0, NaN).min, NaN,    "min(0,NaN)=NaN";
#is (Inf, NaN).min, NaN,    "max(Inf,NaN)=NaN";
#
#is (0, NaN).max, NaN,    "max(0,NaN)=NaN";
#is (Inf, NaN).max, NaN,    "max(Inf,NaN)=NaN";

is ([min] (5,10,-15,20)), -15, 'reduce min int';
is ([max] (5,10,-15,20)), 20, 'reduce max int';

is ([min] (5.1,10.3,-15.7,20.9)), -15.7, 'reduce min numeric';
is ([max] (5.4,10.7,-15.2,20.8)), 20.8, 'reduce max numeric';

{
    my @strings = <Inspiring bold John Barleycorn!
                   What dangers thou canst make us scorn!
                   Wi' tippenny, we fear nae evil;
                   Wi' usquabae, we'll face the devil!>;

    is @strings.min, "Barleycorn!", 'Default .min works on array of strings';
    is @strings.min(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "us", '.min works with explicit comparator';
    is ([min] @strings), "Barleycorn!", '[min] works on array of strings';

    is @strings.max, "we'll", 'Default .max works on array of strings';
    is @strings.max(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "Barleycorn!", 
       '.max works with explicit comparator';
    is ([max] @strings), "we'll", '[max] works on array of strings';
}

# RT #103178
{
    class A { has $.d };
    is (A.new(d => 5), A.new(d => 1), A.new(d => 10)).min(*.d).d,
        1, 'can use non-numbers with .min and unary closures';

}

{
    # check that .min, .max, and .minmax return values can be combined further
    # using various forms of min/max/minmax such that the final result is
    # independent from the grouping of data in intermediate steps

    my @ints = (3, -1, 7, -2, 5, 10);

    is @ints[0..1].min min @ints[2..*].min, -2, 'min combine .min of non-empty sublists of Ints';
    is @ints[ () ].min min @ints[0..*].min, -2, 'min combine .min of empty and non-empty sublist of Ints';
    is @ints[0..5].min min @ints[6..*].min, -2, 'min combine .min of non-empty and empty sublist of Ints';

    is ([min] @ints[0..1].min, @ints[2..3].min, @ints[4..*].min), -2, '[min] combine .min of non-empty sublist of Ints';
    is ([min] @ints[ () ].min, @ints[0..5].min, @ints[6..*].min), -2, '[min] combine .min of empty, non-empty, empty sublist of Ints';

    is (@ints[0..1].min, @ints[2..3].min, @ints[4..*].min).min, -2, '.min combine .min of non-empty sublist of Ints';
    is (@ints[ () ].min, @ints[0..5].min, @ints[6..*].min).min, -2, '.min combine .min of empty, non-empty, empty sublist of Ints';

    is @ints[0..1].max max @ints[2..*].max, 10, 'max combine .max of non-empty sublists of Ints';
    is @ints[ () ].max max @ints[0..*].max, 10, 'max combine .max of empty and non-empty sublist of Ints';
    is @ints[0..5].max max @ints[6..*].max, 10, 'max combine .max of non-empty and empty sublist of Ints';

    is ([max] @ints[0..1].max, @ints[2..3].max, @ints[4..*].max), 10, '[max] combine .max of non-empty sublist of Ints';
    is ([max] @ints[ () ].max, @ints[0..5].max, @ints[6..*].max), 10, '[max] combine .max of empty, non-empty, empty sublist of Ints';

    is (@ints[0..1].max, @ints[2..3].max, @ints[4..*].max).max, 10, '.max combine .max of non-empty sublist of Ints';
    is (@ints[ () ].max, @ints[0..5].max, @ints[6..*].max).max, 10, '.max combine .max of empty, non-empty, empty sublist of Ints';

    # combination of minmax results for Ints:

    is (@ints[0..1].minmax minmax @ints[2..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of non-empty sublists of Ints';
    is (@ints[ () ].minmax minmax @ints[0..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of empty and non-empty sublist of Ints';
    is (@ints[0..5].minmax minmax @ints[6..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of non-empty and empty sublist of Ints';

    is ([minmax] @ints[0..1].minmax, @ints[2..3].minmax, @ints[4..*].minmax), -2..10,
        '[minmax] combine .minmax of non-empty sublist of Ints';
    is ([minmax] @ints[ () ].minmax, @ints[0..5].minmax, @ints[6..*].minmax), -2..10,
        '[minmax] combine .minmax of empty, non-empty, empty sublist of Ints';

    is (@ints[0..1].minmax.item, @ints[2..3].minmax.item, @ints[4..*].minmax.item).minmax, -2..10,
        '.minmax combine .minmax of non-empty sublist of Ints';
    is (@ints[ () ].minmax.item, @ints[0..5].minmax.item, @ints[6..*].minmax.item).minmax, -2..10,
        '.minmax combine .minmax of empty, non-empty, empty sublist of Ints';

    # Play it again with strings:

    my @words = <one two three four five six>;

    is @words[0..1].min min @words[2..*].min, 'five', 'min combine .min of non-empty sublists of Strs';
    is @words[ () ].min min @words[0..*].min, 'five', 'min combine .min of empty and non-empty sublist of Strs';
    is @words[0..5].min min @words[6..*].min, 'five', 'min combine .min of non-empty and empty sublist of Strs';

    is ([min] @words[0..1].min, @words[2..3].min, @words[4..*].min), 'five', '[min] combine .min of non-empty sublist of Strs';
    is ([min] @words[ () ].min, @words[0..5].min, @words[6..*].min), 'five', '[min] combine .min of empty, non-empty, empty sublist of Strs';

    is (@words[0..1].min, @words[2..3].min, @words[4..*].min).min, 'five', '.min combine .min of non-empty sublist of Strs';
    is (@words[ () ].min, @words[0..5].min, @words[6..*].min).min, 'five', '.min combine .min of empty, non-empty, empty sublist of Strs';

    is @words[0..1].max max @words[2..*].max, 'two', 'max combine .max of non-empty sublists of Strs';
    is @words[ () ].max max @words[0..*].max, 'two', 'max combine .max of empty and non-empty sublist of Strs';
    is @words[0..5].max max @words[6..*].max, 'two', 'max combine .max of non-empty and empty sublist of Strs';

    is ([max] @words[0..1].max, @words[2..3].max, @words[4..*].max), 'two', '[max] combine .max of non-empty sublist of Strs';
    is ([max] @words[ () ].max, @words[0..5].max, @words[6..*].max), 'two', '[max] combine .max of empty, non-empty, empty sublist of Strs';

    is (@words[0..1].max, @words[2..3].max, @words[4..*].max).max, 'two', '.max combine .max of non-empty sublist of Strs';
    is (@words[ () ].max, @words[0..5].max, @words[6..*].max).max, 'two', '.max combine .max of empty, non-empty, empty sublist of Strs';

    # combination of minmax results for strings:

    is (@words[0..1].minmax minmax @words[2..*].minmax).perl, ('five'..'two').perl,
        'infix:<minmax> combine .minmax of non-empty sublists of Strs';
    is (@words[ () ].minmax minmax @words[0..*].minmax).perl, ('five'..'two').perl,
        'infix:<minmax> combine .minmax of empty and non-empty sublist of Strs';
    is (@words[0..5].minmax minmax @words[6..*].minmax).perl, ('five'..'two').perl,
        'infix:<minmax> combine .minmax of non-empty and empty sublist of Strs';

    is ([minmax] @words[0..1].minmax, @words[2..3].minmax, @words[4..*].minmax).perl, ('five'..'two').perl,
        '[minmax] combine .minmax of non-empty sublist of Strs';
    is ([minmax] @words[ () ].minmax, @words[0..5].minmax, @words[6..*].minmax).perl, ('five'..'two').perl,
        '[minmax] combine .minmax of empty, non-empty, empty sublist of Strs';

    is (@words[0..1].minmax.item, @words[2..3].minmax.item, @words[4..*].minmax.item).minmax.perl, ('five'..'two').perl,
        '.minmax combine .minmax of non-empty sublist of Strs';
    is (@words[ () ].minmax.item, @words[0..5].minmax.item, @words[6..*].minmax.item).minmax.perl, ('five'..'two').perl,
        '.minmax combine .minmax of empty, non-empty, empty sublist of Strs';
}

# vim: ft=perl6
