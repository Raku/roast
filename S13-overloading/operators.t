use v6;
use Test;

plan 3;

#L<S06/Operator overloading>

#?rakudo skip 'custom operators'
{
    sub postfix:<§> ($x) {
        $x * 2;
    };
    is 3§, 6, 'Can define postfix operator';
}

#?rakudo skip 'custom operators'
{
    sub postfix:<!>($arg) {
        if ($arg == 0) { 1;}
        else { ($arg-1)! * $arg;}
    };
    is 5!, 120, 'Can define recursive postfix operator';
}

{
    class A does Associative {
        method postcircumfix:<{ }>(*@ix) {
            return @ix
        }
    };

    is A.new<foo bar>, <foo bar>, 'defining postcircumfix:<{ }> works';
}

# vim: ft=perl6
