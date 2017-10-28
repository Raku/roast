use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 7;

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
    my @keys;
    class A does Associative {
        multi method AT-KEY(A:D: $key) {
            push @keys, $key;
            ++state $i
        }
    };

    is A.new<foo bar>, (1, 2), 'implementing AT-KEY gets {...} indexing working';
    is @keys, [<foo bar>], 'AT-KEY called once for each key';
}

# overloaded invoke
# RT #76330
# (even though the ticket title claims it, the actual problem was not related
# to monkey typing/augmenting at all)

{
    class B {
        has $.x;
        method CALL-ME($y) {
            $.x ~ $y;
        }
    }
    is B.new(x => 'a').('b'), 'ab', 'can overload invoke';
}

# RT #132262
is_run ｢$ = ""; sub postfix:<♥> ($) { "pass" }; print "{ 5♥ }"｣,
    {:out<pass>, :err(''), :0status},
'quote lang cache does not interfere with newly defined ops';

# vim: ft=perl6
