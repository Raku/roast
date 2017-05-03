use v6;
use Test;

# L<S32::Containers/"Array"/"=item pop">

=begin description

Pop tests

=end description

plan 38;

{ # pop() elements into variables
    my @pop = (-1, 1, 2, 3, 4);
    is(+@pop, 5, 'we have 4 elements in the array');

    my $a = pop(@pop);
    is($a, 4, 'pop(@pop) works');

    is(+@pop, 4, 'we have 3 elements in the array');
    $a = pop @pop;
    is($a, 3, 'pop @pop works');

    is(+@pop, 3, 'we have 2 elements in the array');
    $a = @pop.pop();
    is($a, 2, '@pop.pop() works');

    is(+@pop, 2, 'we have 1 element in the array');
    $a = @pop.pop;
    is($a, 1, '@pop.pop works');

    is(+@pop, 1, 'we have 1 element in the array');
    
    {
        $a = pop(@pop);
        is($a, -1, '@pop.pop works');

        is(+@pop, 0, 'we have no more element in the array');
        ok(!defined(pop(@pop)), 'after the array is exhausted pop() returns undefined');
        ok(pop(@pop) ~~ Failure, 'after the array is exhausted pop() returns Failure');
    }
} #13

{ # pop() elements inline
    my @pop = (1, 2, 3, 4);

    is(+@pop, 4, 'we have 4 elements in the array');
    is(pop(@pop), 4, 'inline pop(@pop) works');

    is(+@pop, 3, 'we have 3 elements in the array');
    is((pop @pop), 3, 'inline pop @pop works');

    is(+@pop, 2, 'we have 2 elements in the array');
    is(@pop.pop(), 2, 'inline @pop.pop() works');

    is(+@pop, 1, 'we have 1 element in the array');
    is(@pop.pop, 1, 'inline @pop.pop works');

    is(+@pop, 0, 'we have no more element in the array');
    ok(!defined(pop(@pop)), 'after the array is exhausted pop() returns undefined');
    ok(pop(@pop) ~~ Failure, 'after the array is exhausted pop() returns Failure');
} #11

# invocant syntax with inline arrays
{
    is([1, 2, 3].pop, 3, 'this will return 3');
    ok(!defined([].pop), 'this will return undefined');
    ok( [].pop ~~ Failure, '[].pop is a Failure' );
} #3

# some edge cases
{
    my @pop;
    ok(!defined(@pop.pop()), 'pop on an un-initialized array returns undefined');
    ok( @pop.pop() ~~ Failure, 'pop off uninitialized array is a Failure' );
}

# testing some error cases
{
    my @pop = 1 .. 5;
    throws-like 'pop', X::TypeCheck::Argument, 'pop() requires arguments';
    throws-like '42.pop', X::Method::NotFound, '.pop should not work on scalars';
    throws-like 'pop(@pop,10)', Exception,     'pop() should not allow extra arguments';
    throws-like '@pop.pop(10)', Exception,     '.pop() should not allow extra arguments';
    #?rakudo todo 'code does not die'
    ## TODO test for correct exception once the code dies
    throws-like '@pop.pop = 3', Exception,  'Cannot assign to a readonly variable or a value';
    throws-like 'pop(@pop) = 3', Exception, 'Cannot assign to a readonly variable or a value';
} #6

{
    my @push = 1 .. Inf;
    throws-like 'pop @push', X::Cannot::Lazy, 'cannot pop from a lazy list';
} #1

# RT #111720
{
    my @a = 1,2,3;
    my $rt111720 = Array.new(@a) => "x";
    $rt111720.key[0];
    @a.pop();
    #?rakudo todo 'RT #111720'
    is $rt111720.keys.[0].join("-"), '1-2',
        'reading first key in sink context does not influence later code';
}

# RT #131245
subtest 'no gost elements after pop/shift' => {
    my @a = <a b c>;
    @a.pop;
    @a[3] = 42;
    is-deeply @a, ['a', 'b', Any, 42], '.pop';

    @a = <a b c>;
    @a.shift;
    @a[3] = 42;
    is-deeply @a, ['b', 'c', Any, 42], '.shift';

    my @a = <a b c>;
    pop @a;
    @a[3] = 42;
    is-deeply @a, ['a', 'b', Any, 42], '&pop';

    @a = <a b c>;
    shift @a;
    @a[3] = 42;
    is-deeply @a, ['b', 'c', Any, 42], '&shift';
}

# vim: ft=perl6
