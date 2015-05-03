use v6;
use Test;
plan 6;

{
    sub infix:<lea>($a, $b) is assoc<left> {
        "($a|$b)";
    }

    is (1 lea 2 lea 3), '((1|2)|3)', 'assoc<left>';
}

{
    sub infix:<ra>($a, $b) is assoc<right> {
        "($a|$b)";
    }

    is (1 ra 2 ra 3), '(1|(2|3))', 'assoc<right>';
}

{
    sub infix:<lia>(*@a) is assoc<list> {
        '(' ~ join('|', @a) ~ ')';
    }
    is (1 lia 2 lia 3), '(1|2|3)', 'assoc<list>';
}

{
    sub infix:<na>(*@a) is assoc<non> {
        '(' ~ join('|', @a) ~ ')';
    }
    # RT #116238
    dies_ok { EVAL '1 na 2 na 3' }, 'assoc<non>';
}

#?rakudo skip 'RT 116244'
{
    sub postfix:<_post_l_>($a) is assoc<left> is equiv(&prefix:<+>) {
        "<$a>"
    }
    sub prefix:<_pre_l_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
        "($a)"
    }
    is (_pre_l_ 'a' _post_l_), '<(a)>', 'assoc<left> on prefix/postfix ops';
}

#?rakudo skip 'RT 116244'
{
    sub postfix:<_post_r_>($a) is assoc<left> is equiv(&prefix:<+>) {
        "<$a>"
    }
    sub prefix:<_pre_r_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
        "($a)"
    }
    is (_pre_r_ 'a' _post_r_), '(<a>)', 'assoc<left> on prefix/postfix ops';
}
