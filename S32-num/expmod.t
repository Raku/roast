use Test;
plan 119;

# L<S32::Numeric/Numeric/"=item expmod">

=begin pod

Basic tests for the expmod() builtin

=end pod

for 2..30 -> $i {
    is 7.expmod($i, 10),   7 ** $i % 10,  "7.expmod($i, 10) == { 7 ** $i % 10 }";
    is 9.expmod($i, 10),   9 ** $i % 10,  "9.expmod($i, 10) == { 9 ** $i % 10 }";
    is expmod(11, $i, 8),  11 ** $i % 8,  "expmod(11, $i, 8) == { 11 ** $i % 8 }";
    is expmod(13, $i, 12), 13 ** $i % 12, "expmod(13, $i, 12) == { 13 ** $i % 12 }";
}

is 2988348162058574136915891421498819466320163312926952423791023078876139.expmod(
        2351399303373464486466122544523690094744975233415544072992656881240319,
        10 ** 40),
   1527229998585248450016808958343740453059, "Rosettacode example is correct";

# https://github.com/Raku/old-issue-tracker/issues/6053
# libtommath used to hang for these values (https://github.com/libtom/libtommath/issues/475)
{
  subtest '.expmod with negative powers does not hang' => {
    plan 5;
    #?rakudo.moar todo 'libtommath incorrectly errors and causes a throw instead of giving 0'
    lives-ok { die if 42.expmod(-1,1) != 0 }, '42,  -1,  1';
    dies-ok { 42.expmod(-42,42) }, '42, -42, 42';
    is-deeply  3.expmod(-4,4),  1,  '3,  -4,  4';
    is-deeply -3.expmod(-4,4), -1, '-3,  -4,  4';
    dies-ok { 42.expmod(-1,7)   }, '42,  -1,  7';
  }
}
# This test is just copied out of the above subtest because passing todos in subtests aren't
# reported. When this starts passing, this test can just be removed and the todo above removed.
#?rakudo.moar todo 'libtommath incorrectly errors and causes a throw instead of giving 0'
lives-ok { die if 42.expmod(-1,1) != 0 }, '42,  -1,  1';

# vim: expandtab shiftwidth=4
