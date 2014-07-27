use v6;
use Test;
plan 15;

{
    # P21 (*) Insert an element at a given position into a list.
    # 
    # Example:
    # * (insert-at 'alfa '(a b c d) 2)
    # (A ALFA B C D)
    
    my @array = <a b c d>;
    @array.splice(1, 0, 'alfa');
    is @array, <a alfa b c d>, 'We should be able to splice into an array';
}

{
    # P22 (*) Create a list containing all integers within a given range.
    # 
    # If first argument is smaller than second, produce a list in decreasing order.
    # Example:
    # * (range 4 9)
    # (4 5 6 7 8 9)
    
    is list(4 .. 9), <4 5 6 7 8 9>, 'We should be able to create ranges';
}

{
    # P23 (**) Extract a given number of randomly selected elements from a list.
    # 
    # The selected items shall be returned in a list.
    # Example:
    # * (rnd-select '(a b c d e f g h) 3)
    # (E D A)
    # 
    # Hint: Use the built-in random number generator and the result of problem P20.
    my @letters = 'a' .. 'h';
    my @rand = pick(3, @letters);
    is @rand.elems, 3, 'pick() should return the correct number of items';
    
    # of course the following is wrong, but it also confuses test output!
    #ok all(@rand) ~~ none(@letters), '... and they should be in the letters';
    #?niecza todo 'unknown'
    ok ?(@rand (<=) @letters), '... and they should be in the letters';
    
    @rand = <a b c d e f g h>.pick(3);
    is @rand.elems, 3, 'pick() should return the correct number of items';
    #?rakudo todo 'RT #122414'
    #?niecza todo 'unknown'
    ok ?(all(@rand) ~~ any(@letters)), '... and they should be in the letters';
}
    
{
    my $compress = sub ($x) {
        state $previous;
        return $x ne $previous ?? ($previous = $x) !! ();
    }

    my @rand = <a b c d e f g h>.pick(3);
    @rand = map $compress, @rand;
    is @rand.elems, 3, '... and pick() should return unique elements';
}

{
    # P24 (*) Lotto: Draw N different random numbers from the set 1..M.
    # 
    # The selected numbers shall be returned in a list.
    # Example:
    # * (lotto-select 6 49)
    # (23 1 17 33 21 37)
    # 
    # Hint: Combine the solutions of problems P22 and P23.
    
    # subset Positive::Int of Int where { $_ >= 0 };
    # sub lotto (Positive::Int $count, Positive::Int $range) returns List {
    
    sub lotto (Int $count, Int $range) returns List {
        return (1 .. $range).pick($count);
    }
    
    my @numbers = lotto(6, 49);
    is @numbers.elems, 6, 'lotto() should return the correct number of numbers';
    #?rakudo todo 'RT #122414'
    #?niecza todo 'unknown'
    ok ?(all(@numbers) ~~ any(1..49)), '... and they should be in the correct range';
    my %unique = map { ($_ => 1) }, @numbers;
    is %unique.keys.elems, 6, '... and they should all be unique numbers';
}

{
    # P25 (*) Generate a random permutation of the elements of a list.
    # 
    # Example:
    # * (rnd-permu '(a b c d e f))
    # (B A D C E F)
    # 
    # Hint: Use the solution of problem P23.
    
    my @array = ('a' .. 'f');
    my @permute = @array.pick(*);
    is @permute.sort, @array.sort,
        '.pick(*) should return a permutation of a list';
}

# P26 (**) Generate the combinations of K distinct objects chosen from the N
# elements of a list
#
# In how many ways can a committee of 3 be chosen from a group of 12 people? We
# all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the
# well-known binomial coefficients). For pure mathematicians, this result may be
# great. But we want to really generate all the possibilities in a list.
#
# Example:
# * (combination 3 '(a b c d e f))
# ((A B C) (A B D) (A B E) ... )

sub combination($n, @xs) {
    if $n > @xs {
        ()
    } elsif $n == 0 {
        ([])
    } elsif $n == @xs {
        [@xs]
    } else {
        (map { [@xs[0],$_.list] },combination($n-1,@xs[1..*])), combination($n,@xs[1..*])
    }
}

#?niecza skip 'hangs'
{
    
    is combination(3, (1..5)),
    ([1, 2, 3],
     [1, 2, 4],
     [1, 2, 5],
     [1, 3, 4],
     [1, 3, 5],
     [1, 4, 5],
     [2, 3, 4],
     [2, 3, 5],
     [2, 4, 5],
     [3, 4, 5]), "combinations work.";
}

#?niecza skip 'hangs'
{
    # P27 (**) Group the elements of a set into disjoint subsets.
    # 
    # a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2,
    # 3 and 4 persons? Write a function that generates all the possibilities and
    # returns them in a list.
    # 
    # Example:
    # * (group3 '(aldo beat carla david evi flip gary hugo ida))
    # ( ( (ALDO BEAT) (CARLA DAVID EVI) (FLIP GARY HUGO IDA) )
    # ... )
    # 
    # b) Generalize the above predicate in a way that we can specify a list of group
    # sizes and the predicate will return a list of groups.
    # 
    # Example:
    # * (group '(aldo beat carla david evi flip gary hugo ida) '(2 2 5))
    # ( ( (ALDO BEAT) (CARLA DAVID) (EVI FLIP GARY HUGO IDA) )
    # ... )
    # 
    # Note that we do not want permutations of the group members; i.e. ((ALDO BEAT)
    # ...) is the same solution as ((BEAT ALDO) ...). However, we make a difference
    # between ((ALDO BEAT) (CARLA DAVID) ...) and ((CARLA DAVID) (ALDO BEAT) ...).
    # 
    # You may find more about this combinatorial problem in a good book on discrete
    # mathematics under the term "multinomial coefficients".
    
    # XXX treats @elems as a set; i.e. duplicated values are 
    # treated as identical, not distinct.
    sub group(@sizes, @elems) {
        return [] if @sizes == 0;
        map -> $e {
            map -> $g {
                [ [@$e], @$g ]
            }, group(@sizes[1..*], grep { not $_ === any(@$e) }, @elems)
        }, combination(@sizes[0], @elems)
    }

    is group((2,1), (1,2,3,4)),
    (((1,2),(3,))
    ,((1,2),(4,))
    ,((1,3),(2,))
    ,((1,3),(4,))
    ,((1,4),(2,))
    ,((1,4),(3,))
    ,((2,3),(1,))
    ,((2,3),(4,))
    ,((2,4),(1,))
    ,((2,4),(3,))
    ,((3,4),(1,))
    ,((3,4),(2,))), 'group works';
}

{
    # P28 (**) Sorting a list of lists according to length of sublists
    # 
    # a) We suppose that a list contains elements that are lists themselves. The
    # objective is to sort the elements of this list according to their length. E.g.
    # short lists first, longer lists later, or vice versa.
    # 
    # Example:
    # * (lsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
    # ((O) (D E) (D E) (M N) (A B C) (F G H) (I J K L))
    # 
    # b) Again, we suppose that a list contains elements that are lists themselves.
    # But this time the objective is to sort the elements of this list according to
    # their length frequency; i.e., in the default, where sorting is done
    # ascendingly, lists with rare lengths are placed first, others with a more
    # frequent length come later.
    # 
    # Example:
    # * (lfsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
    # ((i j k l) (o) (a b c) (f g h) (d e) (d e) (m n))
    # 
    # Note that in the above example, the first two lists in the result have length 4
    # and 1, both lengths appear just once. The third and forth list have length 3
    # which appears twice (there are two list of this length). And finally, the last
    # three lists have length 2. This is the most frequent length.
    # 
    # Arithmetic
    
    my @input= [<a b c>],[<d e>],[<f g h>],[<d e>],[<i j k l>],[<m n>],[<o>];
    my @expected= [<o>],[<d e>],[<d e>],[<m n>],[<a b c>],[<f g h>],[<i j k l>];
    
    my @sorted=@input.sort: { +$_ };
    #?niecza todo 'sort order incorrect.'
    is @expected, 
       @sorted,
       "We should be able to sort a list of lists according to length of sublists";
    
    # the list is not the same as in the sample text, when two lists have the
    # same frequency of length the ordering is unspecified, so this should be ok
}

#?niecza skip 'Unable to resolve method push in class Any'
{
    my @input= [<a b c>],[<d e>],[<f g h>],[<d e>],[<i j k l>],[<m n>],[<o>];
    my @expected= [<i j k l>],[<o>],[<a b c>],[<f g h>],[<d e>],[<d e>],[<m n>];
    
    # group lists by length
    
    my %grouped;
    for (@input) {push %grouped{+$_}, $_}
    
    # now sort the values by frequency,
    # but since both length 1 and 4 appear twice, need to sort first on
    # something else to avoid reliance on hash ordering
    
    my @sorted= %grouped.values.sort(*[0][0]).sort: +*;
    is @expected,@sorted, "..or according to frequency of length of sublists" 
}

# vim: ft=perl6
