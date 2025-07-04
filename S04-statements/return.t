use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 26;

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
    is_run('return 1; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'bare return fails (2)');

    is_run('for 1 {return 2}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare for block');

    is_run('my $i = 1; while $i-- {return 3}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare while');
    is_run('my $i = 0; until $i++ {return 4}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare until');
    is_run('loop (my $i = 0; $i < 1; $i++) {return 5}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare loop');

    is_run('do {return 5}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a do block');

    is (try EVAL 'my $double = -> $x { return 2 * $x }; sub foo($x) { $double($x) }; foo 42').defined, False, 'return is lexotic only; must not attempt dynamic return';
}

{
    sub list_return { return (42, 1) }
    my $bar = ~list_return();
    is($bar, '42 1', 'Should not return empty string');
}

# https://github.com/Raku/old-issue-tracker/issues/2593
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

# https://github.com/Raku/old-issue-tracker/issues/6088
throws-like Q[sub { INIT return }],
    X::ControlFlow::Return,
    'INIT return handled correctly';
throws-like Q[sub {CHECK return;}],
    X::Comp::BeginTime,
    exception => X::ControlFlow::Return,
    'CHECK return handled correctly';

# https://github.com/rakudo/rakudo/issues/1216
#?rakudo.jvm 3 skip 'UnwindException'
throws-like ｢sub { eager sub { ^1 .map: { return } }() }()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
# https://github.com/Raku/old-issue-tracker/issues/2823
throws-like ｢sub a1 { my &x = { return }; &x }; my &y = a1; &y()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
throws-like ｢sub a2 { my &x = { return }; &x }; sub b1(&x) { &x() }; b1(a2)｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
throws-like ｢return｣, X::ControlFlow::Return, :out-of-dynamic-scope{.not},
   'bare return does not set $.out-of-dynamic-scope';



# vim: expandtab shiftwidth=4
