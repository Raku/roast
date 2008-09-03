use v6;

use Test;

=begin pod

Tests for precedence of self defined operators

L<S06/Subroutine traits/"relative to an existing">

=end pod

plan 10;

do {
    sub prefix:<!> (Num $x) is tighter(&infix:<**>) {
        return 3 * $x;
    }

    is !1**2, 9, "'is tighter' on prefix works";
}

do {
    sub prefix:<foo> (Num $x) is looser(&infix:<+>) {
        return 2 * $x;
    }

    is foo 2 + 3, 10, "'is looser' on prefix works";
}


{
    sub postfix:<!> (Num $x) is tighter(&infix:<**>) {
        return 2 * $x;
    }

    is 2**1!, 2, "'is tighter' on postfix works";
}


{
    sub infix:<mul> ($a, $b) is looser(&infix:<+>) {
        return $a * $b;
    }

    is 2 mul 3 + 4, 14, "'is looser' infix works 1";
    is 4 + 3 mul 2 , 14, "'is looser' infix works 2";
}

{
    sub infix:<div> ($a, $b) is equiv(&infix:<*>) {
        return $a / $b;
    }

    is(4 div 2 * 3, 6, "'is equiv' works");
}

# prefix/postfix precedence

{
    sub prefix:<'foo1'> (Num $x) {
        return 2 * $x;
    }

    sub postfix:<'bar1'> (Num $x) is looser(&prefix:<'foo1'>){
        return 1 + $x;
    }

    is('foo1'3'bar1', 7, "Postifix declared looser than prefix");

    sub postfix:<'bar2'> (Num $x) is tighter(&prefix:<'foo1'>){
        return 1 + $x;
    }

    is('foo1'3'bar2', 8, "Postfix declared tighter than prefix");
}

{
    sub postfix:<!> ($n) {
        return [*] 1..$n;
    }

    is( -1!, -1 , "Should be parsed as '-(1!)'");
    ok(not defined eval '4 !',  "Whitespace not allowed before user-defined postfix");
}

