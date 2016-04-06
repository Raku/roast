use v6;
use Test;
plan 20;

use lib 't/spec/packages';
use Test::Util;

# Is there a better reference for the spec for how return return works? 
# There is "return function" but that's a more advanced feature.
#L<S04/"Control Exceptions">

=begin pod

Basic tests for "return"

=end pod

sub bar { return }
is(bar(), Nil, '... bare return statement returned Nil');

sub bar2 { return() }
is(bar2(), Nil, '... bare return statement w/ parens returned Nil');

sub baz { return 10 if 1; }
is(baz(), 10, '... return worked with a statement modifier');

sub foobar { return if 1; };
is(foobar(), Nil, '... bare return worked with a statement modifier');

sub foobar2 { return() if 1; }
is(foobar2(), Nil, '... bare return worked with a statement modifier');

my $should_ret_empty_list1 = sub { return; 1 };
is $should_ret_empty_list1(), Nil, "sub returned Nil";

sub return_1 { return 1; }
is(return_1(), 1, '... return_1() returned 1 correctly');

is( try { sub foo { my $x = 1; while $x-- { return 24; }; return 42; }; foo() }, 24, 'return in while');

# S04: "A return always exits from the lexically surrounding sub or method definition"
{
    ## throws-like, dies-ok and friends (even is_run from Test::Util) do
    ## not catch this error (Attempt to return outside of any Routine) properly
    is run($*EXECUTABLE, '-e', 'return 1; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'bare return fails (2)';
    #?rakudo todo 'for is implemented in terms of map, so return is inside routine'
    is run($*EXECUTABLE, '-e', 'for 1 {return 2}; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'cannot return out of a bare for block';
    is run($*EXECUTABLE, '-e', 'my $i = 1; while $i-- {return 3}; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'cannot return out of a bare while';
    is run($*EXECUTABLE, '-e', 'my $i = 0; until $i++ {return 4}; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'cannot return out of a bare until';
    is run($*EXECUTABLE, '-e', 'loop (my $i = 0; $i < 1; $i++) {return 5}; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'cannot return out of a bare loop';
    # XXX: Not 100% sure on this one
    is run($*EXECUTABLE, '-e', 'do {return 5}; CATCH { default { print .^name } }', :out).out.lines[0],
        'X::ControlFlow::Return',
        'cannot return out of a do block';

    is (try EVAL 'my $double = -> $x { return 2 * $x }; sub foo($x) { $double($x) }; foo 42').defined, False, 'return is lexotic only; must not attempt dynamic return';
}

{
    sub list_return { return (42, 1) }
    my $bar = ~list_return();
    is($bar, '42 1', 'Should not return empty string');
}

# RT #81962
{
    my $tracker = '';
    my &r = &return;
    sub f {
        my &return := -> $v {
            $tracker ~= 'LOL';
            &r($v * 2);
        };
        return(21);
    }
    is f(), 42, 'proxied return produces the correct value';
    is $tracker, 'LOL', 'proxied return produced the right side effect';
}

{
    sub a { .return with 42 }
    is a, 42, 'does .return work?';
    sub b { (1|2|3).return }  # don't auto-thread on return
    isa-ok b, Junction;
}

# vim: ft=perl6
