use v6;
use Test;

plan 22;

# L<S09/Typed arrays/>

{
    my Int @x;
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

