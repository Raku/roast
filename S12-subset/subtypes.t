use v6;

use Test;

plan 19;

=begin description

Tests subtypes, specifically in the context of multimethod dispatch.

L<S12/"Types and Subtypes">

=end description

my $abs = '
multi sub my_abs (Num where { $^n >= 0 } $n){ $n }
multi sub my_abs (Num where { $^n <  0 } $n){ -$n }
';

ok(eval("$abs; 1"), "we can compile subtype declarations");

is(eval("my_abs(3)"), 3, "and we can use them, too");
is(eval("my_abs(-5)"), 5, "and they actually work");


# Basic subtype creation
ok eval('subset Num::Odd of Num where { $^num % 2 == 1 }; 1'),
  "subtype is correctly parsed";
is eval('my Num::Odd $a = 3'), 3, "3 is an odd num";
# The eval inside the eval is/will be necessary to hider our smarty
# compiler's compile-time from bailing.
# (Actually, if the compiler is *really* smarty, it will notice our eval trick,
# too :))
is eval('my Num::Odd $b = 3; try { $b = eval "4" }; $b'), 3,
  "objects of Num::Odd don't get even";

# The same, but lexically
my $eval1 = '{
  my subset Num::Even of Num where { $^num % 2 == 0 }
  ok my Num::Even $c = 6;
  ok $c ~~ Num::Even, "our var is a Num::Even";
  try { $c = eval 7 }
  is $c, 6, "setting a Num::Even to an odd value dies";
}';
eval $eval1;
ok eval('!try { my Num::Even $d }'),
  "lexically declared subtype went out of scope";

# Subs with arguments of a subtype
ok eval('sub only_accepts_odds(Num::Odd $odd) { $odd + 1 }'),
  "sub requiring a Num::Odd as argument defined (1)";
is eval('only_accepts_odds(3)'), 4, "calling sub worked";
#?rakudo skip 'return value of try on a failure is null'
ok eval('!try { only_accepts_odds(4) }'), "calling sub did not work";

# Normal Ints automatically morphed to Num::Odd
ok eval('sub is_num_odd(Num::Odd $odd) { $odd ~~ Num::Odd }'),
  "sub requiring a Num::Odd as argument defined (2)";
ok eval('is_num_odd(3)'), "Int accepted by Num::Odd";

# Following code is evil, but should work:
#?rakudo skip 'subests and lexicals'
#?DOES 7
{
  my Int $multiple_of;
  subset Num::Multiple of Int where { $^num % $multiple_of == 0 }

  $multiple_of = 5;
  ok $multiple_of ~~ Int, "basic sanity (1)";
  is $multiple_of,     5, "basic sanity (2)";

  ok my Num::Multiple $d = 10, "creating a new Num::Multiple";
  is $d,                   10, "creating a new Num::Multiple actually worked";
  dies_ok { $d = 7 },          'negative test also works';
  is $d,                   10, 'variable kept previous value';

  
  $multiple_of = 6;
  dies_ok { my Num::Multiple $e = 10 }, "changed subtype definition worked";
}

