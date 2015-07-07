use v6;
use Test;
use Test::Assuming;

# L<S06/Currying/>
plan 32;

sub capcap (|c ($a, $b?), |d ($c, $d?)) { "a$a b$b c$c d$d" };
sub capcapn (|c ($a, $b?, :$e = 'e'), |d ($c, $d?, :e($f) = 'f'), *%g) { "a$a b$b c$c d$d e$e f$f" };
sub anonslurp ($a, $b, *@, *%) { "a$a b$b" };

is-primed-sig(sub (*@b) { }, :(*@b), );
is-primed-sig(sub (*@b) { }, :(*@b), 1);
is-primed-sig(sub (*@b) { }, :(*@b), 1, *);
is-primed-sig(sub (*@b) { }, :(*@b), *, 2);
is-primed-sig(sub (*@b) { }, :(*@b), 1, *, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2, Nil, 3);
is-primed-sig(sub (*@b) { }, :(*@b), 1, Nil);
is-primed-sig(sub (*@b) { }, :(*@b), Nil, 2);
is-primed-sig(sub (*@b) { }, :(*@b), 1, Nil, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2, *, 3);

is-primed-sig(sub (:$a,*%B,:$b,*%C,:$c) { }, :(:$a,*%B,:$b,*%C,:$c), :a);
is-primed-sig(sub (:$a!,*%B,:$b!,*%C,:$c!) { }, :(:$a,*%B,:$b!,*%C,:$c!), :a);

is-primed-call(&anonslurp, \(1, 2, :a, 'c',:d), ['a1 b2']);
is-primed-call(&anonslurp, \(2, :a, 'c',:d), ['a1 b2'], 1);
is-primed-call(&anonslurp, \(:a, 'c',:d), ['a1 b2'], 1,2);
is-primed-call(&anonslurp, \('c',:d), ['a1 b2'], 1,2,:a);
is-primed-call(&anonslurp, \(:d), ['a1 b2'], 1, 2, :a, 'c');
is-primed-call(&anonslurp, \(), ['a1 b2'], 1, 2, :a, 'c', :d);

is-primed-call(&capcap, \("b"), ['aa bb ca db'], 'a');
is-primed-call(&capcap, \("a"), ['aa bb ca db'], *, 'b');
is-primed-call(&capcapn, \("b"), ['aa bb ca db ee ff'], 'a');
is-primed-call(&capcapn, \("a"), ['aa bb ca db ee ff'], *, 'b');
is-primed-call(&capcapn, \("b"), ['aa bb ca db ee ff'], 'a', *);
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>);
is-primed-call(&capcapn, \("a"), ['aa bb ca db eE fE'], *, 'b', :e<E>);
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>);
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], :e<E>, 'a');
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], 'a', *, :e<E>);
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], :e<E>, 'a', *);
is-primed-call(&capcapn, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>, *);
