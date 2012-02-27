use v6;

use Test;

=begin description

Tests curried subs as defined by 

= TODO

* assuming on a use statement

=end description

# L<S06/Currying>

plan 13;

sub foo ($x?, $y?, $z = 'd') {
    "x=$x y=$y z=$z";
}

is(foo(1, 2), "x=1 y=2 z=d", "uncurried sub has good output");
is(foo(x => 1, y => 2), "x=1 y=2 z=d", "uncurried sub with pair notation");

is((&foo.assuming(y => 2))(x => 1), foo(1, 2), "curried sub with named params");

is((&foo.assuming(y => 2))(1), foo(1, 2), "curried sub, mixed notation");

is((&foo.assuming(x => 1))(2), foo(1, 2), "same thing, but the other way around");

is((&foo.assuming(:x(1)))(2), foo(1, 2), "curried sub, use colon style");

#?niecza skip 'Multi colonpair syntax not yet understood'
is((&foo.assuming(:x(1) :y(2)))(), foo(1, 2), "same thing, but more colon");

#?niecza skip 'Unable to resolve method assuming:x<XXX> in class Sub'
is((&foo.assuming:x(1))(2), foo(1, 2), "curried sub, another colon style");

#?niecza skip 'Unable to resolve method assuming:x<XXX> in class Sub'
is((&foo.assuming:x(1):y(2))(), foo(1, 2), "same thing, but more pre colon");

#?niecza todo
#?pugs skip 'Named argument found where no matched parameter expected'
ok(!(try { &foo.assuming(f => 3) }), "can't curry nonexistent named param");

# L<S06/Currying/The result of a use statement>
#?niecza todo
#?pugs todo
eval_lives_ok q'
    (use t::packages::PackageTest) // {}).assuming(arg1 => "foo");
    die "not working" unless
        dummy_sub_with_params(arg2 => "bar") } eq "[foo] [bar]",
', "(use ...).assuming works";

sub __hyper (@a, @b, $op?) {
  my @ret;
  for 0..(@a.end, @b.end).max -> $i {
    if $i > @a.end {
      push @ret, @b[$i];
    }
    elsif $i > @b.end {
      push @ret, @a[$i];
    }
    else {
      push @ret, $op(@a[$i], @b[$i]);
    }
  }
  return @ret;
}

my @x = (1,2,23);
is( try { &__hyper.assuming(op => &infix:<+>)(@x, @x) },
    (2,4,46), 'currying functions with array arguments' );
is( try { &__hyper.assuming(op => &infix:<+>)(a => @x, b => @x) },
    (2,4,46), 'currying functions with named array arguments' );

# vim: ft=perl6
