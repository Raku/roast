use v6;
use Test;

plan 6;

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
