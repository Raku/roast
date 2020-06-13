# http://perl6advent.wordpress.com/2009/12/14/day-14-going-to-the-rats/

use v6;
use Test;

plan 21;

is-deeply (3/7).WHAT, Rat;
is-approx (3/7), 0.4285714;

is-approx (3/7).Num + (2/7).Num + (2/7).Num - 1, -1.1102230e-16;
is 3/7 + 2/7 + 2/7 - 1,  0;

is (3/7).raku, "<3/7>";

is (3/7).numerator, 3;
is (3/7).denominator, 7;
is (3/7).nude.join('|'), "3|7";

my $a = 1/60000 + 1/60000; 
is-deeply $a.WHAT, Rat;
is-approx $a, 3.3333333e-05;
is $a.raku, "<1/30000>";

$a = 1/60000 + 1/60001;
ok $a ~~ Rat || $a ~~ Num, "1/60000 + 1/60001 must be a Rat or a Num";
is-approx $a, 3.333305e-05;

$a = cos(1/60000);
ok $a ~~Num, 'cos() returned a Num';
is-approx $a, 0.99999999;

# I'm not at all convinced the next three are sensible tests -- colomon
is 3.14.Rat.raku, "3.14";
is pi.Rat.raku, "<355/113>";
is pi.Rat(1e-10).raku, "<312689/99532>";

is-deeply 1.75.WHAT, Rat;
is 1.75.raku, "1.75";
is 1.752.raku, "1.752";

# vim: expandtab shiftwidth=4
