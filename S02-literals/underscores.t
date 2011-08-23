use v6;

use Test;


# L<S02/Underscores/"A single underscore is allowed only">

=begin pod

_ should be allowed in numbers

But according to L<S02/Literals/"A single underscore is allowed only">, only between two digits.

=end pod

plan 19;

is 1_0, 10, "Single embedded underscore works";

eval_dies_ok '1__0',  "Multiple embedded underscores fail";

eval_dies_ok '_10',   "Leading underscore fails";

eval_dies_ok '10_',   "Trailing underscore fails";

eval_dies_ok '10_.0', "Underscore before . fails";

eval_dies_ok '10._0', "Underscore after . fails";

eval_dies_ok '10_e1', "Underscore before e fails";

eval_dies_ok '10e_1', "Underscore after e fails";

eval_dies_ok '10_E1', "Underscore before E fails";

eval_dies_ok '10E_1', "Underscore after E fails";

ok 3.1_41 == 3.141, "Underscores work with floating point after decimal";

ok 10_0.8 == 100.8, "Underscores work with floating point before decimal";

is 0xdead_beef, 0xdeadbeef, "Underscores work with hex";

is 0b1101_1110_1010_1101_1011_1110_1110_1111, 0xdeadbeef, "Underscores work with binary";

is 2e0_1, 20, "Underscores work in the argument for e";

ok 2.1_23 == 2.123, "2.1_23 parses as number";

dies_ok { 2._foo },    "2._foo parses as method call";
dies_ok { 2._123 },    "2._123 parses as method call";
dies_ok { 2._e23 },    "2._23  parses as method call";

# vim: ft=perl6
