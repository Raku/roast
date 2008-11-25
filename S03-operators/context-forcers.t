use v6;

use Test;

plan 99;

{ # L<S03/"Changes to Perl 5 operators"/imposes boolean context/>
  is ?True,    True,  "? context forcer works (1)";
  is ?False,   False, "? context forcer works (2)";

  is ?1,       True,  "? context forcer works (3)";
  is ?0,       False, "? context forcer works (4)";
  is ?(?1),    True,  "? context forcer works (5)";
  is ?(?0),    False, "? context forcer works (6)";

  is ?"hi",    True,  "? context forcer works (7)";
  is ?"",      False, "? context forcer works (8)";
  is ?(?"hi"), True,  "? context forcer works (9)";
  is ?(?""),   False, "? context forcer works (10)";

  is ?"3",     True,  "? context forcer works (11)";
  is ?"0",     False, "? context forcer works (12)";
  is ?(?"3"),  True,  "? context forcer works (13)";
  is ?(?"0"),  False, "? context forcer works (14)";

  is ?undef,   False, "? context forcer works (15)";
}
{ # L<S02/"Names and Variables" /In boolean contexts/>
  is ?[],      False,  "? context forcer: empty container is false";
  is ?[1],     True,   "? context forcer: non-empty container is true";
}
{ # L<SO2/"Names and Variables" /In a boolean context, a Hash/>
  is ?{},      False,  "? context forcer: empty hash is false";
  is ?{:a},    True,   "? context forcer: non-empty hash is true";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a numeric context/>
  is +1,           1, "+ context forcer works (1)";
  is +0,           0, "+ context forcer works (2)";
  is +"1",         1, "+ context forcer works (3)";
  is +"0",         0, "+ context forcer works (4)";
  is +"",          0, "+ context forcer works (5)";
  is +undef,       0, "+ context forcer works (6)";
  #?rakudo todo '"Inf" in numeric context'
  is +"Inf",     Inf, "+ context forcer works (7)";
  is +"-Inf",   -Inf, "+ context forcer works (8)";
  #?rakudo todo '"NaN" in numeric context'
  is +"NaN",     NaN, "+ context forcer works (9)";
  is +"3e5",  300000, "+ context forcer works (10)";
  is +(?0),        0, "+ context forcer works (11)";
  is +(?3),        1, "+ context forcer works (11)";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a string context/>
  is ~1,         "1", "~ context forcer works (1)";
  is ~0,         "0", "~ context forcer works (2)";
  is ~"1",       "1", "~ context forcer works (3)";
  is ~"0",       "0", "~ context forcer works (4)";
  is ~"",         "", "~ context forcer works (5)";
  is ~undef,      "", "~ context forcer works (6)";
  is ~"Inf",   "Inf", "~ context forcer works (7)";
  is ~"-Inf", "-Inf", "~ context forcer works (8)";
  is ~"NaN",   "NaN", "~ context forcer works (9)";
  is ~"3e5",   "3e5", "~ context forcer works (10)";
}

sub eval_elsewhere($code){ eval($code) }

# L<S02/Context/numeric "+">
# numeric (+) context
{
    my $a = '2 is my favorite number';
    isa_ok(+$a, Num, 'it is forced into a Num');
    is(+$a, 2, 'forced into numeric context');

    my $b = 'Did you know that, 2 is my favorite number';
    isa_ok(+$b, Num, 'it is forced into a Num');
    is(+$b, 0, 'non numbers forced into numeric context are 0');
}

# L<S03/Symbolic unary precedence/"prefix:<->">
{
    my $a = '2 is my favorite number';
    isa_ok(-$a, Num, 'it is forced into a Num');
    is(-$a, -2, 'forced into numeric context');

    my $b = 'Did you know that, 2 is my favorite number';
    isa_ok(-$b, Num, 'it is forced into a Num');

    # doubly-negated because -0 === 0 isn't neccessarily true
    is(-(-$b), 0, 'non numbers forced into numeric context are 0');
}

# L<S02/Context/string "~">
# L<S03/Changes to Perl 5 operators/Unary ~ string context>
# string context
{
    my $a = 10.500000;
    isa_ok(~$a, Str, 'it is forced into a Str');
    is(~$a, '10.5', 'forced into string context');

    my $b = -100;
    isa_ok(~$b, Str, 'it is forced into a Str');
    is(~$b, '-100', 'forced into string context');

    my $c = -100.1010;
    isa_ok(~$c, Str, 'it is forced into a Str');
    is(~$c, '-100.101', 'forced into string context');
}

# L<S02/Context/boolean "?">
# L<S03/Changes to Perl 5 operators/"?" imposes boolean context>
# boolean context
{
    my $a = '';
    isa_ok(?$a, Bool, 'it is forced into a Bool');
    ok(!(?$a), 'it is forced into boolean context');

    my $b = 'This will be true';
    isa_ok(?$b, Bool, 'it is forced into a Bool');
    ok(?$b, 'it is forced into boolean context');

    my $c = 0;
    isa_ok(?$c, Bool, 'it is forced into a Bool');
    ok(!(?$c), 'it is forced into boolean context');

    my $d = 1;
    isa_ok(?$d, Bool, 'it is forced into a Bool');
    ok(?$d, 'it is forced into boolean context');
}

#?rakudo skip 'is context'
{
    my $arrayref is context = list(1,2,3);
    my $boo is context = 37;
    ok eval_elsewhere('?(@$+arrayref)'), '?(@$arrayref) syntax works';
    ok eval_elsewhere('?(@($+arrayref))'), '?(@($arrayref)) syntax works';
}

# L<S03/Symbolic unary precedence/"prefix:<!>">
{
    my $a = '';
    isa_ok(!$a, Bool, 'it is forced into a Bool');
    ok(!$a, 'it is forced into boolean context');

    my $b = 'This will be true';
    isa_ok(!$b, Bool, 'it is forced into a Bool');
    ok(!(!$b), 'it is forced into boolean context');

    my $c = 0;
    isa_ok(!$c, Bool, 'it is forced into a Bool');
    ok(!$c, 'it is forced into boolean context');

    my $d = 1;
    isa_ok(!$d, Bool, 'it is forced into a Bool');
    ok(!(!$d), 'it is forced into boolean context');

}
#?rakudo skip 'is context'
{
    my $arrayref is context = list(1,2,3);

    ok eval_elsewhere('!(!(@$+arrayref))'), '!(@$arrayref) syntax works';
    ok eval_elsewhere('!(!(@($+arrayref)))'), '!(@($arrayref)) syntax works';
}

# int context
{
    my $a = '2 is my favorite number';
    isa_ok(int($a), Int, 'it is forced into a Int');
    is(+$a, 2, 'forced into integer context');

    my $b = 'Did you know that, 2 is my favorite number';
    isa_ok(int($b), Int, 'it is forced into a Int');
    is(int($b), 0, 'non numbers forced into integer context are 0');

    my $c = 1.21122111;
    isa_ok(int($c), Int, 'it is forced into a Int');
    is(int($c), 1, 'float numbers forced into integer context are 0');
}

#?rakudo skip 'TODO: @(), list assignment'
{
    my $x = [0, 100, 280, 33, 400, 5665];

    is (@($x)[1], 100, '@$x works');

    is (@($x)[3]+50, 83, '@$x works inside a larger expression');

    my $y = [601, 700, 888];

    my @total = (@$x, @$y);

    is (@total[0], 0, "total[0] is 0");
    is (@total[1], 100, "total[1] is 100");
    is (@total[6], 601, "total[1] is 100");
    is (@total[8], 888, "total[1] is 100");
}

# the "upto" operator
# L<S03/Symbolic unary precedence/"prefix:<^>">

# ^$x is the range 0 .. ($x -1)
{
    ok   0 ~~ ^10, '0 is in ^10';
    ok   9 ~~ ^10, '9 is in ^10';
    ok 9.9 ~~ ^10, '9.99 is in ^10';
    ok 10 !~~ ^10, '10 is not in ^10';
    is (^10).elems, 10, '^10 has 10 elems';
    isa_ok ^10, 'Range';

    # now the same for ^@array, in which case prefix:<^>
    # imposes numeric context

    my @a = <one two three four five six seven eight nine ten>;
    #?rakudo 4 skip 'RT #60828'
    ok   0 ~~ ^@a, '0 is in ^10';
    ok   9 ~~ ^@a, '9 is in ^10';
    ok 9.9 ~~ ^@a, '9.99 is in ^10';
    ok  10 ~~ ^@a, '10 is not in ^10';
    #?rakudo 2 todo 'RT #60828'
    is (^@a).elems, 10, '^10 has 10 elems';
    isa_ok ^@a, 'Range';
}
