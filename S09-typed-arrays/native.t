use v6;
use Test;

plan 7;

# Basic native array tests.
{
    dies-ok { array.new }, 'Must use native array with type parameter (1)';
    dies-ok { array.new(1) }, 'Must use native array with type parameter (2)';
    dies-ok { array.new(1, 2) }, 'Must use native array with type parameter (3)';
}

# https://github.com/rakudo/rakudo/commit/a85c8d486c
subtest '.STORE(non-Iterable value) does not leave behind previous values' => {
    plan 8;
    for <int  int8  int16  int32  int64> {
        EVAL '
          my \qq[$_] @a = 1, 2, 3; @a = 1;
          is-deeply @a.List, (1,), "\qq[$_]"
        ' ;
    }

    for <num  num32  num64> {
        EVAL '
          my \qq[$_] @a = 1e0, 2e0, 3e0; @a = 1e0;
          is-deeply @a.List, (1e0,), "\qq[$_]"
        ' ;
    }
}

subtest '.STORE(native iterable) does not leave behind previous values' => {
    plan 8;
    for <int  int8  int16  int32  int64> {
        EVAL '
          my \qq[$_] @a = 1, 2, 3; my \qq[$_] @b = 1, 2; @a = @b;
          is-deeply @a.List, (1, 2), "\qq[$_]"
        ' ;
    }

    for <num  num32  num64> {
        EVAL '
          my \qq[$_] @a = 1e0, 2e0, 3e0; my \qq[$_] @b = 1e0, 2e0; @a = @b;
          is-deeply @a.List, (1e0, 2e0), "\qq[$_]"
        ' ;
    }
}

subtest '.STORE(HLL iterable) does not leave behind previous values' => {
    plan 8;
    for <int  int8  int16  int32  int64> {
        EVAL '
          my \qq[$_] @a = 1, 2, 3; my @b = 1, 2; @a = @b;
          is-deeply @a.List, (1, 2), "\qq[$_]"
        ' ;
    }

    for <num  num32  num64> {
        EVAL '
          my \qq[$_] @a = 1e0, 2e0, 3e0; my @b = 1e0, 2e0; @a = @b;
          is-deeply @a.List, (1e0, 2e0), "\qq[$_]"
        ' ;
    }
}

# RT #127756
subtest 'no rogue leftovers when resizing natives' => {
    plan 5;
    {
        my int @a = 1..10; @a = 1..5; @a[50] = 1337;
        is-deeply @a, array[int].new(|(1..5), |(0 xx 45), 1337),
            'native int array, large resize, larger than original size';
    }
    {
        my int @a = 1..100; @a = 1..5; @a[50] = 1337;
        is-deeply @a, array[int].new(|(1..5), |(0 xx 45), 1337),
            'native int array, large resize, smaller than original size';
    }
    {
        my num @a = 1e0..5e0; @a = 1e0; @a[3] = 1337e0;
        is-deeply @a, array[num].new(1e0, 0e0, 0e0, 1337e0),
            'native num array, small resize, smaller than original size';
    }
    {
        my num @a = 1e0..3e0; @a = 1e0; @a[5] = 1337e0;
        is-deeply @a, array[num].new(1e0, 0e0, 0e0, 0e0, 0e0, 1337e0),
            'native num array, small resize, larger than original size';
    }
    { # Note: this setup is quite specific, in order to cover a bug condition
        my int @arr = 1;
        @arr.unshift: 2;
        @arr = ();
        @arr[4] = 3;
        is-deeply @arr, array[int].new(0, 0, 0, 0, 3),
            'contents + unshift + clear clears old elements';
    }
}
