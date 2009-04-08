use v6;
use Test;

plan 37;

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
    #?rakudo todo 'my @x of Int'
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
    #?rakudo 5 todo 'type checks on typed arrays'
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
    my Array of Int @x;
    #?rakudo todo 'Array not parametric'
    ok @x.of === Array[Int], 'my Array of Int @x declaeres a nested array';
    lives_ok { @x = [2, 3], [5, 6] }, 'assignment works';
    lives_ok { @x.push: [8, 9] }, 'pushing works';
    #?rakudo todo 'type constraints on typed arrays'
    dies_ok  { @x.push: 8 }, 'type constraint is enforced';
    lives_ok { @x[0].push: 3 }, 'pushing to the inner array is OK';
    #?rakudo todo 'type constraints on typed arrays'
    dies_ok  { @x[0].push: 'foo' }, 'inner array enforces the type constraint';

}
