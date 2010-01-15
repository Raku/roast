use v6;
use Test;
plan *;

#L<S03/Smart matching/Any .foo method truth>
#L<S03/Smart matching/Any .foo(...) method truth>
{
    class Smartmatch::Tester {
        method a { 4 };
        method b($x) { 5 * $x };
        method c { 0 };
    }
    my $t = Smartmatch::Tester.new();
    ok ($t ~~ .a),    '$obj ~~ .method calls the method (+)';
    ok !($t ~~ .c),   '$obj ~~ .method calls the method (-)';
    ok ($t ~~ .b(3)), '$obj ~~ .method(arg) calls the method (true)';
    ok ($t ~~ .b: 3), '$obj ~~ .method: arg calls the method (true)';
    ok !($t ~~ .b(0)), '$obj ~~ .method(arg) calls the method (false)';
    ok !($t ~~ .b: 0), '$obj ~~ .method: arg calls the method (false)';

    # now change the same in when blocks, which also smart-match
    my ($a, $b, $c) = 0 xx 3;
    given $t {
        when .a { $a = 1 };
    }
    given $t {
        when .b(3) { $b = 1 };
    }
    given $t {
        when .b(0) { $c = 1 };
    }
    ok $a, '.method in when clause';
    ok $b, '.method(args) in when clause';
    ok !$c, '..method(args) should not trigger when-block when false';
}

done_testing;

# vim: ft=perl6
