use v6;
use Test;

plan 5;

#L<S06/Operator overloading>

{
    sub postfix:<§> ($x) {
        $x * 2;
    };
    is 3§, 6, 'Can define postfix operator';
}

{
    sub postfix:<!>($arg) {
        if ($arg == 0) { 1;}
        else { ($arg-1)! * $arg;}
    };
    is 5!, 120, 'Can define recursive postfix operator';
    # RT #119473
    is 5.!, 120, 'Can use newly defined postfix operator with leading dot';
}

{
    class A does Associative {
        method postcircumfix:<{ }>(*@ix) {   # METHOD TO SUB CASUALTY
            return @ix
        }
    };

    #?rakudo skip 'cannot easily override {} at the moment'
    is A.new<foo bar>, <foo bar>, 'defining postcircumfix:<{ }> works';
}

# overloaded invoke
# RT #76330
# (even though the ticket title claims it, the actual problem was not related
# to monkey typing/augmenting at all)

{
    class B {
        has $.x;
        method postcircumfix:<( )>($y) {
            $.x ~ $y;
        }
    }
    is B.new(x => 'a').('b'), 'ab', 'can overload invoke';
}

# vim: ft=perl6
