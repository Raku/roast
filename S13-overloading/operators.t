use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
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
    # https://github.com/Raku/old-issue-tracker/issues/3219
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
# https://github.com/Raku/old-issue-tracker/issues/1906
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

# https://github.com/Raku/old-issue-tracker/issues/6593
is_run ｢$ = ""; sub postfix:<♥> ($) { "pass" }; print "{ 5♥ }"｣,
    {:out<pass>, :err(''), :0status},
'earlier quoted strings do not interfere with later interpolation of newly defined ops';

# vim: expandtab shiftwidth=4
