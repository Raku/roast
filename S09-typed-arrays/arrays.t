use v6;
use Test;

plan 47;

# L<S09/Typed arrays/>

{
    my Int @x;
    ok @x.of === Int, '@x.of of typed array (my Int @x)';
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type';
    lives_ok { @x = 1..3    }, 'can assign range of the right type';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array';
    is @x.unshift, 2, 'can unshift from typed array';
}

{
    my @x of Int;
    ok @x.of === Int, '@x.of of typed array (my @x of Int)';
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type (@x of Int)';
    lives_ok { @x = 1..3    }, 'can assign range of the right type (@x of Int)';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type (@x of Int)';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type (@x of Int)';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (@x of Int)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (@x of Int)';
    is @x.unshift, 2, 'can unshift from typed array (@x of Int)';
}

# initialization 
lives_ok { my @x = 1, 2, 3 }, 'initialization of typed array';
lives_ok { my @x = 1 .. 3 }, 'initialization of typed array from range';

{
    my @x of Int;
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type (@x of Int)';
    lives_ok { @x = 1..3    }, 'can assign range of the right type (@x of Int)';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type (@x of Int)';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type (@x of Int)';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (@x of Int)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (@x of Int)';
    is @x.unshift, 2, 'can unshift from typed array (@x of Int)';
}

{
    my Array @x;
    dies_ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies_ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies_ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies_ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies_ok { @x[0, 2] = 2, 3}, 
            'can not assign values of wrong type to a slice';
    lives_ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
}

{
    my @x of Array;
    dies_ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies_ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies_ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies_ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies_ok { @x[0, 2] = 2, 3}, 
            'can not assign values of wrong type to a slice';
    lives_ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
}

#?rakudo skip 'Array not parametric'
{
    my Array of Int @x;
    ok @x.of === Array[Int], 'my Array of Int @x declaeres a nested array';
    lives_ok { @x = [2, 3], [5, 6] }, 'assignment works';
    lives_ok { @x.push: [8, 9] }, 'pushing works';
    dies_ok  { @x.push: 8 }, 'type constraint is enforced';
    lives_ok { @x[0].push: 3 }, 'pushing to the inner array is OK';
    dies_ok  { @x[0].push: 'foo' }, 'inner array enforces the type constraint';
}

# test that lists/arrays returned from array methods are typed as well
{
    my Int @a = 1, 2, 3;
    my Int @b;
    lives_ok { @b = @a }, 'can assign typed array to typed array';
    #?rakudo todo 'Array methods should return typed arrays'
    ok @a.values.of === Int, '@a.values is typed (1)';
    lives_ok { @b = @a.values }, '@a.values is typed (2)';

    my Str @c = <foo bar baz>;
    #?rakudo todo 'Array methods should return typed arrays'
    is @c.keys.of, Int, '@array.keys is typed with Int';
}

# vim: ft=perl6
