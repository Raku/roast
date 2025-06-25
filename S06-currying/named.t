use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Assuming;

# L<S06/Currying/>
plan 28;

sub tester(:$a, :$b, :$c) {
    "a$a b$b c$c";
}

# https://github.com/Raku/old-issue-tracker/issues/4249
{
    my $w = &tester.assuming(b => 'x');
    is $w(a => 'w', c => 'y'), 'aw bx cy', 'currying one named param';
}

# https://github.com/Raku/old-issue-tracker/issues/4249
{
    my $w = &tester.assuming(b => 'b');
    my $v =  $w.assuming(c => 'c');
    is $v(a => 'x'), 'ax bb cc', 'can curry on an already curried sub';
    is $w(a => 'x', c => 'd'), 'ax bb cd', '... and the old one still works';
}

# Since you can override named params .assuming does not alter sig
#?rakudo 12 todo "awaiting resurrecting of RakuAST assuming"
is-primed-sig(sub (:$a) { }, :(:$a = True), :a);
is-primed-sig(sub (:$a, :$b) { }, :(:$a, :$b = True), :b);
is-primed-sig(sub (:$a, :$b) { }, :(:$a = True, :$b), :a);
is-primed-sig(sub (:$a?) { }, :(:$a = True), :a);
is-primed-sig(sub (:$a?, :$b?) { }, :(:$a, :$b = True), :b);
is-primed-sig(sub (:$a?, :$b?) { }, :(:$a = True, :$b), :a);
is-primed-sig(sub (:$a!) { }, :(:$a = True), :a);
is-primed-sig(sub (:$a!, :$b!) { }, :(:$a!, :$b = True), :b);
is-primed-sig(sub (:$a!, :$b!) { }, :(:$a = True, :$b!), :a);
is-primed-sig(sub (:$a = 2) { }, :(:$a = True), :a);
is-primed-sig(sub (:$a = 2, :$b = 4) { }, :(:$a = 2, :$b = True), :b);
is-primed-sig(sub (:$a = 2, :$b = 4) { }, :(:$a = True, :$b = 4), :a);
is-primed-sig(sub ($a, $b, :$c) { }, :($b, :$c), 1);
#?rakudo 9 todo "awaiting resurrecting of RakuAST assuming"
is-primed-sig(sub (:b($a)!) { }, :(:b($a) = True), :b);
is-primed-sig(sub (:b(:c($a))!) { }, :(:b(:c($a)) = True), :c);
is-primed-sig(sub (:b(:c($a))!) { }, :(:b(:c($a)) = True), :b);
is-primed-sig(sub (:$a! where { True }) { }, :(:$a where { ... } = True), :a);
is-primed-sig(sub (:$a! is raw where { True }) { }, :(:$a is raw where { ... } = True), :a);
is-primed-sig(sub (:$a! is copy where { True }) { }, :(:$a is copy where { ... } = True), :a);

# https://github.com/Raku/old-issue-tracker/issues/3686
is-primed-sig(sub (:$a! is raw where { True }) { }, :(:$a is raw where { True } = True), :a);
is-primed-sig(sub (:$a is copy where { True } = 4) { }, :(:$a is copy where { True } = True), :a);
is-primed-sig(sub (Int :$a! where { True }) { }, :(Int :$a where { True } = 1), :a(1));

priming-fails-bind-ok(sub { }, "", "Unexpected", :a);
priming-fails-bind-ok(sub (:b(:c($a))!) { }, "", "Unexpected", :d);
#?rakudo todo 'unclear semantics of test logic'
priming-fails-bind-ok(sub (Str :$a!) { }, '$a', X::TypeCheck::Assignment, :a);

# vim: expandtab shiftwidth=4
