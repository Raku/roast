use v6;
use Test;

use lib 't/spec/packages';
use Test::Assuming;

# L<S06/Currying/>
plan 27;

sub tester(:$a, :$b, :$c) {
    "a$a b$b c$c";
}

# RT #125207
{
    my $w = &tester.assuming(b => 'x');
    is $w(a => 'w', c => 'y'), 'aw bx cy', 'currying one named param';
}

# RT #125207
{
    my $w = &tester.assuming(b => 'b');
    my $v =  $w.assuming(c => 'c');
    is $v(a => 'x'), 'ax bb cc', 'can curry on an already curried sub';
    is $w(a => 'x', c => 'd'), 'ax bb cd', '... and the old one still works';
}

#?rakudo.moar todo 'last part of RT #123498 is still unresolved.'
priming-fails-bind-ok(sub { }, "", "Unexpected named", :named);

# Since you can override named params .assuming does not alter sig
is-primed-sig(sub (:$a) { }, :(:$a), :a);
is-primed-sig(sub (:$a, :$b) { }, :(:$a, :$b), :b);
is-primed-sig(sub (:$a, :$b) { }, :(:$a, :$b), :a);
is-primed-sig(sub (:$a?) { }, :(:$a), :a);
is-primed-sig(sub (:$a?, :$b?) { }, :(:$a, :$b), :b);
is-primed-sig(sub (:$a?, :$b?) { }, :(:$a, :$b), :a);
# ...but it should optionalize them
is-primed-sig(sub (:$a!) { }, :(:$a?), :a);
is-primed-sig(sub (:$a!, :$b!) { }, :(:$a!, :$b), :b);
is-primed-sig(sub (:$a!, :$b!) { }, :(:$a, :$b!), :a);
is-primed-sig(sub (:$a = 2) { }, :(:$a), :a);
is-primed-sig(sub (:$a = 2, :$b = 4) { }, :(:$a, :$b), :b);
is-primed-sig(sub (:$a = 2, :$b = 4) { }, :(:$a, :$b), :a);
is-primed-sig(sub ($a, $b, :$c) { }, :($b, :$c), 1);
is-primed-sig(sub (:b($a)!) { }, :(:b($a)), :b);
is-primed-sig(sub (:b(:c($a))!) { }, :(:b(:c($a))), :c);
is-primed-sig(sub (:b(:c($a))!) { }, :(:b(:c($a))), :b);

#?rakudo.moar todo 'last part of RT #123498 is still unresolved.'
priming-fails-bind-ok(sub (:b(:c($a))!) { }, "", "Unexpected named", :d);


is-primed-sig(sub (:$a! where { True }) { }, :(:$a?), :a);
is-primed-sig(sub (:$a! is raw where { True }) { }, :(:$a? is raw), :a);
is-primed-sig(sub (:$a! is copy where { True }) { }, :(:$a? is copy), :a);

# This will not even compile.  Maybe this should be a runtime error?
##?rakudo todo 'RT #123835'
#is-primed-sig(sub (:$a! is rw where { True }) { }, :(:$a is rw), :a);
is-primed-sig(sub (:$a is copy where { True } = 4) { }, :(:$a is copy), :a);
is-primed-sig(sub (Int :$a! where { True }) { }, :(Int :$a?), :a(1));

priming-fails-bind-ok(sub (Int :$a!) { }, '$a', Int, :a);



# vim: ft=perl6
