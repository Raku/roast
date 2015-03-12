use v6;

use Test;

plan 29;

# L<S03/Tight or precedence/Minimum and maximum>
# L<S03/Tight or precedence/"any value of any type may be compared with +Inf
# or -Inf values">
# L<S03/List infix precedence/"C<< infix:<minmax> >>, the minmax operator">

=begin description

This test min/max functions in their operator form. To see them tested in their other forms, see C<t/spec/S32-list/minmax.t>

=end description

#General min/max tests
{
    is 1 min 2, 1, 'can ye handle that?';
    is 1 max 2, 2, 'how about this?';
    is 1 min 2 min 3, 1, 'ooh! 3 numbers! More difficult';
    is 1 max 2 max 3, 3, 'again! 3 numbers!';
    throws_like q{1 min 2 max 3},
        X::Syntax::NonAssociative,
        'No! No left-associativeness!';
    throws_like q{1 max 2 min 3},
        X::Syntax::NonAssociative,
        'This is also not OK';
    is "alpha" min "beta", "alpha", 'min works for strings, too';
    is "alpha" max "beta", "beta", 'max works for strings, too';
}

{
    is "foo" min +Inf, "foo";
    is "foo" min -Inf, -Inf;
    is "foo" max +Inf, +Inf;
    is "foo" max -Inf, "foo";
}

#testing the minmax operator
{
    my @a = 1,2,3,4;
    my @b = 9,8,7,1;
    is((@a minmax @b), 1..9, "minmax works on two arrays");
    is((1,2 minmax 9,8), 1..9, "minmax works on two lists");
    is((1,8 minmax 4,5), 1..8, 'minmax works when both are on left list');
    is((4,5 minmax 1,8), 1..8, 'minmax works when both are on right list');
    @a = 1,8,2,9;
    @b = 4,7,5,6;
    is((@a minmax @b), 1..9, 'minmax works when both are on left array');
    is((@b minmax @a), 1..9, 'minmax works when both are on right array');
}

{
    my @a = <Inspiring bold John Barleycorn!>;
    my @b = <What dangers thou canst make us scorn!>;
    is (@a minmax @b).perl, ("Barleycorn!".."us").perl, 'minmax works for strings, too';
}

{
    is((1..2 minmax 8..9), 1..9, "minmax works on two disjoint ranges");
    is((1..6 minmax 4..9), 1..9, "minmax works on two overlapping ranges");
    is((1..8 minmax 4..5), 1..8, 'minmax works when both are on left list');
    is((4..5 minmax 1..8), 1..8, 'minmax works when both are on right list');
}

#array vs. scalar
#?rakudo skip "Annoying test that we haven't done the obvious yet unspecced, fails because we have indeed done the obvious"
#?niecza todo
{
    #NYS- Not Yet Specced. C<isnt>'d only so those sneaky programmers can't get away with coding
    #what `makes sense' and `probably will be anyway' :) --lue
    my @a = 1, 2, 3;
    isnt @a min 4, 1, 'NYS';
    isnt @a max 4, 4, 'NYS';
}

# RT #61836
# RT #77868
{
    # I am very suspicious of the following tests.  As I understand it, cmp can compare 
    # Reals, and cmp can compare two objects of the same type.  Otherwise it is only 
    # required to be consistent, not to have a particular result. --colomon

    #?niecza todo
    is 2 min Any, 2, '2 min Any';
    #?niecza todo
    is Any min 2, 2, 'Any min 2';
    is 2 max Any, 2, '2 max Any';
    #?niecza todo
    is Any max 2, 2, 'Any max 2';
}
