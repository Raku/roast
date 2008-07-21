use v6;
use Test;
plan 14;

# Is there a better reference for the spec for how return return works? 
# There is "return function" but that's a more advanced feature.
#L<S04/"Control Exceptions">

=begin pod

Basic tests for "return"

=end pod

sub bar { return }
is(bar(), undef, '... bare return statement returned undef');

sub bar2 { return() }
is(bar2(), undef, '... bare return statement w/ parens returned undef');

sub baz { return 10 if 1; }
is(baz(), 10, '... return worked with a statement modifier');

#?rakudo skip 'parsefail on "return if 1"'
sub foobar { return if 1; };
is(foobar(), undef, '... bare return worked with a statement modifier');

sub foobar2 { return() if 1; }
is(foobar2(), undef, '... bare return worked with a statement modifier');

my $should_ret_empty_list1 = sub { return; 1 };
is @($should_ret_empty_list1(),).elems, 0, "our sub returned an empty list (1)";

sub return_1 { return 1; }
is(return_1(), 1, '... return_1() returned 1 correctly');

#?rakudo skip 'no applicable method'
is( try { sub foo { my $x = 1; while $x-- { return 24; }; return 42; }; foo() }, 24, 'return in while');

# S04: "A return always exits from the lexically surrounding sub or method definition"
{
    eval_dies_ok('return 1', 'bare return fails');
    eval_dies_ok('for 1 {return 2}', 'cannot return out of a bare for block');
    eval_dies_ok('my $i = 1; while $i-- {return 3}', 'cannot return out of a bare while');
    eval_dies_ok('my $i = 0; until $i++ {return 4}', 'cannot return out of a bare until');
    eval_dies_ok('loop (my $i = 0; $i < 1; $i++) {return 5}', 'cannot return out of a bare loop');
    # XXX: Not 100% sure on this one
    eval_dies_ok('do {return 5}', 'cannot return out of a do block');
}

# vim: ft=perl6
