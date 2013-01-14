use v6;
use Test;

# L<S06/"Parameter traits"/"=item is copy">
# should be moved with other subroutine tests?

plan 23;

{
  sub foo($a is copy) {
    $a = 42;
    return 19;
  }

  my $bar = 23;
  is $bar,      23, "basic sanity";
  is foo($bar), 19, "calling a sub with an is copy param";
  is $bar,      23, "sub did not change our variable";
}
{
    sub copy_tester ($copy_tester is copy = 5, $bar is copy = 10) {
        $copy_tester += $bar;
        $copy_tester;
    }

    is(copy_tester(), 15, 'calling without arguments');

    is(copy_tester(10), 20, 'calling with one argument');
    is(copy_tester(10, 15), 25, 'calling with two arguments');

    my ($baz, $quux) = (10, 15);

    is(copy_tester($baz), 20, 'calling with one argument');
    is($baz, 10, 'variable was not affected');

    is(copy_tester($baz, $quux), 25, 'calling with two arguments');
    is($baz, 10, 'variable was not affected');
}

# is copy with arrays
{
    sub array_test(@testc is copy) {
        is(@testc[0], 1,   'array copied correctly by is copy');
        @testc[0] = 123;
        is(@testc[0], 123, 'can modify array copied by is copy...');
    };
    my @test = (1, 2, 3);
    array_test(@test);
    is(@test[0], 1,        '...and original is unmodified.');
}

# is copy with hashes
{
    sub hash_test(%h is copy) {
        is(%h<x>, 1,   'hash copied correctly by is copy');
        %h<x> = 123;
        is(%h<x>, 123, 'can modify hash copied by is copy...');
    };
    my %test = (x => 1);
    hash_test(%test);
    is(%test<x>, 1,    '...and original is unmodified.');
}

# RT #76242
{
    sub t(@a is copy) {
        my $x = 0;
        $x++ for @a;
        $x;
    }

    my $a = [1, 2, 3];
    #?pugs todo
    is t($a), 3, 'passing [1,2,3] to @a is copy does results in three array items';
}

# RT #76804
{
    sub f($arg is copy) {
        my $other;
        ($arg, $other) = 5, 6;
        $arg;
    };
    is f(0), 5, 'list assignment (0)';
    is f(1), 5, 'list assignment (1)';
}

# RT #74454
{
    sub g(%hash? is copy) { };  #OK not used
    lives_ok { g() }, 'can call a sub with an optional "is copy" hash param';
}

# RT #75302
{
    sub h($x is copy) {
        $x = 'abc';
        $x
    }
    is h(*), 'abc', 'can re-assign to "is copy" parameter that held a Whatever';
}

# RT #82810
{
    sub j(@a is copy) { @a ||= -1, -1, +1, +1; @a.join(',') }
    #?pugs todo
    is j([1, 2, 3, 4]), '1,2,3,4', 'can use ||= on "is copy" array';
}

# RT #74430
{
    sub foo(@items is copy) { @items[0..^1] };
    my @items = 'a'...'g';
    is foo(@items), 'a', 'can slice "is copy" arrays';
}


# vim: ft=perl6
