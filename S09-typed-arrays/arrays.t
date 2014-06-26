use v6;
use Test;

plan 61;

# L<S09/Typed arrays/>

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
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
} #9

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type (Int @x)';
    lives_ok { @x = 1..3    }, 'can assign range of the right type (Int @x)';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type (Int @x)';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type (Int @x)';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (Int @x)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (Int @x)';
    is @x.unshift(1), [1, 2, 3], 'can unshift from typed array (Int @x)';
} #8

# initialization 
{
    lives_ok { my Int @x = 1, 2, 3 }, 'initialization of typed array';
    lives_ok { my Int @x = 1 .. 3 }, 'initialization of typed array from range';
} #2

{
    my @x of Int;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my @x of Int)';
    lives_ok { @x = 1, 2, 3 }, 'can assign values of the right type (@x of Int)';
    lives_ok { @x = 1..3    }, 'can assign range of the right type (@x of Int)';
    lives_ok { @x.push: 3, 4}, 'can push values of the right type (@x of Int)';
    lives_ok { @x.unshift: 3}, 'can unshift values of the right type (@x of Int)';
    lives_ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (@x of Int)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (@x of Int)';
    
    ok @x.unshift, 'can unshift from typed array (@x of Int)';
} #8

{
    my Array @x;
    ok @x.VAR.of === Array, '@x.VAR.of of typed array (my Array @x)';
    dies_ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies_ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies_ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies_ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies_ok { @x[0, 2] = 2, 3}, 
            'can not assign values of wrong type to a slice';
    lives_ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my @x of Array;
    ok @x.VAR.of === Array, '@x.VAR.of of typed array (my @x of Array)';
    dies_ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies_ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies_ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies_ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies_ok { @x[0, 2] = 2, 3}, 
            'can not assign values of wrong type to a slice';
    lives_ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my Array of Int @x;
    ok @x.VAR.of === Array[Int], 'my Array of Int @x declares a nested array';
    #?rakudo skip "nested typechecks are borked"
    lives_ok { @x = [2, 3], [5, 6] }, 'assignment works';
    #?rakudo todo "nested typechecks are borked"
    lives_ok { @x.push: [8, 9] }, 'pushing works';
    dies_ok  { @x.push: 8 }, 'type constraint is enforced';
    #?rakudo todo "nested typechecks are borked"
    lives_ok { @x[0].push: 3 }, 'pushing to the inner array is OK';
    dies_ok  { @x[0].push: 'foo' }, 'inner array enforces the type constraint';
} #6

# test that lists/arrays returned from array methods are typed as well
{
    my Int @a = 1, 2, 3;
    my Int @b;
    lives_ok { @b = @a }, 'can assign typed array to typed array';
    #?rakudo todo 'need parameterized Lists'
    ok @a.values.VAR.of.WHICH eqv Int.WHICH, '@a.values is typed (1)';
    lives_ok { @b = @a.values }, '@a.values is typed (2)';
} #3

#?rakudo todo 'initialization'
{
    my Str @c = <foo bar baz>;
    ok @c.keys.VAR.of.WHICH eqv Str.WHICH, '@array.keys is typed with Str';
} #1

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
} #8

# RT #69482
#?rakudo skip 'type on our-variables'
{
    our Int @a1;
    our @a2;
    lives_ok { @a2[0] = 'string' },
        'Can assign to untyped package array in presence of typed array';
} #1

# RT 71958
{
    class RT71958 {
        has @.rt71958 is rw;
    }
    my Int @typed_array;
    lives_ok { RT71958.new().rt71958[0] = RT71958.new() },
             'can assign to untyped array in presence of typed array';
} #1

done;

# vim: ft=perl6
