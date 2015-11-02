use v6;

use Test;

plan 105;

sub test($range,$min,$max,$exmin,$exmax,$inf,$perl) {
    subtest {
        plan 7;
        isa-ok $range,           Range, "$range.gist() is a Range";
        is $range.min,            $min, "$range.gist().min is 2";
        is $range.max,            $max, "$range.gist().max is 6";
        is $range.excludes-min, $exmin, "$range.gist().excludes-min is $exmin";
        is $range.excludes-max, $exmax, "$range.gist().excludes-max is $exmax";
        is $range.infinite,       $inf, "$range.gist().infinite is $inf";
        is $range.perl,          $perl, "$range.gist().perl is $perl";
    }, "Testing $range.gist()"
}

test       2..6,    2,     6, False, False, False,        "2..6";
test     -1^..7,   -1,     7,  True, False, False,      "-1^..7";
test     3..^-1,    3,    -1, False,  True, False,      "3..^-1";
test "a"^..^"g",  'a',   'g',  True,  True, False,  '"a"^..^"g"';

test         ^5,    0,     5, False,  True, False,          "^5";
test       ^5.5,    0,   5.5, False,  True, False,     "0..^5.5";
test     ^5.5e0,    0, 5.5e0, False,  True, False,   "0..^5.5e0";

test       1..*,    1,   Inf, False, False,  True,      "1..Inf";
test      1^..*,    1,   Inf,  True, False,  True,     "1^..Inf";
test      1..^*,    1,   Inf, False,  True,  True,     "1..^Inf";
test     1^..^*,    1,   Inf,  True,  True,  True,    "1^..^Inf";

test       *..1, -Inf,     1, False, False,  True,     "-Inf..1";
test      *^..1, -Inf,     1,  True, False,  True,    "-Inf^..1";
test      *..^1, -Inf,     1, False,  True,  True,    "-Inf..^1";
test     *^..^1, -Inf,     1,  True,  True,  True,   "-Inf^..^1";

test       *..*, -Inf,   Inf, False, False,  True,   "-Inf..Inf";
test      *^..*, -Inf,   Inf,  True, False,  True,  "-Inf^..Inf";
test      *..^*, -Inf,   Inf, False,  True,  True,  "-Inf..^Inf";
test     *^..^*, -Inf,   Inf,  True,  True,  True, "-Inf^..^Inf";

# some range constructions are invalid
#?niecza skip "No exceptions"
{
    throws-like          '10 .. ^20', X::Range::InvalidArg, got => ^20;
    throws-like          '^10 .. 20', X::Range::InvalidArg, got => ^10;
    throws-like          '* .. ^20',  X::Range::InvalidArg, got => ^20;
    throws-like          '^10 .. *',  X::Range::InvalidArg, got => ^10;
    throws-like          '* .. 42i',  X::Range::InvalidArg, got => 42i;
    throws-like          '42i .. *',  X::Range::InvalidArg, got => 42i;
    throws-like '42.map({$_}) .. *',  X::Range::InvalidArg, got => Seq; 
    throws-like '* .. 42.map({$_})',  X::Range::InvalidArg, got => Seq;
}

ok 3 ~~ 1..5,         '3 ~~ 1..5';
ok 2.5 ~~ 1..5,       '2.5 ~~ 1..5';
ok 2.5e0 ~~ 1..5,     '2.5e0 ~~ 1..5';
ok 1 ~~ 1..5,         '1 ~~ 1..5';
ok 1.0 ~~ 1..5,       '1.0 ~~ 1..5';
ok 1.0e0 ~~ 1..5,     '1.0e0 ~~ 1..5';
ok 5 ~~ 1..5,         '5 ~~ 1..5';
ok 5.0 ~~ 1..5,       '5.0 ~~ 1..5';
ok 5.0e0 ~~ 1..5,     '5.0e0 ~~ 1..5';
nok 0 ~~ 1..5,        'not 0 ~~ 1..5';
nok 0.999 ~~ 1..5,    'not 0.999 ~~ 1..5';
nok 0.999e0 ~~ 1..5,  'not 0.999e0 ~~ 1..5';
nok 6 ~~ 1..5,        'not 6 ~~ 1..5';
nok 5.001 ~~ 1..5,    'not 5.001 ~~ 1..5';
nok 5.001e0 ~~ 1..5,  'not 5.001e0 ~~ 1..5';

ok 3 ~~ 1^..5,         '3 ~~ 1^..5';
ok 2.5 ~~ 1^..5,       '2.5 ~~ 1^..5';
ok 2.5e0 ~~ 1^..5,     '2.5e0 ~~ 1^..5';
nok 1 ~~ 1^..5,        'not 1 ~~ 1^..5';
nok 1.0 ~~ 1^..5,      'not 1.0 ~~ 1^..5';
nok 1.0e0 ~~ 1^..5,    'not 1.0e0 ~~ 1^..5';
ok 5 ~~ 1^..5,         '5 ~~ 1^..5';
ok 5.0 ~~ 1^..5,       '5.0 ~~ 1^..5';
ok 5.0e0 ~~ 1^..5,     '5.0e0 ~~ 1^..5';
nok 0 ~~ 1^..5,        'not 0 ~~ 1^..5';
nok 0.999 ~~ 1^..5,    'not 0.999 ~~ 1^..5';
nok 0.999e0 ~~ 1^..5,  'not 0.999e0 ~~ 1^..5';
nok 6 ~~ 1^..5,        'not 6 ~~ 1^..5';
nok 5.001 ~~ 1^..5,    'not 5.001 ~~ 1^..5';
nok 5.001e0 ~~ 1^..5,  'not 5.001e0 ~~ 1^..5';

ok 3 ~~ 1..^5,         '3 ~~ 1..^5';
ok 2.5 ~~ 1..^5,       '2.5 ~~ 1..^5';
ok 2.5e0 ~~ 1..^5,     '2.5e0 ~~ 1..^5';
ok 1 ~~ 1..^5,         '1 ~~ 1..^5';
ok 1.0 ~~ 1..^5,       '1.0 ~~ 1..^5';
ok 1.0e0 ~~ 1..^5,     '1.0e0 ~~ 1..^5';
nok 5 ~~ 1..^5,        'not 5 ~~ 1..^5';
nok 5.0 ~~ 1..^5,      'not 5.0 ~~ 1..^5';
nok 5.0e0 ~~ 1..^5,    'not 5.0e0 ~~ 1..^5';
nok 0 ~~ 1..^5,        'not 0 ~~ 1..^5';
nok 0.999 ~~ 1..^5,    'not 0.999 ~~ 1..^5';
nok 0.999e0 ~~ 1..^5,  'not 0.999e0 ~~ 1..^5';
nok 6 ~~ 1..^5,        'not 6 ~~ 1..^5';
nok 5.001 ~~ 1..^5,    'not 5.001 ~~ 1..^5';
nok 5.001e0 ~~ 1..^5,  'not 5.001e0 ~~ 1..^5';

ok 3 ~~ 1^..^5,         '3 ~~ 1^..^5';
ok 2.5 ~~ 1^..^5,       '2.5 ~~ 1^..^5';
ok 2.5e0 ~~ 1^..^5,     '2.5e0 ~~ 1^..^5';
nok 1 ~~ 1^..^5,        'not 1 ~~ 1^..^5';
nok 1.0 ~~ 1^..^5,      'not 1.0 ~~ 1^..^5';
nok 1.0e0 ~~ 1^..^5,    'not 1.0e0 ~~ 1^..^5';
nok 5 ~~ 1^..^5,        'not 5 ~~ 1^..^5';
nok 5.0 ~~ 1^..^5,      'not 5.0 ~~ 1^..^5';
nok 5.0e0 ~~ 1^..^5,    'not 5.0e0 ~~ 1^..^5';
nok 0 ~~ 1^..^5,        'not 0 ~~ 1^..^5';
nok 0.999 ~~ 1^..^5,    'not 0.999 ~~ 1^..^5';
nok 0.999e0 ~~ 1^..^5,  'not 0.999e0 ~~ 1^..^5';
nok 6 ~~ 1^..^5,        'not 6 ~~ 1^..^5';
nok 5.001 ~~ 1^..^5,    'not 5.001 ~~ 1^..^5';
nok 5.001e0 ~~ 1^..^5,  'not 5.001e0 ~~ 1^..^5';

# Tests which check to see if Range is properly doing numeric 
# comparisons for numbers.

ok 6 ~~ 5..21,          '6 ~~ 5..21';
ok 21 ~~ 3..50,         '21 ~~ 3..50';
nok 3 ~~ 11..50,        'not 3 ~~ 11..50';
nok 21 ~~ 1..5,         'not 21 ~~ 1..5';

ok 'c' ~~ 'b'..'g',     "'c' ~~ 'b'..'g'";
ok 'b' ~~ 'b'..'g',     "'b' ~~ 'b'..'g'";
ok 'g' ~~ 'b'..'g',     "'g' ~~ 'b'..'g'";
nok 'a' ~~ 'b'..'g',    "not 'a' ~~ 'b'..'g'";
nok 'h' ~~ 'b'..'g',    "not 'h' ~~ 'b'..'g'";
nok 0 ~~ 'a'..'g',      "not 0 ~~ 'a'..'g'";

ok 'd' ~~ 'c'..*,       "'d' ~~ 'c'..*";
nok 'b' ~~ 'c'..*,      "not 'b' ~~ 'c'..*";
ok 'b' ~~ *..'c',       "'b' ~~ *..'c'";
nok 'd' ~~ *..'c',      "not 'd' ~~ *..'c'";

# RT #75526: [BUG] Some non-alphanumeric ranges don't work
{
    ok ' ' ~~ ' '..' ', "' ' ~~ ' '..' '";
    ok ' ' ~~ ' '..'A', "' ' ~~ ' '..'A'";
}

ok (1 .. *).is-lazy, "1 .. * is lazy";
ok !(1 .. 2).is-lazy, "1 .. 2 is not lazy";

# vim: ft=perl6
