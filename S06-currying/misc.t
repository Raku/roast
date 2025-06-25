use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Assuming;

plan 17;

# How clever we get with type-captures and subsignatures is TBD.  So
# these tests are more tenuous, they just test the intent
# of the currently prototyped functionality.

is-primed-sig(sub (::T $a, $b, :$c) { }, :($b, :$c), 1);
#?rakudo 4 todo "awaiting resurrecting of RakuAST assuming"
is-primed-sig(sub (::T $a, T $b, T :$c) { }, :(Int $b, Int :$c), 1);
is-primed-sig(sub (::T $a, T @b, T :@c) { }, :(Int @b, Int :@c), 1);
is-primed-sig(sub (::T $a, T $b, T :$c) { }, :(Int :$c), 1, 1);
is-primed-sig(sub (::T $a, T @b, T :@c) { }, :(Int :@c), 1, Array[Int].new(1));
#?rakudo skip "not yet properly supported"
is-primed-sig(sub (::T $a, Array[T] $b, Array[Int] :$c) { }, :(Array[Int] $b, Array[Int] :$c), 1);
#?rakudo skip "not yet properly supported"
is-primed-sig(sub (::T $a, Array[T] $b, Array[Int] :$c) { }, :(Array[Int] :$c), 1, $(Array[Int].new));
#?rakudo skip "not yet properly supported"
is-primed-sig(sub (::T $a, Array[Array[T]] $b, Array[Array[Int]] :$c) { }, :(Array[Array[Int]] $b, Array[Array[Int]] :$c), 1);
#?rakudo skip "not yet properly supported"
is-primed-sig(sub (::T $a, Array[Positional[T]] $b, Array[Positional[Int]] :$c) { }, :(Array[Positional[Int]] $b, Array[Positional[Int]] :$c), 1);

#?rakudo skip 'We could do better here'
is-primed-call(sub (::T $a, T $b is copy, T :$c) { "a" ~ $a.raku ~ "b" ~ $b.raku ~ "c" ~ $c.raku }, \("A", :c<C>), ["aAb(Any)cC"], *, Nil);

# How or whether this should fail is less clear to me.  Currently LTA error.
#?rakudo skip 'We could do better here'
is-primed-sig(sub () { }, :(), *);

# https://github.com/Raku/old-issue-tracker/issues/3705
sub same'proto(::T, T $a, T $b) { $a.WHAT === $b.WHAT };
my &infix:<same-in-Int> = &same'proto.assuming(Int);
throws-like { 42 same-in-Int "42" }, X::TypeCheck::Binding,
    "Backtrace mentions priming and does not mention currying";

# Try with an anonymous capture in the mix
sub abc123 (| ($a,$b,$c,$o,$t,$th)) { $a,$b,$c,$o,$t,$th; }
#?rakudo.jvm todo 'Got [Mu, Mu, Mu, Mu, Mu, Mu]'
is-primed-call(&abc123, \(1,2,3), ['a','b','c',1,2,3], 'a','b','c');

# https://github.com/rakudo/rakudo/pull/5804
{
    sub foo(::T $a, T @b) { "$a:@b[]" }
    is foo(42, my Int @ = 666,137), "42:666 137",
      'can we use a generic on an array parameter';

    sub foo2(::T $a, Positional[T] $b) { "$a:$b" }
    is foo2(42, my Int @ = 666,137), "42:666 137",
      'can we use a generic on a positional parameter';

    sub bar(::T $a, T %h) { "$a:%h<a b>" }
    is bar(42, my Int % = :666a, :137b), "42:666 137",
      'can we use a generic on a hash parameter';

    sub bar2(::T $a, Associative[T] $h) { "$a:$h<a b>" }
    is bar2(42, my Int % = :666a, :137b), "42:666 137",
      'can we use a generic on an associative parameter';
}

# vim: expandtab shiftwidth=4
