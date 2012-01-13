use v6;
use Test;

plan 59;

# L<S09/Typed arrays/>

{
    my Int @x;
    ok @x.of === Int, '@x.of of typed array (my Int @x)';
    # RT #77748
    ok @x.WHAT.gist ~~ /Array/, '.WHAT.gist of the type object makes sense';
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type';
    lives_ok { @x = 1..3    }, 'can assign range of the right type';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array';
    is @x.unshift(2), [2, 2, 3], 'can unshift from typed array';
}

#?rakudo skip 'of Int'
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
    is @x.unshift(1), [1, 2, 3], 'can unshift from typed array (@x of Int)';
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
    
    ok @x.unshift, 'can unshift from typed array (@x of Int)';
}

{
    my Array @x;
    #?rakudo 5 todo "no parametrization"
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
    #?rakudo 5 todo "no parametrization"
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
    ok @a.values.of === Int, '@a.values is typed (1)';
    lives_ok { @b = @a.values }, '@a.values is typed (2)';

    #?rakudo 2 skip 'initialization'
    my Str @c = <foo bar baz>;
    ok @c.keys.of === Str, '@array.keys is typed with Int';
}

# test that we can have parametric array return types
{
    sub ret_pos_1 returns Positional of Int { my Int @a = 1,2,3; return @a; }
    sub ret_pos_2 returns Positional of Int { my Int @a = 1,2,3; @a }
    sub ret_pos_3 returns Positional of Int { my @a = 1,2,3; return @a; }
    sub ret_pos_4 returns Positional of Int { my @a = 1,2,3; @a }
    sub ret_pos_5 returns Positional of Int { my Num @a = 1,2,3; return @a; }
    sub ret_pos_6 returns Positional of Int { my Num @a = 1,2,3; @a }
    sub ret_pos_7 returns Positional of Num { my Int @a = 1,2,3; return @a; }
    sub ret_pos_8 returns Positional of Num { my Int @a = 1,2,3; @a }
    lives_ok { ret_pos_1() },
        'type check Positional of Int allows correctly typed array to be returned explicitly';
    lives_ok { ret_pos_2() },
        'type check Positional of Int allows correctly typed array to be returned implicitly';
    dies_ok { ret_pos_3() },
        'type check Positional of Int prevents untyped array to be returned explicitly';
    dies_ok { ret_pos_4() },
        'type check Positional of Int prevents untyped array to be returned implicitly';
    dies_ok { ret_pos_5() },
        'type check Positional of Int prevents incorrectly typed array to be returned explicitly';
    dies_ok { ret_pos_6() },
        'type check Positional of Int prevents incorrectly typed array to be returned implicitly';
    #?rakudo 2 todo "no parametrization"
    lives_ok { ret_pos_7() },
        'type check Positional of Num allows subtyped Int array to be returned explicitly';
    lives_ok { ret_pos_8() },
        'type check Positional of Num allows subtyped Int array to be returned implicitly';
}

# RT #69482
#?rakudo skip 'type on our-variables'
{
    our Int @a1;
    our @a2;
    lives_ok { @a2[0] = 'string' },
        'Can assign to untyped package array in presence of typed array';

}

# RT 71958
{
    class RT71958 {
        has @.rt71958 is rw;
    }
    my Int @typed_array;
    lives_ok { RT71958.new().rt71958[0] = RT71958.new() },
             'can assign to untyped array in presence of typed array';
}

done;

# vim: ft=perl6
