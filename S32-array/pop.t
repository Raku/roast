use v6;
use Test;

# L<S32::Containers/"Array"/"=item pop">

=begin description

Pop tests

=end description

plan 33;

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
}

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
}

# invocant syntax with inline arrays
{
    is([1, 2, 3].pop, 3, 'this will return 3');
    ok(!defined([].pop), 'this will return undefined');
    ok( [].pop ~~ Failure, '[].pop is a Failure' );
}

# some edge cases

{
    my @pop;
    ok(!defined(@pop.pop()), 'pop on an un-initialized array returns undefined');
    ok( @pop.pop() ~~ Failure, 'pop off uninitialized array is a Failure' );
}

# testing some error cases
{
    my @pop = 1 .. 5;
    eval_dies_ok('pop',        'pop() requires arguments');
    eval_dies_ok('42.pop'    , '.pop should not work on scalars');
    nok try {eval('pop(@pop, 10)')}, 'pop() should not allow extra arguments';
    nok try {eval('@pop.pop(10)') }, 'pop() should not allow extra arguments';
}

# Pop with Inf arrays (waiting on answers from perl6-compiler email)
# {
#     my @push = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'pop @push' }, '?? what should this error message be ??', 'cannot push onto a Inf array';
# }

done;

# vim: ft=perl6
