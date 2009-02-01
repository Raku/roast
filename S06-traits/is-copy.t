use v6;
use Test;

# L<S06/"Parameter traits"/"=item is copy">
# should be moved with other subroutine tests?

plan 10;

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
