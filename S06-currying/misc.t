use v6;
use Test;
use lib 't/spec/packages';
use Test::Assuming;

plan 12;

# How clever we get with type-captures and subsignatures is TBD.  So
# these tests are more tenuous, they just test the intent
# of the currently prototyped functionality. 

is-primed-sig(sub (::T $a, $b, :$c) { }, :($b, :$c), 1);
is-primed-sig(sub (::T $a, T $b, T :$c) { }, :($b, :$c), 1);
is-primed-sig(sub (::T $a, T @b, T :@c) { }, :(@b, :@c), 1);
is-primed-sig(sub (::T $a, T $b, T :$c) { }, :(:$c), 1, 1);
is-primed-sig(sub (::T $a, T @b, T :@c) { }, :(:@c), 1, [1]);
is-primed-sig(sub (::T $a, Array[T] $b, Array[Int] :$c) { }, :($b, Array[Int] :$c), 1);
is-primed-sig(sub (::T $a, Array[T] $b, Array[Int] :$c) { }, :(Array[Int] :$c), 1, $(Array[Int].new));
is-primed-sig(sub (::T $a, Array[Array[T]] $b, Array[Array[Int]] :$c) { }, :($b, Array[Array[Int]] :$c), 1);
is-primed-sig(sub (::T $a, Array[Positional[T]] $b, Array[Positional[Int]] :$c) { }, :($b, Array[Positional[Int]] :$c), 1);

#?rakudo skip 'We could do a better here'
is-primed-call(sub (::T $a, T $b is copy, T :$c) { "a" ~ $a.perl ~ "b" ~ $b.perl ~ "c" ~ $c.perl }, \("A", :c<C>), ["aAb(Any)cC"], *, Nil);

# How or whether this should fail is less clear to me.  Currently LTA error.
is-primed-sig(sub () { }, :(), *);

# RT #123938
sub same'proto(::T, T $a, T $b) { $a.WHAT === $b.WHAT };
my &infix:<same-in-Int> = &same'proto.assuming(Int);
throws-like { 42 same-in-Int "42" }, X::TypeCheck::Binding,
    backtrace => rx:i/.*in\s+\S+\s+\S*curr{fail}||prim/,
    "Backtrace mentions priming and does not mention currying";

