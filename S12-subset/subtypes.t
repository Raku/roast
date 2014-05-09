use v6;

use Test;

plan 77;

=begin description

Tests subtypes, specifically in the context of multimethod dispatch.

=end description

# L<S12/"Types and Subtypes">

#?niecza skip '$n has already been used as a non-placeholder in the surrounding block'
{
    my $abs = '
    multi sub my_abs (Int $n where { $^n >= 0 }){ $n }
    multi sub my_abs (Int $n where { $^n <  0 }){ -$n }
    ';

    ok(EVAL("$abs; 1"), "we can compile subtype declarations");

    is(EVAL("$abs; my_abs(3)"), 3, "and we can use them, too");
    is(EVAL("$abs; my_abs(-5)"), 5, "and they actually work");
}

{
    my $abs = '
    multi sub another_abs (Int $n where { $_ >= 0 }){ $n }
    multi sub another_abs (Int $n where { $_ <  0 }){ -$n }
    ';

    ok(EVAL("$abs; 1"), "we can compile subtype declarations");

    is(EVAL("$abs; another_abs(3)"), 3, "and we can use them, too");
    is(EVAL("$abs; another_abs(-5)"), 5, "and they actually work");
}

# another nice example
{
    multi factorial (Int $x)          { $x * factorial($x-1) };
    multi factorial (Int $x where 0 ) { 1 };   #OK not used
    is factorial(3), 6, 'subset types refine candidate matches';
}

# Basic subtype creation

{
    subset Int::Odd of Int where { $^num % 2 == 1 };
    is EVAL('my Int::Odd $a = 3'), 3, "3 is an odd num";
    # The EVAL inside the EVAL is/will be necessary to hider our smarty
    # compiler's compile-time from bailing.
    # (Actually, if the compiler is *really* smarty, it will notice our EVAL trick,
    # too :))
    is EVAL('my Int::Odd $b = 3; try { $b = EVAL "4" }; $b'), 3,
      "objects of Int::Odd don't get even";

    # Subtypes should be undefined.
    nok Int::Odd.defined, 'subtypes are undefined';

    # Subs with arguments of a subtype
    sub only_accepts_odds(Int::Odd $odd) { $odd + 1 }
    is only_accepts_odds(3), 4, "calling sub worked";
    dies_ok { only_accepts_odds(4) },  "calling sub did not work";

    # Can smartmatch too
    sub is_num_odd(Int::Odd $odd) { $odd ~~ Int::Odd },
    ok is_num_odd(3), "Int accepted by Int::Odd";
}

# The same, but lexically
#?niecza skip 'Pathed definitions require our scope'
{
    my subset Int::Even of Int where { $^num % 2 == 0 }
    ok my Int::Even $c = 6;
    ok $c ~~ Int::Even, "our var is a Int::Even";
    try { $c = 7 }
    is $c, 6, "setting a Int::Even to an odd value dies";
    ok EVAL('!try { my Int::Even $d }'),
        "lexically declared subtype went out of scope";
}

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
    sub so_wrong_too($x where { $^epic = "fail" }) { }   #OK not used
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

#?niecza skip 'Object reference not set to an instance of an object'
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
    #?niecza todo
    dies_ok { RT65700.new( small => 20 ) }, 'subset type is enforced as attribute in new() (1)';
    lives_ok { RT65700.new( small => 2 ) }, 'subset type enforced as attribute in new() (2)';

    my subset Teeny of Int where { $^n < 10 }
    class T { has Teeny $.teeny }
    #?niecza todo
    dies_ok { T.new( teeny => 20 ) }, 'my subset type is enforced as attribute in new() (1)';
    lives_ok { T.new( teeny => 2 ) }, 'my subset type enforced as attribute in new() (2)';
}

# RT #78318
{
    my @*rt78318;
    subset Bug  of Int where { @*rt78318.push( 'bug' ) };
    subset Hunt of Bug where { @*rt78318.push( 'hunt' ) };
    78318 ~~ Hunt;
    is @*rt78318, <bug hunt>, 'code called when subtype built on subtype';
}

# RT #78322
{
    my $*call1;
    my $*call2;

    $*call1 = 0;$*call2 = 0;

    subset RT78322 of Int     where { $*call1++; $^a == 78322 };
    subset Bughunt of RT78322 where { $*call2++; ?1 };

    $*call1 = 0;$*call2 = 0;
    nok 22 ~~ RT78322, 'level one subset check is false';
    is $*call1, 1, 'level one subset checked (should fail)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    nok 22 ~~ Bughunt, 'overall subset check is false';
    is $*call1, 1, 'level one subset checked (should fail)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    ok 78322 ~~ RT78322, 'level one subset check is true';
    is $*call1, 1, 'level one subset checked (should succeed)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    ok 78322 ~~ Bughunt, 'overall subset check is true';
    is $*call1, 1, 'level one subset checked (should succeed)';
    is $*call2, 1, 'level two subset checked (should succeed)';
}

#?niecza skip 'Object reference not set to an instance of an object'
{
    role R { };
    subset S of R;
    # RT #75718
    nok 1 ~~ S, 'subsets of roles (1)';
     ok R ~~ S, 'subsets of roles (2)';

    ok (R ~~ S) ~~ Bool, 'smart-matching a subset returns a Bool (1)';
    ok (S ~~ R) ~~ Bool, 'smart-matching a subset returns a Bool (2)';
}


# RT #89708
{
    subset Many::Parts of Str;
    ok 'a' ~~ Many::Parts, 'subset names with many parts work';
}

{
    subset Int::Positive of Int where { $_ > 0 };
    sub f(Int::Positive $a) { $a * $a };
    dies_ok { EVAL('f(-2)') }, 'Cannot violate Int::Positive constraint';
}

# RT #71820
#?niecza todo
{
    subset Interesting of Int where * > 10;
    class AI { has Interesting $.x };
    try { EVAL 'AI.new(x => 2)' };
    ok $!.Str ~~ /Interesting/, 'error message mentions subset name';

}

# RT #79160
{
    my Str subset MyStr;
    #?rakudo todo 'RT 79160'
    ok MyStr ~~ Str, 'my str subset MyStr creates basically a type alias (1)';
    ok 'foo' ~~ MyStr, 'my str subset MyStr creates basically a type alias (2)';
    #?rakudo todo 'RT 79160'
    ok 2    !~~ MyStr, 'Ints are not in there';
}

# RT 72948
#?niecza skip "Exceptions not supported"
{
    try { EVAL 'sub foo($x where { $x == $y }, $y) { }' };
    isa_ok $!, X::Undeclared, 'subset in signature cannot use non-predeclared variable';
}

# vim: ft=perl6
