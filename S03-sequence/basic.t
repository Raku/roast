use v6;
use Test;

# L<S03/List infix precedence/"the sequence operator">

plan 132;

# single-term sequence

is ~( 1  ...  1 ), '1', '1 ... 1';
is ~( 'a'  ...  'a' ), 'a', "'a' ... 'a'";

# finite sequence that exactly hit their limit

is (1 ... 5).join(', '), '1, 2, 3, 4, 5', 'simple sequence with one item on the LHS';
is (1 ... -3).join(', '), '1, 0, -1, -2, -3', 'simple decreasing sequence with one item on the LHS';
is (1, 3 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple additive sequence with two items on the LHS';
is (1, 0 ... -3).join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive sequence with two items on the LHS';
is (1, 3, 5 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple additive sequence with three items on the LHS';
is (1, 3, 9 ... 81).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative sequence with three items on the LHS';
is (81, 27, 9 ... 1).join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative sequence with three items on the LHS';
is (1, { $_ + 2 } ... 9).join(', '), '1, 3, 5, 7, 9', 'simple sequence with one item and block closure on the LHS';
is (1, *+2 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple sequence with one item and * closure on the LHS';
is (1, { $_ - 2 } ... -7).join(', '), '1, -1, -3, -5, -7', 'simple sequence with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... 13).join(', '), '1, 3, 5, 7, 9, 11, 13', 'simple sequence with three items and block closure on the LHS';
is (1, { 1 / ((1 / $_) + 1) } ... 1/5).map({.perl}).join(', '), '1, 0.5, <1/3>, 0.25, 0.2', 'tricky sequence with one item and closure on the LHS';
is (1, { -$_ } ... 1).join(', '), '1', 'simple alternating sequence with one item and closure on the LHS';
is (1, { -$_ } ... 3).[^5].join(', '), '1, -1, 1, -1, 1', 'simple alternating sequence with one item and closure on the LHS';

is ({ 3+2; } ... *).[^5].join(', '), '5, 5, 5, 5, 5', 'sequence with one scalar containing Code on the LHS';

is (1 ... 5, 6, 7).join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple sequence with two further terms on the RHS';
is (1 ... 5, 4, 3).join(', '), '1, 2, 3, 4, 5, 4, 3', 'simple sequence with two extra terms on the RHS';
is (1 ... 5, 'xyzzy', 'plugh').join(', '), '1, 2, 3, 4, 5, xyzzy, plugh', 'simple sequence with two weird items on the RHS';

# infinite sequence that go past their limit
{
is (1 ... 5.5).[^6].join(', '), '1, 2, 3, 4, 5, 6', 'simple sequence with one item on the LHS';
is (1 ... -3.5).[^6].join(', '), '1, 0, -1, -2, -3, -4', 'simple decreasing sequence with one item on the LHS';
is (1, 3 ... 10).[^6].join(', '), '1, 3, 5, 7, 9, 11', 'simple additive sequence with two items on the LHS';
is (1, 0 ... -3.5).[^6].join(', '), '1, 0, -1, -2, -3, -4', 'simple decreasing additive sequence with two items on the LHS';
is (1, 3, 5 ... 10).[^6].join(', '), '1, 3, 5, 7, 9, 11', 'simple additive sequence with three items on the LHS';
is (1, 3, 9 ... 100).[^6].join(', '), '1, 3, 9, 27, 81, 243', 'simple multiplicative sequence with three items on the LHS';
is (81, 27, 9 ... 8/9).[^6], (81, 27, 9, 3, 1, 1/3), 'decreasing multiplicative sequence with three items on the LHS';
is (1, { $_ + 2 } ... 10).[^6].join(', '), '1, 3, 5, 7, 9, 11', 'simple sequence with one item and block closure on the LHS';
is (1, *+2 ... 10).[^6].join(', '), '1, 3, 5, 7, 9, 11', 'simple sequence with one item and * closure on the LHS';
is (1, { $_ - 2 } ... -8).[^6].join(', '), '1, -1, -3, -5, -7, -9', 'simple sequence with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... 14).[^8].join(', '), '1, 3, 5, 7, 9, 11, 13, 15', 'simple sequence with three items and block closure on the LHS';
is (1, { 1 / ((1 / $_) + 1) } ... 11/60).[^6].map({.perl}).join(', '), '1, 0.5, <1/3>, 0.25, 0.2, <1/6>', 'tricky sequence with one item and closure on the LHS';
is (1, { -$_ } ... 0).[^4].join(', '), '1, -1, 1, -1', 'simple alternating sequence with one item and closure on the LHS';

is (1 ... 5.5, 6, 7).[^8].join(', '), '1, 2, 3, 4, 5, 6, 7, 8', 'simple sequence with two further terms on the RHS';
is (1 ... 5.5, 4, 3).[^8].join(', '), '1, 2, 3, 4, 5, 6, 7, 8', 'simple sequence with two extra terms on the RHS';
is (1 ... 5.5, 'xyzzy', 'plugh').[^8].join(', '), '1, 2, 3, 4, 5, 6, 7, 8', 'simple sequence with two weird items on the RHS';
}
# infinite sequence without limits

is (1 ... *).[^5].join(', '), '1, 2, 3, 4, 5', 'simple sequence with one item on the LHS';
is (1, 3 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive sequence with two items on the LHS';
is (1, 0 ... *).[^5].join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive sequence with two items on the LHS';
is (1, 3, 5 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive sequence with three items on the LHS';
is (8, 7, 6 ... *).[^5].join(', '), '8, 7, 6, 5, 4', 'simple decreasing additive sequence with three items on the LHS';
is (1, 3, 9 ... *).[^5].join(', '), '1, 3, 9, 27, 81', 'simple multiplicative sequence with three items on the LHS';
is (81, 27, 9 ... *).[^5].join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative sequence with three items on the LHS';
is (1, { $_ + 2 } ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple sequence with one item and block closure on the LHS';
is (1, *+2 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple sequence with one item and * closure on the LHS';
is (1, { $_ - 2 } ... *).[^5].join(', '), '1, -1, -3, -5, -7', 'simple sequence with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... *).[^7].join(', '), '1, 3, 5, 7, 9, 11, 13', 'simple sequence with three items and block closure on the LHS';
is (1, { 1 / ((1 / $_) + 1) } ... *).[^5].map({.perl}).join(', '), '1, 0.5, <1/3>, 0.25, 0.2', 'tricky sequence with one item and closure on the LHS';
is (1, { -$_ } ... *).[^5].join(', '), '1, -1, 1, -1, 1', 'simple alternating sequence with one item and closure on the LHS';

is (1 ... *, 6, 7).[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple sequence with two further terms on the RHS';
is (1 ... *, 4, 3).[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple sequence with two extra terms on the RHS';
is (1 ... *, 'xyzzy', 'plugh').[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple sequence with two weird items on the RHS';

# constant sequence

is ('c', { $_ } ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant sequence started with letter and identity closure';
is ('c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant sequence started with two letters';
is ('c', 'c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant sequence started with three letters';
is (1, 1 ... *).[^10].join(', '), '1, 1, 1, 1, 1, 1, 1, 1, 1, 1', 'constant sequence started with two numbers';
is (1, 1, 1 ... *).[^10].join(', '), '1, 1, 1, 1, 1, 1, 1, 1, 1, 1', 'constant sequence started with three numbers';

# misleading starts

is (1, 1, 1, 2, 3 ... 10).[^10].join(', '), '1, 1, 1, 2, 3, 4, 5, 6, 7, 8', 'sequence started with three identical numbers, but then goes arithmetic';
is (1, 1, 1, 2, 4 ... 16).join(', '), '1, 1, 1, 2, 4, 8, 16', 'sequence started with three identical numbers, but then goes geometric';
is (4, 2, 1, 2, 4 ... 16).join(', '), '4, 2, 1, 2, 4, 8, 16', 'geometric sequence started in one direction and continues in the other';

# some tests taken from Spec

is (False, &prefix:<!> ... *).[^6].join(', '), (False, True, False, True, False, True).join(', '), "alternating False and True";
is (False, &prefix:<!> ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";
#?niecza skip '&[] NYI'
is (1,2,&[+] ... 8).join(', ') , "1, 2, 3, 5, 8" , "Using &[+] works";
is (False, { !$_ } ... *).[^6].join(', '), (False, True, False, True, False, True).join(', '), "alternating False and True";
is (False, { !$_ } ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";

# L<S03/List infix precedence/'"asymptotically approaching" is not the same as "equals"'>
# infinite sequence with limits

is ~(1, 1/2, 1/4 ... 0).[^5].map({.perl}), '1 0.5 0.25 0.125 0.0625', 'geometric sequence that never reaches its limit';
is ~(1, -1/2, 1/4 ... 0).[^5].map({.perl}), '1 -0.5 0.25 -0.125 0.0625', 'alternating geometric sequence that never reaches its limit';
is (1, { 1 / ((1 / $_) + 1) } ... 0).[^5].map({.perl}).join(', '), '1, 0.5, <1/3>, 0.25, 0.2', '"harmonic" sequence that never reaches its limit';

# empty sequence

# L<S03/List infix precedence/'limit value is on the "wrong"'>
{
is (1, 2 ... 0).[^3], (1,2,3), 'No more: limit value is on the wrong side';
}

# L<S03/List infix precedence/excludes the limit if it happens to match exactly>
# excluded limits via "...^"
{
    is (1 ...^ 5).join(', '), '1, 2, 3, 4', 'exclusive sequence';
    is (1 ...^ -3).join(', '), '1, 0, -1, -2', 'exclusive decreasing sequence';
    is (1 ...^ 5.5).[^6].join(', '), '1, 2, 3, 4, 5, 6', "exclusive sequence that couldn't hit its limit anyway";
    is (1, 3, 9 ...^ 81).join(', '), '1, 3, 9, 27', 'exclusive geometric sequence';
    is (81, 27, 9 ...^ 2).[^5].join(', '), '81, 27, 9, 3, 1', "exclusive decreasing geometric sequence that couldn't hit its limit anyway";
    is (2, -4, 8 ...^ 32).join(', '), '2, -4, 8, -16', 'exclusive alternating geometric sequence';
    is (2, -4, 8 ...^ -32).[^6].join(', '), '2, -4, 8, -16, 32, -64', 'exclusive alternating geometric sequence (not an exact match)';
    is (1, { $_ + 2 } ...^ 9).join(', '), '1, 3, 5, 7', 'exclusive sequence with closure';
    is (1 ...^ 1), (), 'empty exclusive sequence';
    is (1, 1 ...^ 1), (), 'empty exclusive constant sequence';
    is (1, 2 ...^ 0).[^3], (1, 2, 3), 'empty exclusive arithmetic sequence';
    is (1, 2 ...^ 0, 'xyzzy', 'plugh').[^3].join(', '), '1, 2, 3', 'exclusive sequence empty but for extra items';
    is ~(1 ...^ 0), '1', 'singleton exclusive sequence';
    is (4...^5).join(', '), '4', '4...^5 should parse as 4 ...^ 5 and not 4 ... ^5';
}


# RT #75698
ok ?(one((-5 ... ^5).flat) == 0), '-5 ... ^5 produces just one zero';

# RT #75316
#?niecza skip 'Typed exceptions NYI'
throws_like { 1 ... () },
     X::Cannot::Empty,
     'RT #75698 - empty list on right side of sequence operator does not cause infinite loop (but throws exception)',
     action => '.shift',
     what   => 'List';

# RT #73508
is (1,2,4...*)[10], 1024,
    'element from list generated using infinite sequence is accessible by index';

# RT #72914
is (4 ... ^5).join(', '), '4, 3, 2, 1, 0, 1, 2, 3, 4',
    'geometric sequence started in one direction and continues in the other with exclusion';

lives_ok { (1 ... 5).perl }, 'Can take .perl of sequence';
is EVAL((1 ... 5).perl).join(','), '1,2,3,4,5',
    'EVAL($sequence.perl) reproduces result list';

# RT 98790
is ~((1 ... *) Z~ ('a' ... 'z')).[^5], "1a 2b 3c 4d 5e", "Zipping two sequence in parallel";

{
    is (1, 2, 4 ... 3).[^4], (1, 2, 4, 8), "sequence that does not hit the limit";
    is (1, 2, 4 ... 2), (1, 2), "sequence that aborts during LHS";

    is (1, 2, 4 ... 1.5).[^4], (1,2,4,8), "sequence that does not hit the limit";
    is (1, 2, 4 ... 1), (1), "sequence that aborts during LHS";

    is ~(1, -2, 4 ... 1), '1', 'geometric sequence with smaller RHS and sign change';
    is ~(1, -2, 4 ... 2).[^4], '1 -2 4 -8', 'geometric sequence with smaller RHS and sign change';
    is ~(1, -2, 4 ... 3).[^4], '1 -2 4 -8', 'geometric sequence with smaller RHS and sign change';
    is ~(1, -2, 4 ... 25).[^10], '1 -2 4 -8 16 -32 64 -128 256 -512', 'geometric sequence with sign-change and non-matching end point';

    is (1, 2, 4, 5, 6 ... 2), (1, 2), "sequence that aborts during LHS, before actual calculations kick in";

    is (1, 2, 4, 5, 6 ... 3).[^6], (1,2,4,5,6,7), "sequence that aborts during LHS, before actual calculations kick in";
}

# tests for the types returned

{
    my @a = 1, 2, 3 ... 100;
    is @a.elems, 100, "1, 2, 3 ... 100 generates a sequence with one hundred elements...";
    is @a.grep(Int).elems, 100, "... all of which are Ints";
}

{
    my @a = 1.Rat, 2.Rat, 3.Rat ... 100;
    is @a.elems, 100, "1.Rat, 2.Rat, 3.Rat ... 100 generates a sequence with one hundred elements...";
    is @a.grep(Rat).elems, 100, "... all of which are Rats";
}

{
    my @a = 1.Num, 2.Num, 3.Num ... 100;
    is @a.elems, 100, "1.Num, 2.Num, 3.Num ... 100 generates a sequence with one hundred elements...";
    is @a.grep(Num).elems, 100, "... all of which are Nums";
}

{
    my @a = 1, 2, 4 ... 64;
    is @a.elems, 7, "1, 2, 4 ... 64 generates a sequence with seven elements...";
    is @a.grep(Int).elems, @a.elems, "... all of which are Ints";
}

{
    my @a = 1.Rat, 2.Rat, 4.Rat ... 64;
    is @a.elems, 7, "1.Rat, 2.Rat, 4.Rat ... 64 generates a sequence with seven elements...";
    is @a.grep(Rat).elems, 7, "... all of which are Rats";
}

{
    my @a = 1.Num, 2.Num, 4.Num ... 64;
    is @a.elems, 7, "1.Num, 2.Num, 4.Num ... 64 generates a sequence with seven elements...";
    is @a.grep(Num).elems, 7, "... all of which are Nums";
}

# RT #74606
is (1, +* ... *).[^5].join('|'), (1 xx 5).join('|'),
    '1, +* works for sequence';

# RT #75768, RT #98790
is ~(1...10)[2...4], '3 4 5', 'can index sequence with sequence';

{
    is (1, 2 ... *>=5), (1,2,3,4,5), "sequence with code on the rhs";
    is (1, 2 ... *>5), (1,2,3,4,5,6), "sequence with code on the rhs";
    is (1, 2 ...^ *>=5), (1,2,3,4), "exclusive sequence with code on the rhs";
    is (1, 2 ...^ *>5), (1,2,3,4,5), "exclusive sequence with code on the rhs";
}

#?rakudo todo 'sequence + last'
is (1, 2 , {last if $_>=5; $_+1} ... *), (1,2,3,4,5), "sequence that lasts in the last item of lhs";

{
    is (1..* ... 5), (1, 2, 3, 4, 5), '1..* ... 5';
    my @fib := (0, 1, *+* ... * );
    # RT #98790
    is (@fib ... 8), (0 , 1, 1, 2 , 3, 5, 8), '@fib ... 8';
}

# RT #78324
{
    is (32,16,8 ...^ Rat), (32,16,8) , 'stop on a matching type (1)';
    is (32,{($_/2).narrow} ...^ Rat), (32,16,8,4,2,1) , 'stop on a matching type (2)';
}

# RT #75828
eval_dies_ok '1, 2, 3, ... 5', 'comma before sequence operator is caught';

# RT #73268
is ~(1...^*).[^10], '1 2 3 4 5 6 7 8 9 10', 'RT #73268';

# RT #76046
#?niecza skip '&[] NYI'
is (1, 1, &[+] ... *).[^10], '1 1 2 3 5 8 13 21 34 55', 'use &[+] on infix:<...> series';

# see http://irclog.perlgeek.de/perl6/2012-05-30#i_5659147 ff.
# previously rakudo said Not enough positional parameters passed; got 3 but expected 4
is ((1,1,2,4,8)[^4], *+*+*+* ... *)[4], 8, 'WhateverCode with arity > 3 gets enough arguments';

#RT #75674
{
    is (4 ... ^5), <4 3 2 1 0 1 2 3 4>, "RT #75674";
    is (4 ... 0,1,2,3,4), <4 3 2 1 0 1 2 3 4>, "RT #75674";
    is (-5 ... ^5), <-5 -4 -3 -2 -1 0 1 2 3 4>, "RT #75674";
}

is (1 … 10), 1..10, 'Unicode ellipsis works';
is (1 …^ 10), 1..^10, 'Unicode ellipsis works excluding final value';

done;

# vim: ft=perl6
