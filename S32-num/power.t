use v6;

use Test;

plan 17;

# Real **
is(1 ** 2,    1, "1 **  2 ==  1");
is(4 ** 0,    1, "4 **  0 ==  1");
is(4 ** 1,    4, "4 **  1 ==  4");
is(4 ** 2,   16, "4 **  2 == 16");
is(4 ** 0.5,  2, "4 ** .5 ==  2");

is_approx(exp(1) ** 0.5,  exp(0.5), "e **  .5 ==   exp(.5)");
is_approx(exp(1) ** 2.5,  exp(2.5), "e ** 2.5 ==  exp(2.5)");

# Complex **
# This one only works by accident at the moment
is((4 + 0i) ** 2, 4 ** 2, "(4+0i) ** 2 == 16");

#?rakudo 2 todo 'Complex ** not properly implemented yet'
is(1i ** 2, -1, "i ** 2 == -1");
is(1i ** 3, -1i, "i ** 3 == -i");

# This one only works by accident at the moment
is(1i ** 4, 1, "i ** 4 == 1");

#?rakudo todo 'complex powers'
is(1i ** 3, -1i, "i ** 3 == -1i");
  
#?rakudo todo 'Complex ** not properly implemented yet'
{ 
    my $PI = 3.14159265358979323846264338327950288419716939937510;
    is_approx(exp(1) ** ($PI * 1i), -1, "e ** pi i = -1");
}
    
for (8i).roots(4) -> $z
{
    #?rakudo todo 'Complex ** not properly implemented yet'
    is_approx($z ** 4, 8i, "quartic root of 8i ** 4 = 8i");
}


done_testing;

# vim: ft=perl6
