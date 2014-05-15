use v6;

use Test;
use lib 't/spec/packages';
use Test::Util;

plan 140;

{
    my $range = 2..6;
    isa_ok $range, Range, '2..6 is a Range';
    is $range.min, 2, "2..6.min is 2";
    is $range.max, 6, "2..6.max is 6";
    is $range.excludes_min, Bool::False, "2..6.excludes_min is false";
    is $range.excludes_max, Bool::False, "2..6.excludes_max is false";
    is $range.perl, "2..6", '.perl is correct';
}

{
    my $range = -1^..7;
    isa_ok $range, Range, '-1^..7 is a Range';
    is $range.min, -1, "-1^..7.min is -1";
    is $range.max, 7, "-1^..7.max is 7";
    is $range.excludes_min, Bool::True, "-1^..7.excludes_min is true";
    is $range.excludes_max, Bool::False, "-1^..7.excludes_max is false";
    is $range.perl, "-1^..7", '.perl is correct';
}

{
    my $range = 3..^-1;
    isa_ok $range, Range, '3..^-1 is a Range';
    is $range.min, 3, "3..^-1.min is 3";
    is $range.max, -1, "3..^-1.max is -1";
    is $range.excludes_min, Bool::False, "3..^-1.excludes_min is false";
    is $range.excludes_max, Bool::True, "3..^-1.excludes_max is true";
    is $range.perl, "3..^-1", '.perl is correct';
}

{
    my $range = 'a'^..^'g';
    isa_ok $range, Range, "'a'^..^'g' is a Range";
    is $range.min, 'a', "'a'^..^'g'.min is 'a'";
    is $range.max, 'g', "'a'^..^'g'.max is 'g'";
    is $range.excludes_min, Bool::True, "'a'^..^'g'.excludes_min is true";
    is $range.excludes_max, Bool::True, "'a'^..^'g'.excludes_max is true";
    is $range.perl, '"a"^..^"g"', '.perl is correct';
}

{
    my $range = ^5;
    isa_ok $range, Range, '^5 is a Range';
    is $range.min, 0, "^5.min is 0";
    is $range.max, 5, "^5.max is 5";
    is $range.excludes_min, Bool::False, "^5.excludes_min is false";
    is $range.excludes_max, Bool::True, "^5.excludes_max is true";
    is $range.perl, "0..^5", '.perl is correct';
}

{
    my $range = ^5.5;
    isa_ok $range, Range, '^5.5 is a Range';
    is $range.min, 0, "^5.5.min is 0";
    is $range.max, 5.5, "^5.5.max is 5.5";
    is $range.excludes_min, Bool::False, "^5.5.excludes_min is false";
    is $range.excludes_max, Bool::True, "^5.5.excludes_max is true";
}

{
    my $range = ^5.5e0;
    isa_ok $range, Range, '^5.5e0 is a Range';
    is $range.min, 0, "^5.5e0.min is 0";
    is $range.max, 5.5e0, "^5.5e0.max is 5.5e0";
    is $range.excludes_min, Bool::False, "^5.5e0.excludes_min is false";
    is $range.excludes_max, Bool::True, "^5.5e0.excludes_max is true";
}

{
    my $range = 1..*;
    isa_ok $range, Range, '1..* is a Range';
    is $range.min, 1, "1..*.min is 1";
    is $range.max, Inf, "1..*.max is Inf";
    is $range.excludes_min, Bool::False, "1..*.excludes_min is false";
    is $range.excludes_max, Bool::False, "1..*.excludes_max is false";
}

# next three blocks of tests may seem kind of redundant, but actually check that 
# the various Range operators are not mistakenly turned into Whatever
# closures.

{
    my $range = 1^..*;
    isa_ok $range, Range, '1^..* is a Range';
    is $range.min, 1, "1^..*.min is 1";
    is $range.max, Inf, "1^..*.max is Inf";
    is $range.excludes_min, Bool::True, "1^..*.excludes_min is true";
    is $range.excludes_max, Bool::False, "1^..*.excludes_max is false";
}

{
    my $range = *..^1;
    isa_ok $range, Range, '*..^1 is a Range';
    is $range.min, -Inf, "*..^1.min is -Inf";
    is $range.max, 1, "*..^1.max is 1";
    is $range.excludes_min, Bool::False, "*..^1.excludes_min is false";
    is $range.excludes_max, Bool::True, "*..^1.excludes_max is true";
}

{
    my $range = 1^..^*;
    isa_ok $range, Range, '1^..^* is a Range';
    is $range.min, 1, "1^..^*.min is 1";
    is $range.max, Inf, "1^..^*.max is Inf";
    is $range.excludes_min, Bool::True, "1^..^*.excludes_min is true";
    is $range.excludes_max, Bool::True, "1^..^*.excludes_max is true";
}

# some range constructions are invalid
#?niecza skip "No exceptions"
#?DOES 8
{
    throws_like '10 .. ^20', X::Range::InvalidArg ;
    throws_like '^10 .. 20', X::Range::InvalidArg ;
    throws_like '* .. ^20',  X::Range::InvalidArg ;
    throws_like '^10 .. *',  X::Range::InvalidArg ;
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

# RT#75526: [BUG] Some non-alphanumeric ranges don't work
{
    ok ' ' ~~ ' '..' ', "' ' ~~ ' '..' '";
    ok ' ' ~~ ' '..'A', "' ' ~~ ' '..'A'";
}

done;

# vim: ft=perl6
