use v6;

# Uncomment for quick results on any test failure
BEGIN %*ENV<RAKU_TEST_DIE_ON_FAIL> = True;

use Test;

# L<S03/List infix precedence/"the sequence operator">

# some arrays needed for tests
my @fib = 0, 1, *+* ... *;
my @abc = lazy <a b c>;

# some classes that are used
my class H {
    has $.x;
    method new($x) { self.bless(:$x) }
    method succ()  { H.new($!x + 1)  }
    method raku()  { "H.new($!x)"    }
}

# Test a sequence by seed and endpoint, with the given description
# and the expected result.
#
# The expected result is expected to either be a List (in which case
# the ...^, ^... and ^...^ results will be calculated by removing values
# from beginning and end as appropriate).  Or it can be an Array, in which
# case it is expected to slip into 4 lists, one for each of the ...
# operator forms.
#
# If a result contains exactly 10 elements, the sequence is expected not
# to end.  If the expected result list has fewer elements, then it is
# supposed to contain the exact result of the sequence.
#
# If the endpoint is Whatever, then the tests will automatically also be
# performed with Inf as the endpoint.

sub test-seq($description, Mu \seed, Mu \endpoint, \list) is test-assertion {
    my $result;
    my $resultV;
    my $Vresult;
    my $VresultV;

    # unique results
    if list ~~ Array {
        my @result is List = list.map: { $_ ~~ Seq ?? .Slip !! $_ }
        $result   := @result[0].List;
        $resultV  := @result[1].List;
        $Vresult  := @result[2].List;
        $VresultV := @result[3].List;
    }

    # easily calculated results
    else {
        $result   := list.List;
        $resultV  := $result.elems == 10 ??  $result !! $result[0..*-2];
        $Vresult  := $result[1..*-1];
        $VresultV := $result.elems == 10 ?? $Vresult !! $result[1..*-2];
    }

    # run the tests
    subtest $description => {

        # multiple start / endpoints
        if seed ~~ Array && !seed.is-lazy {
            seed.push(endpoint);

            plan 1;
            is-deeply infix:<...>(|seed).head(10).List, $result,
              " ...  {$result.raku}";
#            is-deeply infix:<...^>(|seed).head(10).List, $resultV,
#              " ...^  {$resultV.raku}";
#            is-deeply infix:<^...>(|seed).head(10).List, $Vresult,
#              " ^...  {$Vresult.raku}";
#            is-deeply infix:<^...^>(|seed).head(10).List, $VresultV,
#              " ^...^  {$VresultV.raku}";
        }

        # only a single start / endpoint
        else {
            plan 4;
            is-deeply infix:<...>(  seed, endpoint).head(10).List, $result,
              " ...  {$result.raku}";
            is-deeply infix:<...^>( seed, endpoint).head(10).List, $resultV,
              " ...^ {$resultV.raku}";
            is-deeply infix:<^...>( seed, endpoint).head(9).List, $Vresult,
              "^...  {$Vresult.raku}";
            is-deeply infix:<^...^>(seed, endpoint).head(9).List, $VresultV,
              "^...^ {$VresultV.raku}";
        }
    }

    # optionally run same test for Inf as endpoint
    test-seq($description, seed, Inf, [$result,$resultV,$Vresult,$VresultV])
      if endpoint ~~ Whatever && !seed ~~ Array;
}

# Set up tests, in order: description, LHS, RHS, result (either an Array,
# or someting that can be coerced to a List).
my @tests = (
  'multiple endpoints 0 3 0',
    [0,3], 0, [(0,1,2,3,2,1,0),(0,1,2,2,1),(1,2,3,1,0),(1,2,1)],

  'simple chained finite arithmetic sequence',
    [1,5], 10, [1..10,(0,1,2,3,4,6,7,8,9),(1,2,3,4,5,7,8,9,10),(1,2,3,4,6,7,8,9)],

  'chained finite arithmetic sequence',
    [3,(5,10),(25,50)], 100, [(3,4,5,10,15,20,25,50,75,100),(3,4,10,15,20,50,75),(4,5,15,20,25,75,100),(4,15,20,75)],

  'chained finite geometric sequence',
    [3,(4,8,16),(64,63)], 60, [(3,4,8,16,32,64,63,62,61,60),(3,8,16,32,63,62,61,60),(4,8,32,64,62,61,60),(4,8,32,62,61)],

  'chained infinite numeric sequence',
    [(1/4,1/2,1),(8,9)], *, [(1/4,1/2,1.0,2.0,4.0,8,9,10,11,12),(1/4,1/2,1.0,4.0,9,10,11),(1/2,1.0,2.0,4.0,8,10,11),(1/2,1.0,2.0,4.0,10,11)],

  'chained eventually constant numeric sequence',
    [(1,4,7),(16,16)], *, [(1,4,7,10,13,16,16,16,16,16),(1,4,7,10,13,16,16,16,16),(4,7,10,13,16,16,16,16,16),(4,7,10,13,16,16,16,16)],

  'single term sequence numeric',
    1, 1, 1,

  'single term sequence stringy',
    "a", "a", "a",

  'simple sequence with one item on the LHS',
    1, 5, 1..5,

  'simple decreasing sequence with one item on the LHS',
    1, -3, (1,0,-1,-2,-3),

  'simple additive sequence with two items on the LHS',
    (1,3), 9, (1,3,5,7,9),

  'simple decreasing sequence with two items on the LHS',
    (1,0), -3, (1,0,-1,-2,-3),

  'simple sequence of Rats',
    (1.0,2.0), 7, 1.0..7.0,

  'simple sequence of Nums',
    (1e0,2e0), 7, 1e0..7e0,

  'simple decreasing additive sequence with two items on the LHS',
    (1,-1), -3, (1,-1,-3),

  'simple additive sequence with three items on the LHS',
    (1,3,5), 9, (1,3,5,7,9),

  'simple descreasing additive sequence with three items on the LHS',
    (9,7,5), 1, (9,7,5,3,1),

  'simple multiplicative sequence with three items on the LHS',
    (1,3,9), 81, (1,3,9,27,81),

  'simple geometric sequence of Rats',
    (1.0,2.0,4.0), 64, (1.0,2.0,4.0,8.0,16.0,32.0,64.0),

  'simple geometric sequence of Nums',
    (1e0,2e0,4e0), 64, (1e0,2e0,4e0,8e0,16e0,32e0,64e0),

  'decreasing multiplicative sequence with three items on the LHS',
    (81,27,9), 1, (81,27.0,9.0,3.0,1.0),  # XXX

  'simple sequence with one item and block closure on the LHS',
    (1,*+2), 9, (1,3,5,7,9),

  'simple sequence with one item and closure on the LHS',
    (1,{$_-2}), -7, (1,-1,-3,-5,-7),

  'simple sequence with three items and block closure on the LHS',
    (1,3,5,{$_+2}), 13, (1,3,5,7,9,11,13),

  'tricky sequence with one item and closure on the LHS',
    (1,{1/((1/$_)+1)}), 0.2, (1,0.5,1/3,0.25,0.2),

  'simple alternating sequence with one item and closure on the LHS',
    (1,{-$_}), 1, 1,

  'simple unending alternating sequence with one item and closure on the LHS',
    (1,{-$_}), 3, |(1,-1) xx 5,

  'simple unending alternating sequence with one item and closure on the LHS',
    (1,{-$_}), 0, |(1,-1) xx 5,

  'sequence with one scalar containing Code on the LHS',
    {3+2}, *, 5 xx 10,

  'simple sequence with two extra terms on the RHS',
    1, (5,4,3), [(1,2,3,4,5,4,3),(1,2,3,4,4,3),(2,3,4,5,4,3),(2,3,4,4,3)],

  'simple sequence with two extra terms on the RHS',
    1, (5.5,4,3), [(1,2,3,4,5,4,3) xx 2,(2,3,4,5,4,3) xx 2],

  'simple sequence with two further terms on the RHS',
    1, (5.5,6,7), [(1,2,3,4,5,6,7) xx 2,(2,3,4,5,6,7) xx 2],

  'simple sequence with two weird items on the RHS',
    1, (5.5,'a','b'), [(1,2,3,4,5,'a','b') xx 2,(2,3,4,5,'a','b') xx 2],

  'simple sequence with two weird items on the RHS',
    1, (5,'a','b'), [(1,2,3,4,5,'a','b'),(1,2,3,4,'a','b'),(2,3,4,5,'a','b'),(2,3,4,'a','b')],

  'simple sequence with one item on the LHS',
    1, 5.5, [(1,2,3,4,5) xx 2, (2,3,4,5) xx 2],

  'simple decreasing sequence with one item on the LHS',
    1, -3.5, [(1,0,-1,-2,-3) xx 2, (0,-1,-2,-3) xx 2],

  'simple additive sequence with two items on the LHS',
    (1,3), 10, [(1,3,5,7,9) xx 2, (3,5,7,9) xx 2],

  'simple decreasing additive sequence with two items on the LHS',
    (1,0), -3.5, [(1,0,-1,-2,-3) xx 2, (0,-1,-2,-3) xx 2],

  'simple additive sequence with three items on the LHS',
    (1,3,5), 10, [(1,3,5,7,9) xx 2, (3,5,7,9) xx 2],

  'simple multiplicative sequence with three items on the LHS',
    (1,3,9), 100, [(1,3,9,27,81) xx 2, (3,9,27,81) xx 2],

  'decreasing multiplicative sequence with three items on the LHS',
    (81,27,9), 8/9, [(81,27.0,9.0,3.0,1.0) xx 2,(27.0,9.0,3.0,1.0) xx 2],

  'simple sequence with one item and block closure on the LHS',
    (1,{$_+2}), 10, (1,3,5,7,9,11,13,15,17,19),

  'simple sequence with one item and * closure on the LHS',
    (1,*+2), 10, (1,3,5,7,9,11,13,15,17,19),

  'simple sequence with three items and block closure on the LHS',
    (1,3,5,{$_+2}), 14, (1,3,5,7,9,11,13,15,17,19),

  'tricky sequence with one item and closure on the LHS',
    (1,{1/((1/$_)+1)}), 11/60, (1,0.5,1/3,0.25,0.2,1/6,1/7,0.125,1/9,0.1),

  'simple sequence with one item on the LHS',
    1, *, 1..10,

  'simple additive sequence with two items on the LHS',
    (1,3), *, (1,3,5,7,9,11,13,15,17,19),

  'simple decreasing additive sequence with two items on the LHS',
    (1,0), *, (1,0,-1,-2,-3,-4,-5,-6,-7,-8),

  'simple decreasing additive sequence with three items on the LHS',
    (8,7,6), *, (8,7,6,5,4,3,2,1,0,-1),

  'simple multiplicative sequence with three items on the LHS',
    (1,3,9), *, (1,3,9,27,81,243,729,2187,6561,19683),

  'decreasing multiplicative sequence with three items on the LHS',
    (81,27,9), *, (81,27.0,9.0,3.0,1.0,1/3,1/9,1/27,1/81,1/243),

  'simple sequence with one item and block closure on the LHS',
    (1,{$_+2}), *, (1,3,5,7,9,11,13,15,17,19),

  'simple sequence with one item and * closure on the LHS',
    (1,*+2), *, (1,3,5,7,9,11,13,15,17,19),

  'simple sequence with one item and closure on the LHS',
    (1,{$_-2}), *, (1,-1,-3,-5,-7,-9,-11,-13,-15,-17),

  'simple sequence with three items and block closure on the LHS',
    (1,3,5,{$_+2}), *, (1,3,5,7,9,11,13,15,17,19),

  'tricky sequence with one item and closure on the LHS',
    (1,{1/((1/$_)+1)}), *, (1,0.5,1/3,0.25,0.2,1/6,1/7,0.125,1/9,0.1),

  'simple alternating sequence with one item and closure on the LHS',
    (1,{-$_}), *, (1,-1,1,-1,1,-1,1,-1,1,-1),

  'simple sequence with two further terms on the RHS',
    1, (*,6,7), 1..10,

  'simple sequence with two extra terms on the RHS',
    1, (*,4,3), 1..10,

  'simple sequence with two weird items on the RHS',
    1, (*,"foo","bar"), 1..10,

  'constant sequence started with letter and identity closure',
    ('c',{$_}), *, 'c' xx 10,

  'constant sequence started with two letters',
    ('c','c'), *, 'c' xx 10,

  'constant sequence started with three letters',
    ('c','c','c'), *, 'c' xx 10,

  'constant sequence started with two numbers',
    (1,1), *, 1 xx 10,

  'constant sequence started with three numbers',
    (1,1,1), *, 1 xx 10,

  'sequence started with three identical numbers, but then goes arithmetic',
    (1,1,1,2,3), 7, (1,1,1,2,3,4,5,6,7),

  'sequence started with three identical numbers, but then goes geometric',
    (1,1,1,2,4), 16, (1,1,1,2,4,8,16),

  'geometric sequence started in one direction and continues in the other',
    (4,2,1,2,4), 16, (4,2,1,2,4,8,16),

  'alternating False and True',
    (False,&prefix:<!>), *, |(False,True) xx 5,

  'alternating False and True',
    (False,{!$_}), *, |(False,True) xx 5,

  'using &[+] works',
    (1,2,&[+]), 8, (1,2,3,5,8),

  'geometric sequence that never reaches its limit',
    (1,1/2,1/4), 0, (1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512),

  'alternating geometric sequence that never reaches its limit',
    (1,-1/2,1/4), 0, (1,-1/2,1/4,-1/8,1/16,-1/32,1/64,-1/128,1/256,-1/512),

  'no more: limit value is on the wrong side',
    (1,2), 0, (),

  '-3 ... ^3 produces just one zero',
    -3, ^3, [(-3,-2,-1,0,1,2),(-3,-2,-1,1,2),(-2,-1,0,1,2),(-2,-1,1,2)],

  'geometric sequence started in one direction and continues the other',
    4, ^5, [(4,3,2,1,0,1,2,3,4),(4,3,2,1,1,2,3,4),(3,2,1,0,1,2,3,4),(3,2,1,1,2,3,4)],

  'geometric sequence that does not hit the limit in its seed',
    (1,2,4), 3, [(1,2) xx 2, (2,) xx 2],

  'sequence that aborts during LHS',
    (1,2,4), 2, (1,2),

  'sequence that does not hit the limit',
    (1,2,4), 1.5, [(1,) xx 2, () xx 2],

  'sequence that aborts during LHS',
    (1,2,4), 1, 1,

  'geometric sequence with smaller RHS and sign change',
    (1,-2,4), 1, 1,

  'geometric sequence with smaller RHS and sign change',
    (1,-2,4), 2, (1,-2,4,-8,16,-32,64,-128,256,-512),

  'geometric sequence with smaller RHS and sign change',
    (1,-2,4), 3, [(1,-2) xx 2, (-2,) xx 2],

  'geometric sequence with sign-change and non-matching end point',
    (1,-2,4), 25, [(1,-2,4,-8,16) xx 2, (-2,4,-8,16) xx 2],

  'sequence that aborts during LHS, before actual calculations kick in',
    (1,2,4,5,6), 2, (1,2),

  'sequence that aborts during LHS, before actual calculations kick in',
    (1,2,4,5,6), 3, [(1,2) xx 2, (2,) xx 2],

  '1, +* works for sequence',
    (1,+*), *, 1 xx 10,

  'sequence with code on the rhs',
    (1,2), *>=5, 1..5,

  'sequence with code on the rhs',
    (1,2), *>5, 1..6,

  'sequence that lasts in the last item of lhs',
    (1,2,{last if $_>=5;$_+1}), *, [(1..5) xx 2, (2..5) xx 2],

  'sequence may be terminated by calling last from the generator function',
    (5,4,3,{$_-1||last}), *, [(5,4,3,2,1) xx 2, (4,3,2,1) xx 2],

  'range as LHS with fixed endpoint',
    (1..*), 5, 1..5,

  'stop on a matching type (1)',
    (32,16,8), Rat, (32,16.0),

  'stop on a matching type (2)',
    (32,{($_/2).narrow}), Rat, (32,16,8,4,2,1,0.5),

  'use &[+] on infix:<...> series',
    (1,1,&[+]), *, (1,1,2,3,5,8,13,21,34,55),

  'WhateverCode with arity > 3 gets enough arguments',
    (1,1,2,4,8,*+*+*+*), *, (1,1,2,4,8,15,29,56,108,208),

  'arity-2 convergence limit',
    (8,*/2), (*-*).abs < 2, (8,4.0,2.0,1.0),

  'arity-Inf limit',
    1, {@_ eq "1 2 3"}, (1,2,3),

  'sequence stops when type of endpoint matches',
    {quietly $_ > 3 ?? 'liftoff' !! $_ + 1}, Str, (1,2,3,4,'liftoff'),

  'sequence of two interleaved sequences',
    (1,1,{slip $^a+1, $^b*2}), *,  (1,1,2,2,3,4,4,8,5,16),

  'sequence of three interleaved sequences',
    (1,1,1,{slip $^a+1, $^b*2, $^c-1}), *, (1,1,1,2,2,0,3,4,-1,4),

  'sequence with list-returning block',
    (1,{|($^n+1 xx $^n+1)}), *, (1,2,2,3,3,3,4,4,4,4),

  'sequence with arity < number of return values',
    ('a','b',{slip $^a~'x', $^a~$^b, $^b~'y'}), *, <a b ax ab by abx abby byy abbyx abbybyy>,

  'sequence with arity > number of return values',
    ('a','b','c',{slip $^x~'x', $^y~'y'~$^z~'z'}), *, <a b c ax bycz cx axybyczz byczx cxyaxybyczzz axybyczzx>,

  '0-ary generator output can be slipped from the start',
     -> {slip 'zero','one'}, *, <zero one zero one zero one zero one zero one>,

  'sequence with RHS junction I',
    (10,8), 2|3, (10,8,6,4,2),

  'sequence with RHS junction II',
    (11,9), 2|3, (11,9,7,5,3),

  'finite sequence started with one letter',
    'a', 'g', "a" .. "g",

  'sequence started with one letter',
    'a', *, 'a' .. 'j',

  'sequence started with two different letters',
    <a b>, *, 'a' .. 'j',

  'character sequence started from array',
    @abc, *, 'a' .. 'j',

  'using a lazy array as a LHS',
    @fib, 8, (0,1,1,2,3,5,8),

  'descending sequence started with one letter',
    'i', 'a', <i h g f e d c b a>,

  'descending sequence started with two different letters',
    <i h>, 'a', <i h g f e d c b a>,

  'descending sequence started with three different letters',
    <i h g>, 'a', <i h g f e d c b a>,

  'characters and arity-1',
    ('a','b',{.succ}), *, 'a' .. 'j',

  'sequence ending with "z" does not cross to two-letter strings',
    'x', 'z', <x y z>,

  'single letters follow codepoint logic 1',
    'Z', 'a', ('Z','[','\\',']','^','_','`','a'),

  'single letters follow codepoint logic 2',
    'α', 'θ', <α β γ δ ε ζ η θ>,

  'sequence from "☀" to "☆"',
    "☀", "☆", ("☀", "☁", "☂", "☃", "☄", "★", "☆"),

  'unicode blocks',
    "▁", "█", ("▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"),

  'unicode blocks reversed',
    "█", "▁", ("█", "▇", "▆", "▅", "▄", "▃", "▂", "▁"),

  'mixture',
    '.', '0', ('.','/','0'),

  'intuition does not try to cmp a WhateverCode',
    H.new(5), *.x > 8, (H.new(5),H.new(6),H.new(7),H.new(8),H.new(9)),
);

# Run the tests
for @tests -> \description, \seed, \endpoint, \result {
    test-seq(description, seed, endpoint, result)
}

done-testing;

# vim: expandtab shiftwidth=4
