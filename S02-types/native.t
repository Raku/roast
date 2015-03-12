use v6;
use Test;

plan 39;

{
    my int $x;
    is $x, 0, 'int default value';
    is $x + 1, 1, 'can do basic math with int';
}

{
    my num $num;
    is $num, NaN, 'num default value';
    $num = 3e0;
    ok $num * 2e0 == 6e0, 'can do basic math with num';
}

{
    my str $str;
    is $str, '', 'str default value';
    my str $s2 = 'foo';
    is $s2 ~ $s2, 'foofoo', 'string concatenation with native strings';
}

{
    multi f(int $x) { 'int' }
    multi f(Int $x) { 'Int' }
    multi f(num $x) { 'num' }
    multi f(Num $x) { 'Num' }
    multi f(str $x) { 'str' }
    multi f(Str $x) { 'Str' }
    my int $int = 3;
    my Int $Int = 4;
    my num $num = 5e0;
    my Num $Num = 6e0;
    my str $str = '7';
    my Str $Str = '8';
    is f($int), 'int', 'can identify native type with multi dispatch (int)';
    is f($Int), 'Int', 'can identify non-native type with multi dispatch (Int)';
    is f($num), 'num', 'can identify native type with multi dispatch (num)';
    is f($Num), 'Num', 'can identify non-native type with multi dispatch (Num)';
    is f($str), 'str', 'can identify native type with multi dispatch (str)';
    is f($Str), 'Str', 'can identify non-native type with multi dispatch (Str)';

    is $int * $Int, 12, 'can do math with mixed native/boxed ints';
    is_approx $num * $Num, 30e0, 'can do math with mixed native/boxed nums';
    is $str ~ $Str, '78', 'can concatenate native and boxed strings';
}

{
    # these tests are a bit pointless, since is() already shows that boxing
    # works. Still doesn't hurt to test it with explicit type constraints
    sub g(Int $x) { $x * 2 }
    my int $i = 21;
    is g($i), 42, 'routine-entry int autoboxing';

    sub h(int $x) { $x div 2 }
    my Int $I = 84;
    is h($I), 42, 'routine-entry Int autounboxing';
}

{
    my int $x = 2;
    is $x.gist, 2, 'can call method on a native int';
    my $gist = ($x = 3).gist;
    is $gist, 3, 'Can call a method on the result of assignment to int-typed var';
}

# methods on native type objects
# RT #102256
{
    isa_ok int, Mu, 'int ~~ Mu';
    is num.gist, '(num)', 'num.gist';
    nok str.defined, 'str.defined';
}

{
    sub slurpy(*@a) {
        @a.join(' ');
    }
    my int $i = 42;
    my str $s = 'roads';
    is slurpy($i, $s), '42 roads', 'can bind native vars to slurpy arrays';
}

# RT #101450
{
    my int $x;
    my num $y;
    is $x, 0, '#101450';
    is $y, NaN, '#101450';
}

# RT #102416
#?niecza skip 'Malformed my'
{
    my int $x;
    ($x) = (5);
    is $x, 5, 'did we assign $x';
    #?rakudo todo 'RT #102416 - though maybe wrong test? Not sure .WHAT is *that* magic'
    is $x.WHAT, int, 'is it really a native';
}

# RT #121349
{
    my @j;
    my int $j = 42;
    lives_ok { @j.push($j) }, 'can push native int to an array (1)';
    is @j[0], 42, 'can push native int to an array (2)';
}

{
    my int   $i   = 1;
    my int64 $i64 = 2;
    my int32 $i32 = 3;
    my int16 $i16 = 4;
    my int8  $i8  = 5;
    my $alias;

    $alias := $i;
    $alias++;
    is $i, 2, 'Bound alias to int native works';

    $alias := $i64;
    $alias++;
    is $i64, 3, 'Bound alias to int64 native works';

    $alias := $i32;
    $alias++;
    is $i32, 4, 'Bound alias to int32 native works';

    $alias := $i16;
    $alias++;
    is $i16, 5, 'Bound alias to int16 native works';

    $alias := $i8;
    $alias++;
    is $i8, 6, 'Bound alias to int8 native works';
}

{
    my num   $n   = 1e0;
    my num64 $n64 = 2e0;
    my num32 $n32 = 3e0;
    my $alias;

    $alias := $n;
    $alias = 2e0;
    is $n, 2e0, 'Bound alias to num native works';

    $alias := $n64;
    $alias = 3e0;
    is $n64, 3e0, 'Bound alias to num64 native works';

    $alias := $n32;
    $alias = 4e0;
    is $n32, 4e0, 'Bound alias to num32 native works';
}

# RT #121071
{
    my int $low  = 10**15;
    my int $high = 2**60 - 1;
    is $low, 1_000_000_000_000_000,
        'int does not get confused with goldilocks number (low)';
    is $high, 1_152_921_504_606_846_975,
        'int does not get confused with goldilocks number (high)';
}

# vim: ft=perl6
