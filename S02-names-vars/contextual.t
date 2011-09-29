use v6;

use Test;

plan 23;

# L<S02/Names/"for the identifier of the variable">

sub foo() { $*VAR };

class CT {
    method foo() { $*VAR }
    method foo_priv { self!priv }
    method !priv { $*VAR }
}

my $o = CT.new;
{
    my $*VAR = 'one';
    is $*VAR,       'one', 'basic contextual declaration works';
    is foo(),       'one', 'called subroutine sees caller $*VAR';
    is $o.foo,      'one', 'called method sees caller $*VAR';
    is $o.foo_priv, 'one', 'called private method sees caller $*VAR';
    is CT.foo,      'one', 'called class method sees caller $*VAR';
    is CT.foo_priv, 'one', 'called private class method sees caller $*VAR';
    {
        my $*VAR = 'two';
        is $*VAR,  'two', 'inner contextual declaration works';
        is foo(),  'two', 'inner caller hides outer caller';
        is $o.foo, 'two', 'inner caller hides outer caller (method)';
        is CT.foo, 'two', 'inner caller hides outer caller (class method)';
        is $o.foo_priv, 'two', 'inner caller hides outer caller (private method)';
        is CT.foo_priv, 'two', 'inner caller hides outer caller (private class method)';
    }
    is foo(),       'one', 'back to seeing outer caller';
    is $o.foo,      'one', 'back (method)';
    is $o.foo_priv, 'one', 'back (private method)';
    is CT.foo,      'one', 'back (class method)';
    is CT.foo_priv, 'one', 'back (private class method)';
}

nok foo().defined, 'contextual $*VAR is undefined';

{
    sub  a1() { @*AR; @*AR.join('|') };
    my @*AR = <foo bar>;
    is a1(), 'foo|bar', 'contextual @-variables work';
}

{
    sub a2() { &*CC('a') };
    my &*CC = -> $x { 'b' ~ $x };
    is a2(), 'ba', 'contextual Callable variables work';

}

# no idea if it actually makes sense to put contextuals inside a package, but
# the lexical alias that's also created should work just fine:
#
# Notsomuch in niecza, as the "lexical alias" is only seen by the compiler...
#?niecza 2 skip 'our $*a'
{
    sub f { $*a };
    our $*a = 'h';
    is f(), 'h', 'our $*a';
}

{
    sub f { %*a };
    our %*a =  a => 'h';
    is f().keys, 'a', 'our %*a';
}

#RT #63226
#?niecza todo
{
    package Foo { our sub run() { return @*INC } };
    ok Foo::run().chars > 0;
}

# vim: ft=perl6
