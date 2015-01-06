use v6;
use Test;

plan 36;

=begin pod

=head1 DESCRIPTION

This test tests the C<R...> reverse metaoperator.

=end pod

# Try mulitple versions of Rcmp, as it is one of the more
# more useful reversed ops, and if it works, probably
# most of the others will work as well.

is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa_ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";
is 4.3 Rcmp 5, 5 cmp 4.3, "4.3 Rcmp 5";
isa_ok 4.3 Rcmp 5, (5 cmp 4.3).WHAT, "4.3 Rcmp 5 is the same type as 5 cmp 4.3";
is 4.3 Rcmp 5.Num, 5.Num cmp 4.3, "4.3 Rcmp 5.Num";
isa_ok 4.3 Rcmp 5.Num, (5.Num cmp 4.3).WHAT, "4.3 Rcmp 5.Num is the same type as 5.Num cmp 4.3";
is 4.3i Rcmp 5.Num, 5.Num cmp 4.3i, "4.3i Rcmp 5.Num";
isa_ok 4.3i Rcmp 5.Num, (5.Num cmp 4.3i).WHAT, "4.3i Rcmp 5.Num is the same type as 5.Num cmp 4.3i";

# Try to get a good sampling of math operators

is 4 R+ 5, 5 + 4, "4 R+ 5";
isa_ok 4 R+ 5, (5 + 4).WHAT, "4 R+ 5 is the same type as 5 + 4";
is 4 R- 5, 5 - 4, "4 R- 5";
isa_ok 4 R- 5, (5 - 4).WHAT, "4 R- 5 is the same type as 5 - 4";
is 4 R* 5, 5 * 4, "4 R* 5";
isa_ok 4 R* 5, (5 * 4).WHAT, "4 R* 5 is the same type as 5 * 4";
is 4 R/ 5, 5 / 4, "4 R/ 5";
isa_ok 4 R/ 5, (5 / 4).WHAT, "4 R/ 5 is the same type as 5 / 4";
is 4 Rdiv 5, 5 div 4, "4 Rdiv 5";
isa_ok 4 Rdiv 5, (5 div 4).WHAT, "4 Rdiv 5 is the same type as 5 div 4";
is 4 R% 5, 5 % 4, "4 R% 5";
isa_ok 4 R% 5, (5 % 4).WHAT, "4 R% 5 is the same type as 5 % 4";
is 4 R** 5, 5 ** 4, "4 R** 5";
isa_ok 4 R** 5, (5 ** 4).WHAT, "4 R** 5 is the same type as 5 ** 4";

# and a more or less random sampling of other operators

is 4 R< 5, 5 < 4, "4 R< 5";
isa_ok 4 R< 5, (5 < 4).WHAT, "4 R< 5 is the same type as 5 < 4";
is 4 R> 5, 5 > 4, "4 R> 5";
isa_ok 4 R> 5, (5 > 4).WHAT, "4 R> 5 is the same type as 5 > 4";
is 4 R== 5, 5 == 4, "4 R== 5";
isa_ok 4 R== 5, (5 == 4).WHAT, "4 R== 5 is the same type as 5 == 4";
is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa_ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";

# precedence tests!
is 3 R/ 9 + 5, 8, 'R/ gets precedence of /';
is 4 R- 5 R/ 10, -2, "Rop gets the precedence of op";
is (9 R... 1, 3), (1, 3, 5, 7, 9), "Rop gets list_infix precedence correctly";

# RT #93350
eval_dies_ok '("a" R~ "b") = 1', 'Cannot assign to return value of R~';

# RT #77114
{
    eval_dies_ok '1 R= my $x', "R doesn't handle assignment";
}

# RT #118793
{
    throws_like { EVAL q[my $x; 5 R:= $x] }, Exception,
        message => 'Cannot reverse the args of := because list assignment operators are too fiddly',
        'adequate error message on trying to metaop-reverse binding (:=)';
}

# vim: ft=perl6
