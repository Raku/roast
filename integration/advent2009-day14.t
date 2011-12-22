# http://perl6advent.wordpress.com/2009/12/14/day-14-going-to-the-rats/

use v6;
use Test;

plan 22;

is (3/7).WHAT.gist, "Rat()";
is_approx (3/7), 0.4285714;

is_approx (3/7).Num + (2/7).Num + (2/7).Num - 1, -1.1102230e-16;
is 3/7 + 2/7 + 2/7 - 1,  0;

is (3/7).perl, "3/7";

is (3/7).numerator, 3;
is (3/7).denominator, 7;
is (3/7).nude.join('|'), "3|7";

my $a = 1/60000 + 1/60000; 
is $a.WHAT.gist, "Rat()";
is_approx $a, 3.3333333e-05;
is $a.perl, "1/30000";

$a = 1/60000 + 1/60001;
#?rakudo todo 'nom regression'
#?niecza todo
is $a.WHAT.gist, "Num()";
is_approx $a, 3.333305e-05;
#?rakudo todo 'nom regression'
#?niecza todo
ok $a.perl ~~ / '3.3333' /;


$a = cos(1/60000);
ok $a ~~Num, 'cos() returned a Num';
is_approx $a, 0.99999999;

is 3.14.Rat.perl, "157/50";
is pi.Rat.perl, "355/113";
#?rakudo todo 'nom regression'
is pi.Rat(1e-10).perl, "312689/99532";

is 1.75.WHAT.gist, "Rat()";
is 1.75.perl, "7/4";
is 1.752.perl, "219/125";

done;
