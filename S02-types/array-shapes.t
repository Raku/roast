use v6;
use Test;
plan 42;

# L<S09/Fixed-size arrays>

{
    my @arr[*];
    @arr[42] = "foo";
    is(+@arr, 43, 'my @arr[*] autoextends like my @arr');
}

{
    my @arr[7] = <a b c d e f g>;
    is(@arr, [<a b c d e f g>], 'my @arr[num] can hold num things');
    throws-like q[push @arr, 'h'],
      X::IllegalOnFixedDimensionArray,
      operation => 'push',
      'adding past num items in my @arr[num] dies';
    throws-like '@arr[7]',
      Exception,
      'accessing past num items in my @arr[num] dies';
}

# https://github.com/Raku/old-issue-tracker/issues/3842
{
    lives-ok { my @arr\    [7] },
      'array with fixed size with unspace';
   #?rakudo 2 todo 'code does not die, array shapes'
    throws-like 'my @arr.[8]',
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form dies';
    throws-like 'my @arr\    .[8]',
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form and unspace dies';
}

# L<S09/Typed arrays>
{
    my @arr of Int = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my @arr of Type works');
    throws-like q[push @arr, 's'],
      X::TypeCheck,
      'type constraints on my @arr of Type works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my @arr of Type works (2)';
}
{
    my Int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my Type @arr works');
    throws-like q[push @arr, 's'],
      X::TypeCheck,
      'type constraints on my Type @arr works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my Type @arr works (2)';
}

{
    my @arr[5] of Int = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my @arr[Int] of Type works');

    throws-like 'push @arr, 123',
      Exception,
      'boundary constraints on my @arr[Int] of Type works';
}

# https://github.com/Raku/old-issue-tracker/issues/4223
{
    my int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my type @arr works');
    is push(@arr, 6), [1,2,3,4,5,6], 'push on native @arr works';
    throws-like 'push @arr, "s"',
      X::TypeCheck,
      'type constraints on my type @arr works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my type @arr works (2)';
}

{
    my int @arr[5] = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my Type @arr[num] works');

    throws-like 'push @arr, 123',
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
    throws-like 'pop @arr',
      X::IllegalOnFixedDimensionArray,
      operation => 'pop';
    throws-like q[push @arr, 's'],
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
    throws-like 'push @arr, 4.2',
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
}

# https://github.com/Raku/old-issue-tracker/issues/4816
{
    throws-like 'my @a[0]',
        X::IllegalDimensionInShape;
    throws-like 'my @a[-9999999999999999]',
        X::IllegalDimensionInShape;
    throws-like 'my @a[-9223372036854775808,-2]',
        X::IllegalDimensionInShape;
}

# https://github.com/Raku/old-issue-tracker/issues/5986
subtest '.List on uninited shaped array' => {
    plan 2;

    my @a[2;2];
    my @result;
    lives-ok { @result = @a.List }, 'does not die';
    is-deeply @result, [Any xx 4],  'gives correct results';
}

# https://github.com/rakudo/rakudo/issues/2257
subtest '.Array on uninited shaped array' => {
    plan 3;

    my @a[2;2];
    my @result;
    lives-ok { @result := @a.Array }, 'does not die';
    is-deeply @result, [Any xx 4],  'gives correct results';
    lives-ok { @result[0] = 42 }, 'and is mutable';
}

# https://github.com/Raku/old-issue-tracker/issues/5983
{
    my @c[2;2] .= new(:shape(2, 2), <a b>, <c d>);
    is @c.raku, Array.new(:shape(2, 2), <a b>, <c d>).raku,
      '@c[some shape] accepts a .new: :shape(same shape)...';
}

# https://github.com/Raku/old-issue-tracker/issues/5938
{
    my @a[1;1]; for @a.pairs -> $p { $p.value = 42 };
    is-deeply @a[0;0], 42,
        '@shaped-array.pairs provides with writable container in .value';

    my @b[1]; for @b.values <-> $a { $a = 42 };
    is-deeply @b[0], 42,
        '@shaped-array.values provides with writable containers';
}

# https://github.com/Raku/old-issue-tracker/issues/5946
{
    my @array[8];
    is-deeply ($_ for @array), (Any for 1..8), "For statement across simple uninitialized shaped array";
    is-deeply (for @array { $_ }), (Any for 1..8), "For loop across simple uninitialized shaped array";
    is-deeply (@array.map: {$_}), (Any for 1..8), ".map of simple uninitialized shaped array";
}

# https://irclog.perlgeek.de/perl6/2017-03-20#i_14297219
{
    # Z= for shape filling
    my int @a[2;3] Z= 0..5;
    is +@a, 2, 'Z= shape filling';
    is @a[0;1], 1, 'Z= shape filling';
    is @a[1;2], 5, 'Z= shape filling';
}

# https://github.com/rakudo/rakudo/issues/1297
#?rakudo skip 'coercion of shaped array indicesdd'
{
    my @matrix[2;2]; @matrix['0'; '0'] = 42;
    is-deeply @matrix[0;0], 42, 'Str can be used to index shaped arrays';
}

{
    eval-lives-ok 'my @*a[3]', "Accept dynamic shaped arrays"
}

# https://github.com/rakudo/rakudo/issues/4205
{
    my @a[1] = 42;
    lives-ok { (@a>>++).raku }, 'call .raku on result of hyper on shaped';
    is-deeply @a[0], 43, 'did the hyper actually run';
}

# vim: expandtab shiftwidth=4
