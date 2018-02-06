use v6;
use Test;

plan 11;

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

# RT #123216
subtest 'coverage for crashes in certain operator setups' => {
    plan 2;
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

# https://github.com/rakudo/rakudo/issues/1315
# https://github.com/rakudo/rakudo/issues/1477
subtest 'postfix-to-prefix-inc-dec opt does not rewrite custom ops' => {
    plan 5;
    subtest 'custom classes' => {
        plan 2;
        my class A {}
        sub  prefix:<++>(A) { flunk 'postfix increment' }
        sub postfix:<++>(A) { pass  'postfix increment' }
        sub  prefix:<-->(A) { flunk 'postfix decrement' }
        sub postfix:<-->(A) { pass  'postfix decrement' }
        my $var = A.new;
        $var++;
        $var--;
    }
    subtest 'core types (Int)' => {
        plan 2;
        sub  prefix:<++>(Int) { flunk 'postfix increment' }
        sub postfix:<++>(Int) { pass  'postfix increment' }
        sub  prefix:<-->(Int) { flunk 'postfix decrement' }
        sub postfix:<-->(Int) { pass  'postfix decrement' }
        my $var = 42;
        $var++;
        $var--;
    }
    subtest 'core types (Num)' => {
        plan 2;
        sub  prefix:<++>(Num) { flunk 'postfix increment' }
        sub postfix:<++>(Num) { pass  'postfix increment' }
        sub  prefix:<-->(Num) { flunk 'postfix decrement' }
        sub postfix:<-->(Num) { pass  'postfix decrement' }
        my $var = 42e0;
        $var++;
        $var--;
    }
    subtest 'core types (native int)' => {
        plan 2;
        sub  prefix:<++>(int) { flunk 'postfix increment' }
        sub postfix:<++>(int) { pass  'postfix increment' }
        sub  prefix:<-->(int) { flunk 'postfix decrement' }
        sub postfix:<-->(int) { pass  'postfix decrement' }
        my int $var = 42;
        $var++;
        $var--;
    }
    subtest 'core types (native num)' => {
        plan 2;
        sub  prefix:<++>(num) { flunk 'postfix increment' }
        sub postfix:<++>(num) { pass  'postfix increment' }
        sub  prefix:<-->(num) { flunk 'postfix decrement' }
        sub postfix:<-->(num) { pass  'postfix decrement' }
        my num $var = 42e0;
        $var++;
        $var--;
    }
}
