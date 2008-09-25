use v6;

use Test;

=begin kwid

= DESCRIPTION

This file tests a parse failure between expressions
and list quotes <>:

The C<< <3 >> is seen as the start of a list that
extends into the commented line. The expression
should be parsed as restricted to the one C<ok()>
line of course.

The following expressions also contend for the
same problem:

Two-way comparison:

  1 < EXPR > 2

Hash access:

  HASHEXPR<KEY>

= TODO

Add relevant Sxx and/or Axx references, that
describe the conflicting cases.

=end kwid

plan 14;

# L<S02/"Literals">
# L<S03/"Chained comparisons">

my $s = join 'a', <x y z>;
is($s, "xayaz", 'list context <list>');

#?rakudo skip 'meta operators'
{
my $s = join |<< <a x y z>;
is($s, "xayaz", 'listop |<< <list>', :todo<bug>);
}

dies_ok { [1,2,3].join<a b c> }, '.join<abc> parses but semantic error';

# XXX shouldn't compare List to Array, need better test
my @y = try { ({:a<1>, :b(2)}<a b c>) };
#?rakudo todo 'hash slices'
is(@y, [1,2,undef], '{...}<a b c> is hash subscript');

eval_dies_ok '({:a<1>, :b(2)} <a b c>)', '{...} <...> parsefail';

ok( ?((1 | 3) < 3), '(...) < 3 no parsefail');

#?pugs todo 'parsing bug'
#?rakudo todo 'parsing'
eval_dies_ok '(1 | 3)<3', '()<3 parsefail';

# WRONG: should be parsed as print() < 3 
# eval 'print < 3';
# ok($!, 'print < 3 parsefail');

# XXX This test is most likely out of date...
#?pugs todo 'parsing (wrong  test?)
#?rakudo skip 'unspecced'
eval_dies_ok 'reverse<1 2 3>', 'reverse<1 2 3> parsefail';

#?rakudo skip 'Null PMC access in can()'
eval_dies_ok ':foo <1 2 3>', ':foo <1 2 3> parsefail';

#?rakudo skip 'Null PMC access in can()'
{
my $r = eval ':foo <3';
ok($r, ':foo <3 is comparison');
}

my $p = eval ':foo<1 2 3>';
is($p, ~('foo' => (1,2,3)), ':foo<1 2 3> is pair of list');

# Lists may contain newline characters

{
    my %e = ("foo", "bar", "blah", "blah");

my %foo = (
        "foo", "bar",
        "blah", "blah",
);
    is(+%foo,      +%e,      "Hashes with embedded newlines in the list (1)");
    is(%foo<foo>,  %e<foo>,  "Hashes with embedded newlines in the list (2)");
    is(%foo<blah>, %e<blah>, "Hashes with embedded newlines in the list (3)");
}

