use v6;
use Test;

plan 10;

{
    sub prefix:<X> ($thing) { return "ROUGHLY$thing"; };

    is(X "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator');
}

{
    sub prefix:<±> ($thing) { return "AROUND$thing"; };
    is ± "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, latin-1 range)';
    sub prefix:<(+-)> ($thing) { return "ABOUT$thing"; };
    is EVAL(q[ (+-) "fish" ]), "ABOUTfish", 'prefix operator overloading for new operator (nasty)';
}

{
    sub prefix:<∔> ($thing) { return "AROUND$thing"; };
    is ∔ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2214 DOT PLUS)';
}

{
    sub prefix:['Z'] ($thing) { return "ROUGHLY$thing"; };

    is(Z "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator Z');
}

{
    sub prefix:["∓"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2213 MINUS-OR-PLUS SIGN)';
}

{
    sub prefix:["\x[2213]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \x[2213] MINUS-OR-PLUS SIGN)';
}

{
    sub prefix:["\c[MINUS-OR-PLUS SIGN]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \c[MINUS-OR-PLUS SIGN])';
    # " # https://github.com/perl6/atom-language-perl6/issues/81
}

{
    my sub prefix:<->($thing) { return "CROSS$thing"; };
    is(-"fish", "CROSSfish",
        'prefix operator overloading for existing operator');
}

# https://github.com/Raku/old-issue-tracker/issues/3585
subtest 'coverage for crashes in certain operator setups' => {
    plan 2;
    # https://github.com/Raku/old-issue-tracker/issues/6662
    skip 'RT#132711', 2;
    # is-deeply do {
    #     sub postfix:<_post_l_>($a) is assoc<left> is equiv(&prefix:<+>) {
    #         "<$a>"
    #     }
    #     sub prefix:<_pre_l_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
    #         "($a)"
    #     }
    #     (_pre_l_ 'a')_post_l_
    # }, '<(a)>', '(1)';
    #
    # is-deeply do {
    #     sub infix:«MYPLUS»(*@a) is assoc('list') {
    #         [+] @a;
    #     }
    #
    #     sub prefix:«MYMINUS»($a) is looser(&infix:<MYPLUS>) {
    #         -$a;
    #     }
    #
    #     (MYMINUS 1 MYPLUS 2 MYPLUS 3)
    # }, -6, '(2)';
}

# vim: expandtab shiftwidth=4
