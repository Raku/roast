use v6;
use Test;

plan 84;

# L<S09/Typed arrays/>

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
    # RT #77748
    ok @x.WHAT.gist ~~ /Array/, '.WHAT.gist of the type object makes sense';
    lives-ok { @x = 1, 2, 3 }, 'can assign values of the right type';
    lives-ok { @x = 1..3    }, 'can assign range of the right type';
    lives-ok { @x.push: 3, 4}, 'can push values of the right type';
    lives-ok { @x.unshift: 3}, 'can unshift values of the right type';
    lives-ok { @x[0, 2] = 2, 3}, 'can assign values to a slice';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array';
    is @x.unshift(2), [2, 2, 3], 'can unshift from typed array';
} #9

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
    lives-ok { @x = 1, 2, 3 }, 'can assign values of the right type (Int @x)';
    lives-ok { @x = 1..3    }, 'can assign range of the right type (Int @x)';
    lives-ok { @x.push: 3, 4}, 'can push values of the right type (Int @x)';
    lives-ok { @x.unshift: 3}, 'can unshift values of the right type (Int @x)';
    lives-ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (Int @x)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (Int @x)';
    is @x.unshift(1), [1, 2, 3], 'can unshift from typed array (Int @x)';
} #8

# initialization
{
    lives-ok { my Int @x = 1, 2, 3 }, 'initialization of typed array';
    lives-ok { my Int @x = 1 .. 3 }, 'initialization of typed array from range';
} #2

{
    my @x of Int;
    ok @x.VAR.of === Int, '@x.VAR.of of typed array (my @x of Int)';
    lives-ok { @x = 1, 2, 3 }, 'can assign values of the right type (@x of Int)';
    lives-ok { @x = 1..3    }, 'can assign range of the right type (@x of Int)';
    lives-ok { @x.push: 3, 4}, 'can push values of the right type (@x of Int)';
    lives-ok { @x.unshift: 3}, 'can unshift values of the right type (@x of Int)';
    lives-ok { @x[0, 2] = 2, 3}, 'can assign values to a slice (@x of Int)';
    @x = 2, 3, 4;
    is @x.pop, 4, 'can pop from typed array (@x of Int)';

    ok @x.unshift, 'can unshift from typed array (@x of Int)';
} #8

{
    my Array @x;
    ok @x.VAR.of === Array, '@x.VAR.of of typed array (my Array @x)';
    dies-ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies-ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies-ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies-ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies-ok { @x[0, 2] = 2, 3},
            'can not assign values of wrong type to a slice';
    lives-ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my @x of Array;
    ok @x.VAR.of === Array, '@x.VAR.of of typed array (my @x of Array)';
    dies-ok { @x = 1, 2, 3 }, 'can not assign values of the wrong type';
    dies-ok { @x = 1..3    }, 'can not assign range of the wrong type';
    dies-ok { @x.push: 3, 4}, 'can not push values of the wrong type';
    dies-ok { @x.unshift: 3}, 'can not unshift values of the wrong type';
    dies-ok { @x[0, 2] = 2, 3},
            'can not assign values of wrong type to a slice';
    lives-ok { @x = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my Array of Int @x;
    ok @x.VAR.of === Array[Int], 'my Array of Int @x declares a nested array';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @x = [2, 3], [5, 6] }, 'assignment works';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @x.push: [8, 9] }, 'pushing works';
    dies-ok  { @x.push: 8 }, 'type constraint is enforced';
    lives-ok { @x[0].push: 3 }, 'pushing to the inner array is OK';
    dies-ok  { @x[0].push: 'foo' }, 'inner array enforces the type constraint';
} #6

# test that lists/arrays returned from array methods are typed as well
{
    my Int @a = 1, 2, 3;
    my Int @b;
    lives-ok { @b = @a }, 'can assign typed array to typed array';
    #?rakudo skip 'need parameterized Lists'
    ok @a.values.VAR.of.WHICH eqv Int.WHICH, '@a.values is typed (1)';
    lives-ok { @b = @a.values }, '@a.values is typed (2)';
} #3

#?rakudo skip 'initialization RT #124676'
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
    sub ret_pos_7 returns Positional of Numeric { my Int @a = 1,2,3; return @a; }
    sub ret_pos_8 returns Positional of Numeric { my Int @a = 1,2,3; @a }
    lives-ok { ret_pos_1() },
        'type check Positional of Int allows correctly typed array to be returned explicitly';
    lives-ok { ret_pos_2() },
        'type check Positional of Int allows correctly typed array to be returned implicitly';
    dies-ok { ret_pos_3() },
        'type check Positional of Int prevents untyped array to be returned explicitly';
    dies-ok { ret_pos_4() },
        'type check Positional of Int prevents untyped array to be returned implicitly';
    dies-ok { ret_pos_5() },
        'type check Positional of Int prevents incorrectly typed array to be returned explicitly';
    dies-ok { ret_pos_6() },
        'type check Positional of Int prevents incorrectly typed array to be returned implicitly';
    lives-ok { ret_pos_7() },
        'type check Positional of Num allows subtyped Int array to be returned explicitly';
    lives-ok { ret_pos_8() },
        'type check Positional of Num allows subtyped Int array to be returned implicitly';
} #8

# RT #69482
#?rakudo skip 'type on our-variables RT #124677'
{
    our Int @a1;
    our @a2;
    lives-ok { @a2[0] = 'string' },
        'Can assign to untyped package array in presence of typed array';
} #1

# RT #71958
{
    class RT71958 {
        has @.rt71958 is rw;
    }
    my Int @typed_array;
    lives-ok { RT71958.new().rt71958[0] = RT71958.new() },
             'can assign to untyped array in presence of typed array';
} #1

# RT #114968
{
    throws-like 'my Int @a = "ab", "cd"', X::TypeCheck::Assignment,
        'typed arrays do check type during list assignment';
    throws-like 'my Int @a = "ab", "cd"; 42.Str;', X::TypeCheck::Assignment,
        'typed arrays do check type during list assignment in sink';
}

# RT #119061
{
    my Int @a;
    throws-like { @a[@a.elems] = "a"; }, X::TypeCheck::Assignment,
        'assignment checks for types';
}

# RT #125428
{
    subset Y of Int where 1..10;
    my Y @x;
    @x.push: 10;
    throws-like '@x[0]++', X::TypeCheck,
        'pushed value to typed array (using "subset") is type checked';
}

{
    my Int @a; @a[2] = 42;
    my @b := @a.perl.EVAL;
    is @b.of, Int, 'does the roundtrip preserve typedness';
    is @a, @b, 'do typed arrays with empty elements roundtrip';
}

# RT #66892
{
    sub foo(--> Array of Str) {
        my Str @a = <foo bar baz>;
        @a
    };
    lives-ok { foo() }, 'Array of Str works as return constraint';
    ok foo().of === Str, 'Get back the typed array correctly (1)';
    is foo(), Array[Str].new('foo', 'bar', 'baz'),
        'Get back the typed array correctly (2)';
}

# RT #120506
{
    my @RT120506-bind := Array[Array[Bool]].new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @RT120506-bind[0, 1]».List, ((True, False, True), (True,)),
        "Can feed Arrays of Type to .new of Array[Array[Type]] (binding)";
    is @RT120506-bind[0].WHAT, Array[Bool], "Type is maintained (binding)";

    my Array of Bool @RT120506-assign .= new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @RT120506-assign[0, 1]».List, ((True, False, True), (True,)),
        "Can feed Arrays of Type to .new of Array[Array[Type]] (assignment)";
    is @RT120506-assign[0].WHAT, Array[Bool], "Type is maintained (assignment)";
}

# RT #121804
{
    sub RT121804 returns Array of Hash {
        my %a1 = :x<y>, :y<z>, :w<c>;
        my %a2 =:x<y>, :y<t>, :w<c>;
        my %a3 = :x<y>, :y<z>, :w<h>;
        my Hash @array1 = $%a1, $%a2, $%a3;
    }
    is-deeply RT121804, Array[Hash].new({:x<y>, :y<z>, :w<c>}, {:x<y>, :y<t>, :w<c>}, {:x<y>, :y<z>, :w<h>}),
        "Can assign to and return Array[Hash] from type-constrained sub";
}

# RT #81682
{
    my Int @rt81682 = ^3;
    my Int $x = 5;
    @rt81682[0] := $x;
    is ~@rt81682, '5 1 2',
        'can bind element of typed array to scalar container of same type';
    my $y = 6;
    @rt81682[2] := $y;
    is ~@rt81682, '5 1 6',
        'can bind element of typed array to scalar container of same type (but not explicitly typed)';
}

# RT #123769
{
    my Int @a;
    dies-ok { @a[0] := "foo" }, 'Binding literal to typed array checks types';
    dies-ok { my Str $x = "foo"; @a[0] := $x; }, 'Binding variablle to typed array checks type';
}

# RT #120071
{
    my Int @a = 0 .. 2;
    @a[1]:delete;
    my @types = @a.map:{.^name};
    is @types, <Int Int Int>,
        'deleted element of typed arrays does not lose type info inside .map';
}

# RT #123037
{
    my Int @a;
    @a[4]++;
    is @a.gist, '[(Int) (Int) (Int) (Int) 1]',
        '.gist on typed array shows real type objects';
}

# RT #126134
{
    sub rt126134 (Int @a) { pass '@a of Foo accepted by sub (Foo @a)' };
    my @a of Int;
    rt126134 @a;
}

# RT #126136
{
    {
        my @a of Int; my @b;
        cmp-ok @a.WHAT, &[!=:=], @b.WHAT,
            'using `of` does not affect arrays defined later';
    }
    {
        my @a of Int; my @b of Str;
        cmp-ok @a.WHAT, &[!=:=], @b.WHAT,
            'using `of` does not affect arrays with `of` defined later';
    }
}

# vim: ft=perl6
