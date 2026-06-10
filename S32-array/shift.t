use Test;

# L<S32::Containers/"Array"/"=item shift">

=begin description

Shift tests

=end description

plan 35;

{

    my @shift = (1, 2, 3, 4, 5);

    is(+@shift, 5, 'we have 4 elements in our array');
    my $a = shift(@shift);
    is($a, 1, 'shift(@shift) works');

    is(+@shift, 4, 'we have 3 elements in our array');
    $a = shift @shift;
    is($a, 2, 'shift @shift works');

    is(+@shift, 3, 'we have 2 elements in our array');
    $a = @shift.shift();
    is($a, 3, '@shift.shift() works');

    is(+@shift, 2, 'we have 1 element in our array');
    $a = @shift.shift;
    is($a, 4, '@shift.shift works');

    {
        is(+@shift, 1, 'we have 1 element in our array');
        $a = shift(@shift);

        is(+@shift, 0, 'we have no elements in our array');
        ok(!defined(shift(@shift)), 'after the array is exhausted it gives undefined');
    }
}

{
    my @shift = (1, 2, 3, 4);

    is(+@shift, 4, 'we have 4 elements in our array');
    is(shift(@shift), 1, 'inline shift(@shift) works');

    is(+@shift, 3, 'we have 3 elements in our array');
    is((shift @shift), 2, 'inline shift @shift works');

    is(+@shift, 2, 'we have 2 elements in our array');
    is(@shift.shift(), 3, 'inline @shift.shift() works');

    is(+@shift, 1, 'we have 1 elements in our array');
    is(@shift.shift, 4, 'inline @shift.shift works');

    is(+@shift, 0, 'we have no elements in our array');
    ok(!defined(shift(@shift)), 'again, the array is exhausted and we get undefined');
    ok( shift(@shift) ~~ Failure, 'again, Failure from shifting empty array' );
}

# invocant syntax with inline arrays
{
    is([1, 2, 3].shift, 1, 'this will return 1');
    ok(!defined([].shift), 'this will return undefined');
    ok( [].shift ~~ Failure, 'shift of empty array is Failure' );
}

# testing some edge cases
{
    my @shift;
    ok(!defined(shift(@shift)), 'shift on an empty array returns undefined');
    ok( shift(@shift) ~~ Failure, 'shift on empty array is Failure');
}

# testing some error cases
{
    my @shift = 1 .. 5;
    throws-like 'shift()', X::TypeCheck::Argument, 'shift() requires arguments';
    throws-like '42.shift', X::Method::NotFound, '.shift should not work on scalars';
    dies-ok { EVAL('shift(@shift, 10)') }, 'shift() should not allow extra arguments';
    dies-ok { EVAL(' @shift.shift(10)') }, 'shift() should not allow extra arguments';
}

# Shift with Inf arrays
{
    my @a = 1 .. Inf;
    is-deeply @a.shift, 1, 'can shift off of an Inf array: 1';
    is-deeply @a.shift, 2, 'can shift off of an Inf array: 2';
}

{
    my @a = 1,2;
    @a[0]:delete;
    ok @a.shift === @a.default,
      "shifting sparse array does not result in failure";
    is @a.elems, 1, "and it actually shifted the array";
}

# vim: expandtab shiftwidth=4
