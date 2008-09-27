use v6;
use Test;

plan 2;

#L<S06/Operator overloading>

{
    ok eval(q[
        sub postfix:<§> ($x) {
            $x * 2;
        };
        3§;
    ]) == 6, 'Can define postfix operator';
}

{
    ok eval(q[
        sub postfix:<!>($arg) {
            if ($arg == 0) { 1;}
            else { ($arg-1)! * $arg;}
        };
        5!
    ]) == 120, 'Can define recursive postfix operator';
}


# vim: ft=perl6
