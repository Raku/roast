use v6;
use Test;

plan 71;

=begin pod

=head1 DESCRIPTION

This test tests the C<R...> reverse metaoperator.

=end pod

# Try multiple versions of Rcmp, as it is one of the more
# more useful reversed ops, and if it works, probably
# most of the others will work as well.

is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";
is 4.3 Rcmp 5, 5 cmp 4.3, "4.3 Rcmp 5";
isa-ok 4.3 Rcmp 5, (5 cmp 4.3).WHAT, "4.3 Rcmp 5 is the same type as 5 cmp 4.3";
is 4.3 Rcmp 5.Num, 5.Num cmp 4.3, "4.3 Rcmp 5.Num";
isa-ok 4.3 Rcmp 5.Num, (5.Num cmp 4.3).WHAT, "4.3 Rcmp 5.Num is the same type as 5.Num cmp 4.3";
is 4.3i Rcmp 5.Num, 5.Num cmp 4.3i, "4.3i Rcmp 5.Num";
isa-ok 4.3i Rcmp 5.Num, (5.Num cmp 4.3i).WHAT, "4.3i Rcmp 5.Num is the same type as 5.Num cmp 4.3i";

# Try to get a good sampling of math operators

is 4 R+ 5, 5 + 4, "4 R+ 5";
isa-ok 4 R+ 5, (5 + 4).WHAT, "4 R+ 5 is the same type as 5 + 4";
is 4 R- 5, 5 - 4, "4 R- 5";
isa-ok 4 R- 5, (5 - 4).WHAT, "4 R- 5 is the same type as 5 - 4";
is 4 R* 5, 5 * 4, "4 R* 5";
isa-ok 4 R* 5, (5 * 4).WHAT, "4 R* 5 is the same type as 5 * 4";
is 4 R/ 5, 5 / 4, "4 R/ 5";
isa-ok 4 R/ 5, (5 / 4).WHAT, "4 R/ 5 is the same type as 5 / 4";
is 4 Rdiv 5, 5 div 4, "4 Rdiv 5";
isa-ok 4 Rdiv 5, (5 div 4).WHAT, "4 Rdiv 5 is the same type as 5 div 4";
is 4 R% 5, 5 % 4, "4 R% 5";
isa-ok 4 R% 5, (5 % 4).WHAT, "4 R% 5 is the same type as 5 % 4";
is 4 R** 5, 5 ** 4, "4 R** 5";
isa-ok 4 R** 5, (5 ** 4).WHAT, "4 R** 5 is the same type as 5 ** 4";

# and a more or less random sampling of other operators

is 4 R< 5, 5 < 4, "4 R< 5";
isa-ok 4 R< 5, (5 < 4).WHAT, "4 R< 5 is the same type as 5 < 4";
is 4 R> 5, 5 > 4, "4 R> 5";
isa-ok 4 R> 5, (5 > 4).WHAT, "4 R> 5 is the same type as 5 > 4";
is 4 R== 5, 5 == 4, "4 R== 5";
isa-ok 4 R== 5, (5 == 4).WHAT, "4 R== 5 is the same type as 5 == 4";
is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";

# precedence tests!
is 3 R/ 9 + 5, 8, 'R/ gets precedence of /';
is 4 R- 5 R/ 10, -2, "Rop gets the precedence of op";
is (9 R... 1, 3), (1, 3, 5, 7, 9), "Rop gets list_infix precedence correctly";

# https://github.com/Raku/old-issue-tracker/issues/2415
throws-like '("a" R~ "b") = 1', X::Assignment::RO, 'Cannot assign to return value of R~';

{
    1 R= my $x;
    is $x, 1, "R= works";
}

# https://github.com/Raku/old-issue-tracker/issues/3185
{
    throws-like { EVAL q[my $x; 5 R:= $x] }, Exception,
        message => 'Cannot reverse the args of := because list assignment operators are too fiddly',
        'adequate error message on trying to metaop-reverse binding (:=)';
}

# https://github.com/Raku/old-issue-tracker/issues/3042
{
    my $y = 5;
    is $y [R/]= 1, 1/5, '[R/]= works correctly (1)';
    sub r2cf(Rat $x is copy) {
        gather $x [R/]= 1 while ($x -= take $x.floor) > 0
    }
    is r2cf(1.4142136).join(" "), '1 2 2 2 2 2 2 2 2 2 6 1 2 4 1 1 2',
        '[R/]= works correctly (2)';
}

{
    my $foo = "foo";
    $foo [R~]= "bar";
    is $foo, "barfoo", '[Rop]= works correctly.';
}

# https://github.com/Raku/old-issue-tracker/issues/3184
{
    my @a = 5 Rxx rand;
    ok !([==] @a), "Rxx thunks the RHS";

    my @b = rand RRxx 5;
    ok !([==] @b), "RRxx thunks the LHS again";

    my @c = 5 RRRxx rand;
    ok !([==] @c), "RRRxx thunks the RHS again";
}
{
    my $side-effect = 0;
    0 Rxx $side-effect++;
    is $side-effect, 0, "Rxx thunks left side properly";
    1 Rxx $side-effect++;
    is $side-effect, 1, "Rxx thunk runs when needed";
    9 Rxx $side-effect++;
    is $side-effect, 10, "Rxx thunk runs repeatedly when needed";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Rand 0;
    is $side-effect, 0, "Rand thunks left side properly";
    $side-effect++ Rand 1;
    is $side-effect, 1, "Rand thunks runs when needed";
}
{
    my Mu $side-effect = 0;
    $side-effect++ R&& 0;
    is $side-effect, 0, "R&& thunks left side properly";
    $side-effect++ R&& 1;
    is $side-effect, 1, "R&& thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Ror 1;
    is $side-effect, 0, "Ror thunks left side properly";
    $side-effect++ Ror 0;
    is $side-effect, 1, "Ror thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    $side-effect++ R|| 1;
    is $side-effect, 0, "R|| thunks left side properly";
    $side-effect++ R|| 0;
    is $side-effect, 1, "R|| thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Randthen Nil;
    is $side-effect, 0, "Randthen thunks left side properly";
    $side-effect++ Randthen 1;
    is $side-effect, 1, "Randthen thunks runs when needed";
    $side-effect = $_ Randthen 23;
    is $side-effect, 23, "Randthen topicalizes when needed";
}
{
    my Mu $side-effect is default(Nil) = 0;
    $side-effect++ Rorelse 1;
    is $side-effect, 0, "Rorelse thunks left side properly";
    $side-effect++ Rorelse Nil;
    is $side-effect, 1, "Rorelse thunk runs when needed";
    $side-effect = $_ Rorelse Nil;
    ok $side-effect === Nil, "Rorelse topicalizes when needed";
}

throws-like '3 R. foo', X::Syntax::CannotMeta, "R. is too fiddly";
throws-like '3 R. "foo"', X::Obsolete, "R. can't do P5 concat";

is &infix:<R/>(1,2), 2, "Meta reverse R/ can autogen";
is &infix:<RR/>(1,2), 0.5, "Meta reverse RR/ can autogen";
is infix:<R/>(1,2), 2, "Meta reverse R/ can autogen without &";
is &[R/](1,2), 2, "Meta reverse R/ can autogen with &[]";

sub infix:<op> ($a,$b) { $a - $b }
{
    sub infix:<op> ($a,$b) { $a ** $b }
    is &infix:<Rop>(2,3), 9, "Meta reverse Rop can autogen with user-defined op";
}
is &infix:<Rop>(2,3), 1, "Meta reverse Rop autogen with user-overridden op stays local to block";

# https://github.com/Raku/old-issue-tracker/issues/5473
is-deeply (1 R, 2 R, 3 R, 4), (4, 3, 2, 1),
    'List associative operators and R interact OK';

subtest '[R~]=' => {
    plan 4;
    my $a;
    is-deeply $a [R~]= "bar", "bar",    'assign to :U, return value';
    is-deeply $a,             "bar",    'assign to :U, result';

    is-deeply $a [R~]= "foo", "foobar", 'assign to :D, return value';
    is-deeply $a,             "foobar", 'assign to :D, result';
}

# https://github.com/rakudo/rakudo/issues/1632
{
    my $got;
    sub with-named(:$value) { $got = $value };
    lives-ok { with-named(:value(3 R- 2)) }, "call doesn't throw";
    is $got, -1, "named is good";
}

# vim: expandtab shiftwidth=4
