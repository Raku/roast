use v6;

use Test;


# L<S02/Underscores/"A single underscore is allowed only">

=begin pod

_ should be allowed in numbers

But according to L<S02/Literals/"A single underscore is allowed only">, only between two digits.

=end pod

plan 19;

is 1_0, 10, "Single embedded underscore works";

throws_like { EVAL '1__0' },
  X::Comp::Group,
  "Multiple embedded underscores fail";

throws_like { EVAL '_10' },
  X::Undeclared::Symbols,
  "Leading underscore fails";

throws_like { EVAL '10_' },
  X::Syntax::Confused,
  "Trailing underscore fails";

throws_like { EVAL '10_.0' },
  X::Syntax::Confused,
  "Underscore before . fails";

throws_like { EVAL '10._0' },
  X::Method::NotFound,
  "Underscore after . fails";

throws_like { EVAL '10_e1' },
  X::Syntax::Confused,
  "Underscore before e fails";

throws_like { EVAL '10e_1' },
  X::Syntax::Confused,
  "Underscore after e fails";

throws_like { EVAL '10_E1' },
  X::Syntax::Confused,
  "Underscore before E fails";

throws_like { EVAL '10E_1' },
  X::Syntax::Confused,
  "Underscore after E fails";

ok 3.1_41 == 3.141, "Underscores work with floating point after decimal";

ok 10_0.8 == 100.8, "Underscores work with floating point before decimal";

is 0xdead_beef, 0xdeadbeef, "Underscores work with hex";

is 0b1101_1110_1010_1101_1011_1110_1110_1111, 0xdeadbeef, "Underscores work with binary";

is 2e0_1, 20, "Underscores work in the argument for e";

ok 2.1_23 == 2.123, "2.1_23 parses as number";

throws_like { 2._foo },
  X::Method::NotFound,
  "2._foo parses as method call";
throws_like { 2._123 },
  X::Method::NotFound,
  "2._123 parses as method call";
throws_like { 2._e23 },
  X::Method::NotFound,
  "2._23  parses as method call";

# vim: ft=perl6
