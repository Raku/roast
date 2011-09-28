use v6;

use Test;

plan 22;

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
    #?niecza skip 'Excess arguments to CORE infix:<min>'
    is 1 min 2 min 3, 1, 'ooh! 3 numbers! More difficult';
    #?niecza skip 'Excess arguments to CORE infix:<max>'
    is 1 max 2 max 3, 3, 'again! 3 numbers!';
    #?rakudo 2 todo "max/min non-associative NYI"
    eval_dies_ok q{1 min 2 max 3}, 'No! No left-associativeness!';
    eval_dies_ok q{1 max 2 min 3}, 'This is also not OK';
}

#?niecza skip 'System.FormatException: Unknown char: f'
{
    is "foo" min +Inf, "foo";
    is "foo" min -Inf, -Inf;
    is "foo" max +Inf, +Inf;
    is "foo" max -Inf, "foo";
}

#testing the minmax operator
#?niecza skip 'minmax NYI'
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

#array vs. scalar
#?rakudo todo "Annoying test that we haven't done the obvious yet unspecced, fails because we have indeed done the obvious"
{
    #NYS- Not Yet Specced. C<isnt>'d only so those sneaky programmers can't get away with coding
    #what `makes sense' and `probably will be anyway' :) --lue
    my @a = 1, 2, 3;
    isnt @a min 4, 1, 'NYS';
    #?niecza skip 'TODO'
    isnt @a max 4, 4, 'NYS';
}

# RT #61836
# RT #77868
{
    #?niecza skip 'TODO'
    is 2 min Any, 2, '2 min Any';
    #?niecza skip 'TODO'
    is Any min 2, 2, 'Any min 2';
    is 2 max Any, 2, '2 max Any';
    is Any max 2, 2, 'Any max 2';
}
