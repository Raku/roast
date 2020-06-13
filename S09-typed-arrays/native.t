use v6;
use Test;

plan 10;

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

# https://github.com/Raku/old-issue-tracker/issues/5189
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

subtest 'STOREing a Seq doesnt keep previous values around' => {
    plan 3;
    {
        my int @a;
        @a = Seq.new([1, 1, 1, 1, 1].iterator);
        @a = Seq.new([2, 2, 2, 2].iterator);
        is-deeply @a, array[int].new(2, 2, 2, 2),
            'STOREing a Seq into a native int array';
    }
    {
        my num @a;
        @a = Seq.new([1e0, 1e0, 1e0, 1e0, 1e0].iterator);
        @a = Seq.new([2e0, 2e0, 2e0, 2e0].iterator);
        is-deeply @a, array[num].new(2e0, 2e0, 2e0, 2e0),
            'STOREing a Seq into a native num array';
    }
    {
        my str @a;
        @a = Seq.new(["a", "a", "a", "a", "a"].iterator);
        @a = Seq.new(["b", "b", "b", "b"].iterator);
        is-deeply @a, array[str].new("b", "b", "b", "b"),
            'STOREing a Seq into a native str array';
    }
}

subtest 'assigning other arrays into native arrays dies if the type of an element is wrong' => {
    plan 14;
    {
        throws-like 'my int @a = 1, "a"',   Exception, 'assigning a str literal to an int array throws';
        throws-like 'my int @a = 1, 1e0',   Exception, 'assigning a num literal to an int array throws';
        #?rakudo.jvm todo 'code does not die'
        throws-like 'my int @a = 1, 2**65', Exception, 'assigning a too big literal to an int array throws';

        throws-like 'my str $a = "a"; my int @a = 1, $a', Exception, 'assigning a str variable to an int array throws';
        throws-like 'my num $a = 1e0; my int @a = 1, $a', Exception, 'assigning a num variable to an int array throws';
        #?rakudo.jvm todo 'code does not die'
        throws-like 'my $a = 2**65;   my int @a = 1, $a', Exception, 'assigning a too big variable to an int array throws';
    }
    {
        throws-like 'my str @a = "a", 1',   Exception, 'assigning an int literal to a str array throws';
        throws-like 'my str @a = "a", 1e0', Exception, 'assigning a num literal to a str array throws';

        throws-like 'my int $a = 1;   my str @a = "a", $a', Exception, 'assigning an int variable to a str array throws';
        throws-like 'my num $a = 1e0; my str @a = "a", $a', Exception, 'assigning a num variable to a str array throws';
    }
    {
        throws-like 'my num @a = 1e0, 1',   Exception, 'assigning an int literal to a num array throws';
        throws-like 'my num @a = 1e0, "a"', Exception, 'assigning a str literal to a num array throws';

        throws-like 'my int $a = 1;   my num @a = 1e0, $a', Exception, 'assigning an int variable to a num array throws';
        throws-like 'my str $a = "a"; my num @a = 1e0, $a', Exception, 'assigning a str variable to a num array throws';
    }
}

subtest 'STOREing/splicing lazy Seq values throws' => {
    my @test-data = (
        ('int', 'lazy 1..100',         'int lazy prefix'),
        ('int', '2, 4, 8 ... *',       'int sequence operator'),
        ('num', 'lazy 1e0..100e0',     'num lazy prefix'),
        ('num', '2e0, 4e0, 8e0 ... *', 'num sequence operator'),
        ('str', 'lazy "a".."z"',       'str lazy prefix'),
        ('str', '"a" ... *',           'str sequence operator'),
    );

    plan 2 * @test-data.elems;

    for @test-data -> ($type, $expr, $msg) {
        my $store-stmt  = "my $type \@a = $expr; \@a[1]";
        my $splice-stmt = "my $type \@a; \@a.splice(0, 0, ($expr))";

        throws-like $store-stmt,  X::Cannot::Lazy, "STORE $msg";
        throws-like $splice-stmt, X::Cannot::Lazy, "splice $msg";
    }
}

# vim: expandtab shiftwidth=4
