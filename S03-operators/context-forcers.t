use v6;

use Test;

plan 106;

#?DOES 1
sub iis(Mu $a, Mu $b, $descr) {
    unless ok($a === $b, $descr) {
        diag "Got:      " ~ $a.perl;
        diag "Expected: " ~ $b.perl;
    }

}

{ # L<S03/"Changes to Perl 5 operators"/imposes boolean context/>
  iis ?True,    True,  "? context forcer works (1)";
  iis ?False,   False, "? context forcer works (2)";

  iis ?1,       True,  "? context forcer works (3)";
  iis ?0,       False, "? context forcer works (4)";
  iis ?(?1),    True,  "? context forcer works (5)";
  iis ?(?0),    False, "? context forcer works (6)";

  iis ?"hi",    True,  "? context forcer works (7)";
  iis ?"",      False, "? context forcer works (8)";
  iis ?(?"hi"), True,  "? context forcer works (9)";
  iis ?(?""),   False, "? context forcer works (10)";

  iis ?"3",     True,  "? context forcer works (11)";
  iis ?"0",     True,  "? context forcer works (12)";
  iis ?(?"3"),  True,  "? context forcer works (13)";
  iis ?(?"0"),  True,  "? context forcer works (14)";

  iis ?Mu,      False, "? context forcer works (15)";
}
{ # L<S02/"Names and Variables" /In boolean contexts/>
  iis ?[],      False,  "? context forcer: empty container is false";
  iis ?[1],     True,   "? context forcer: non-empty container is true";
}
{ # L<SO2/"Names and Variables" /In a boolean context, a Hash/>
  iis ?{},      False,  "? context forcer: empty hash is false";
  iis ?{:a},    True,   "? context forcer: non-empty hash is true";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a numeric context/>
  is +1,           1, "+ context forcer works (1)";
  is +0,           0, "+ context forcer works (2)";
  is +(3/4),     3/4, "+ context forcer works (3)";
  is +(3i),       3i, "+ context forcer works (4)";
  dies-ok { +Mu },    "+ context forcer works (5)";
  is +(?0),        0, "+ context forcer works (13)";
  is +(?3),        1, "+ context forcer works (14)";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a numeric context/>
  is -1,          -1, "- context forcer works (1)";
  is -0,          -0, "- context forcer works (2)";
  is -(3/4),    -3/4, "- context forcer works (3)";
  is -(3i),      -3i, "- context forcer works (4)";
  dies-ok { -Mu },    "- context forcer works (5)";
  is -(?0),        0, "- context forcer works (13)";
  is -(?3),       -1, "- context forcer works (14)";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a string context/>
  is ~1,         "1", "~ context forcer works (1)";
  is ~0,         "0", "~ context forcer works (2)";
  is ~"1",       "1", "~ context forcer works (3)";
  is ~"0",       "0", "~ context forcer works (4)";
  is ~"",         "", "~ context forcer works (5)";
  dies-ok { ~Mu },    "~ context forcer works (6)";
  is ~"Inf",   "Inf", "~ context forcer works (7)";
  is ~"-Inf", "-Inf", "~ context forcer works (8)";
  is ~"NaN",   "NaN", "~ context forcer works (9)";
  is ~"3e5",   "3e5", "~ context forcer works (10)";
}

ok 4.Str ~~ Str, 'Int.Str returns a Str';

sub eval_elsewhere($code){ EVAL($code) }

# L<S02/Context/numeric "+">
# numeric (+) context
{
    my $a = '2 is my favorite number';
    isa-ok(+$a, Failure, 'trailing chars cause failure');

    my $b = 'Did you know that, 2 is my favorite number';
    isa-ok(+$b, Failure, 'it is forced into a Num');
}

# L<S03/Symbolic unary precedence/"prefix:<->">
#?rakudo skip 'failure modes of Str.Numeric RT #124540'
{
    my $a = '2 is my favorite number';
    isa-ok(-$a, Failure, 'trailing chars cause failure');

    my $b = 'Did you know that, 2 is my favorite number';
    ok(-$b, Failure, 'it is forced into a Num');
}

# L<S02/Context/string "~">
# L<S03/Changes to Perl 5 operators/Unary ~ string context>
# string context
{
    my $a = 10.500000;
    ok(~$a ~~ Stringy, 'it is forced into a Str');
    is(~$a, '10.5', 'forced into string context');

    my $b = -100;
    ok(~$b ~~ Stringy, 'it is forced into a Str');
    is(~$b, '-100', 'forced into string context');

    my $c = -100.1010;
    ok(~$c ~~ Stringy, 'it is forced into a Str');
    is(~$c, '-100.101', 'forced into string context');
}

# L<S02/Context/boolean "?">
# L<S03/Changes to Perl 5 operators/"?" imposes boolean context>
# boolean context
{
    my $a = '';
    isa-ok(?$a, Bool, 'it is forced into a Bool');
    ok(!(?$a), 'it is forced into boolean context');

    my $b = 'This will be true';
    isa-ok(?$b, Bool, 'it is forced into a Bool');
    ok(?$b, 'it is forced into boolean context');

    my $c = 0;
    isa-ok(?$c, Bool, 'it is forced into a Bool');
    ok(!(?$c), 'it is forced into boolean context');

    my $d = 1;
    isa-ok(?$d, Bool, 'it is forced into a Bool');
    ok(?$d, 'it is forced into boolean context');
}

{
    my $arrayref is dynamic = list(1,2,3);
    my $boo is dynamic = 37;
    ok eval_elsewhere('?(@$*arrayref)'), '?(@$arrayref) syntax works';
    ok eval_elsewhere('?(@($*arrayref))'), '?(@($arrayref)) syntax works';
}

# L<S03/Symbolic unary precedence/"prefix:<!>">
{
    my $a = '';
    isa-ok(!$a, Bool, 'it is forced into a Bool');
    ok(!$a, 'it is forced into boolean context');

    my $b = 'This will be true';
    isa-ok(!$b, Bool, 'it is forced into a Bool');
    ok(!(!$b), 'it is forced into boolean context');

    my $c = 0;
    isa-ok(!$c, Bool, 'it is forced into a Bool');
    ok(!$c, 'it is forced into boolean context');

    my $d = 1;
    isa-ok(!$d, Bool, 'it is forced into a Bool');
    ok(!(!$d), 'it is forced into boolean context');

}
{
    my $arrayref is dynamic = list(1,2,3);

    ok eval_elsewhere('!(!(@$*arrayref))'), '!(@$arrayref) syntax works';
    ok eval_elsewhere('!(!(@($*arrayref)))'), '!(@($arrayref)) syntax works';
}

# int context
# tested in S32-num/int.t

{
    my $x = [0, 100, 280, 33, 400, 5665];

    is @($x)[1], 100, '@$x works';

    is @($x)[3]+50, 83, '@$x works inside a larger expression';

    my $y = [601, 700, 888];

    my @total = (flat @$x, @$y);

    is @total[0], 0, "total[0] is 0";
    is @total[1], 100, "total[1] is 100";
    is @total[6], 601, "total[6] is 601";
    is @total[8], 888, "total[8] is 888";
}

{
    ok %() ~~ Hash, '%() returns a Hash';
    is +%(), 0, '%() is an empty Hash';
}

{
    my $x = %(a => 3, b => 5);
    is $x<a>, 3, 'hash constructor worked (1)';
    is $x<b>, 5, 'hash constructor worked (1)';
    is $x.keys.sort.join(', '), 'a, b', 'hash constructor produced the right keys';
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
    isa-ok ^10, Range;

    # now the same for ^@array, in which case prefix:<^>
    # imposes numeric context

    my @a = <one two three four five six seven eight nine ten>;
    ok   0 ~~ ^@a, '0 is in ^10';
    ok   9 ~~ ^@a, '9 is in ^10';
    ok 9.9 ~~ ^@a, '9.99 is in ^10';
    ok  10 !~~ ^@a, '10 is not in ^10';
    is (^@a).elems, 10, '^10 has 10 elems';
    isa-ok ^@a, Range;
}

{
    my $l = list 1,2,4...16;
    ok $l.WHAT === Seq, "list listop on Seq is no-op";
    ok $l.gist eq '(1 2 4 8 16)', "list listop doesn't double wrap";
    my \seq = 1,2,4...16;
    dies-ok { sink (list seq)».abs, (list seq)».abs }, "list listop doesn't cache";
}

{
    my $l = list 1..5;
    ok $l.WHAT === List, "list listop on non-Seq is List";
    ok $l.gist eq '(1 2 3 4 5)', "list listop doesn't double wrap";
    my \seq = $l.grep(* > 0);
    dies-ok { sink (list seq)».abs, (list seq)».abs }, "list listop doesn't cache";
}

{
    my $l = cache 1,2,4...16;
    ok $l.WHAT === List, "cache listop produces List";
    ok $l.gist eq '(1 2 4 8 16)', "cache listop doesn't double wrap";
    my \seq = 1,2,4...16;
    is ((cache seq)».abs, (cache seq)».abs).gist, '((1 2 4 8 16) (1 2 4 8 16))', "cache listop does cache";
}

# vim: ft=perl6
