use v6;

use Test;

plan 24;

# L<S02/Quoting forms>

my $s = join 'a', <x y z>;
is($s, "xayaz", 'list context <list>');

#?rakudo skip 'meta operators'
#?niecza skip '|<<'
{
my $s = join |<< <a x y z>;
is($s, "xayaz", 'listop |<< <list>');
}

#?niecza skip "Preceding context expects a term, but found infix , instead"
ok( [1,2,3].join<abc> ~~ Failure , '.join<abc> parses and fails');

my @y = try { ({:a<1>, :b(2)}<a b c>) };
ok(@y eqv ["1",2,Any], '{...}<a b c> is hash subscript');

throws_like { EVAL '({:a<1>, :b(2)} <1 2 3>)' },
  X::Syntax::Confused,
  '{...} <...> parsefail';

ok( ?((1 | 3) < 3), '(...) < 3 no parsefail');

throws_like { EVAL '(1 | 3)<3' },
  X::Comp::AdHoc,
  '()<3 parsefail';

# WRONG: should be parsed as print() < 3
# EVAL 'print < 3';
# ok($!, 'print < 3 parsefail');


throws_like { EVAL ':foo <1 2 3>' },
  X::Syntax::Confused,
  ':foo <1 2 3> parsefail';

throws_like { EVAL ':foo <3' },
  X::Multi::NoMatch,
  '<3 is comparison, but dies at run time';

my $p = EVAL ':foo<1 2 3>';
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

# L<S02/Forcing item context/"The degenerate case <> is disallowed">

throws_like { EVAL '<>' },
  X::Obsolete,
  'bare <> is disallowed';
throws_like { EVAL '<STDIN>' },
  X::Obsolete,
  '<STDIN> is disallowed';

# L<S02/Quoting forms/"is autopromoted into">
{
    my $c = <a b c>;
    isa_ok($c, Parcel, 'List in scalar context becomes a Capture');
    throws_like {$c.push: 'd'},
      X::Multi::NoMatch,
      '... which is immutable';
}

{
    # L<S02/Forcing item context/For any item in the list that appears to be numeric>
    my @a = <foo 3 4.5 5.60 1.2e1 -2+3i>;
    is ~@a, 'foo 3 4.5 5.60 1.2e1 -2+3i',
       '<...> numeric literals stringify correctly';
    isa_ok @a[0], Str, '<foo ...> is a Str';
    #?rakudo 4 todo 'IntStr/RatStr/NumStr types NYI'
    isa_ok @a[1], Int, '< ... 3 ...> is an Int';
    isa_ok @a[2], Rat, '< ... 4.5 ...> is a Rat';
    isa_ok @a[4], Num, '< ... 1.2e1 ...> is a Num';
    isa_ok @a[5], Complex, '< ... -2+3i ...> is a Num';
}

# probably doesn't really belong here, but I don't know where else to put it
# :(    --moritz

# RT #76452
{
    sub f($x) { $x[0] };
    is f(my @x = (1, 2, 3)), 1, 'function call with assignment to list';
}

# vim: ft=perl6
