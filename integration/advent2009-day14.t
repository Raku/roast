# http://perl6advent.wordpress.com/2009/12/14/day-14-going-to-the-rats/

use v6;
use Test;

plan 23;

is (3/7).WHAT, "Rat()";
is (3/7), 0.428571428571429;

is (3/7).Num + (2/7).Num + (2/7).Num - 1, -1.11022302462516e-16;
is 3/7 + 2/7 + 2/7 - 1,  0;

is (3/7).perl, "3/7";

is (3/7).numerator, 3;
is (3/7).denominator, 7;
#?rakudo todo "advent says [], but rakudo using ()."
is (3/7).nude.perl, "[3, 7]";

my $a = 1/60000 + 1/60000; 
is $a.WHAT, "Rat()";
is $a, 3.33333333333333e-05;
is $a.perl, "1/30000";

$a = 1/60000 + 1/60001;
is $a.WHAT, "Num()";
is $a, 3.33330555601851e-05;
is $a.perl, 3.33330555601851e-05;


$a = cos(1/60000); 
is $a.WHAT, "Num()";
is $a, 0.999999999861111;
is $a.perl, 0.999999999861111;

is 3.14.Rat.perl, "157/50";
#?rakudo skip "Method '!modf' not found for invocant of class 'Num'"
is pi.Rat.perl, "355/113";
#?rakudo skip "Method '!modf' not found for invocant of class 'Num'"
is pi.Rat(1e-10).perl, "312689/99532";

is 1.75.WHAT, "Rat()";
is 1.75.perl, "7/4";
is 1.752.perl, "219/125";

done_testing;
