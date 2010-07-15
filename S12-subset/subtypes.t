use v6;

use Test;

plan *;

=begin description

Tests subtypes, specifically in the context of multimethod dispatch.

=end description

# L<S12/"Types and Subtypes">

my $abs = '
multi sub my_abs (Num $n where { $^n >= 0 }){ $n }
multi sub my_abs (Num $n where { $^n <  0 }){ -$n }
';

ok(eval("$abs; 1"), "we can compile subtype declarations");

is(eval("my_abs(3)"), 3, "and we can use them, too");
is(eval("my_abs(-5)"), 5, "and they actually work");

# another nice example
{
    multi factorial (Int $x)          { $x * factorial($x-1) };
    multi factorial (Int $x where 0 ) { 1 };   #OK not used
    is factorial(3), 6, 'subset types refine candidate matches';
}

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

# Subtypes should be undefined.
is eval('Num::Odd.defined'), 0, 'subtypes are undefined';

# The same, but lexically
my $eval1 = '{
  my subset Num::Even of Num where { $^num % 2 == 0 }
  ok my Num::Even $c = 6;
  ok $c ~~ Num::Even, "our var is a Num::Even";
  try { $c = eval 7 }
  is $c, 6, "setting a Num::Even to an odd value dies";
}';
eval($eval1) // skip 3, 'Cant parse';
#?rakudo todo 'lexical subtypes'
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
{
  my Int $multiple_of;
  subset Num::Multiple of Int where { $^num % $multiple_of == 0 }

  $multiple_of = 5;
  ok $multiple_of ~~ Int, "basic sanity (1)";
  is $multiple_of,     5, "basic sanity (2)";

  ok (my Num::Multiple $d = 10), "creating a new Num::Multiple";
  is $d,                   10,   "creating a new Num::Multiple actually worked";
  dies_ok { $d = 7 },            'negative test also works';
  is $d,                   10,   'variable kept previous value';

  
  $multiple_of = 6;
  dies_ok { my Num::Multiple $e = 10 }, "changed subtype definition worked";
}

# Rakudo had a bug where 'where /regex/' failed
# http://rt.perl.org/rt3/Ticket/Display.html?id=60976
#?DOES 2
{
    subset HasA of Str where /a/;
    lives_ok { my HasA $x = 'bla' },   'where /regex/ works (positive)';
    eval_dies_ok 'my HasA $x = "foo"', 'where /regex/ works (negative)';
}

# You can write just an expression rather than a block after where in a sub
# and it will smart-match it.
{
    sub anon_where_1($x where "x") { 1 }   #OK not used
    sub anon_where_2($x where /x/) { 1 }   #OK not used
    is(anon_where_1('x'), 1,       'where works with smart-matching on string');
    dies_ok({ anon_where_1('y') }, 'where works with smart-matching on string');
    is(anon_where_2('x'), 1,       'where works with smart-matching on regex');
    is(anon_where_2('xyz'), 1,     'where works with smart-matching on regex');
    dies_ok({ anon_where_2('y') }, 'where works with smart-matching on regex');
}

# Block parameter to smart-match is readonly.
{
    subset SoWrong of Str where { $^epic = "fail" }
    sub so_wrong_too($x where { $^epic = "fail" }) { }
    my SoWrong $x;
    dies_ok({ $x = 42 },          'parameter in subtype is read-only...');
    dies_ok({ so_wrong_too(42) }, '...even in anonymous ones.');
}

# ensure that various operations do type cheks

{
    subset AnotherEven of Int where { $_ % 2 == 0 };
    my AnotherEven $x = 2;
    dies_ok { $x++ }, 'Even $x can not be ++ed';
    is $x, 2,         '..and the value was preserved';
    dies_ok { $x-- }, 'Even $x can not be --ed';
    is $x, 2,         'and the value was preserved';
}

{
    # chained subset types
    subset Positive of Int where { $_ > 0 };
    subset NotTooLarge of Positive where { $_ < 10 };

    my NotTooLarge $x;

    lives_ok { $x = 5 }, 'can satisfy both conditions on chained subset types';
    dies_ok { $x = -2 }, 'violating first condition barfs';
    dies_ok { $x = 22 }, 'violating second condition barfs';
}


# subtypes based on user defined classes and roles
{
    class C1 { has $.a }
    subset SC1 of C1 where { .a == 42 }
    ok !(C1.new(a => 1) ~~ SC1), 'subtypes based on classes work';
    ok C1.new(a => 42) ~~ SC1,   'subtypes based on classes work';
}
{
    role R1 { }; 
    subset SR1 of R1 where 1;
    ok !(1 ~~ SR1), 'subtypes based on roles work';
    my $x = 1 but R1;
    ok $x ~~ SR1,   'subtypes based on roles work';
}

subset NW1 of Int;
ok NW1 ~~ Int,  'subset declaration without where clause does type it refines';
ok 0 ~~ NW1,    'subset declaration without where clause accepts right value';
ok 42 ~~ NW1,   'subset declaration without where clause accepts right value';
ok 4.2 !~~ NW1, 'subset declaration without where clause rejects wrong value';
ok "x" !~~ NW1, 'subset declaration without where clause rejects wrong value';

# RT #65700
{
    subset Small of Int where { $^n < 10 }
    class RT65700 {
        has Small $.small;
    }
    dies_ok { RT65700.new( small => 20 ) }, 'subset type is enforced as attribute in new() (1)';
    lives_ok { RT65700.new( small => 2 ) }, 'subset type enforced as attribute in new() (2)';

    my subset Teeny of Int where { $^n < 10 }
    class T { has Teeny $.teeny }
    #?rakudo 2 todo 'RT 65700'
    dies_ok { T.new( small => 20 ) }, 'my subset type is enforced as attribute in new() (1)';
    lives_ok { T.new( small => 2 ) }, 'my subset type enforced as attribute in new() (2)';
}

done_testing;

# vim: ft=perl6
