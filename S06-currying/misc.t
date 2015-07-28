use v6;
use Test;
use lib 't/spec/packages';
use Test::Assuming;

plan 11;

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

