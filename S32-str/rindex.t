use v6;
use Test;

# L<S32::Str/Str/"=item rindex">

plan 43;

# Type of return value
isa-ok('abc'.rindex('b'), Int);
isa-ok('abc'.rindex('d'), Nil);

# Simple - with just a single char

is(rindex("Hello World", "H"), 0, "One char, at beginning");
is(rindex("Hello World", "l"), 9, "One char, in the middle");
is(rindex("Hello World", "d"), 10, "One char, in the end");
ok(!defined(rindex("Hello World", "x")), "One char, no match");

is(rindex("Hello World", "l", 10), 9, "One char, first match, pos @ end");
is(rindex("Hello World", "l", 9), 9, "- 1. match again, pos @ match");
is(rindex("Hello World", "l", 8), 3, "- 2. match");
is(rindex("Hello World", "l", 2), 2, "- 3. match");
ok(!defined(rindex("Hello World", "l", 1)), "- no more matches");

# Simple - with a string

is(rindex("Hello World", "Hello"), 0, "Substr, at beginning");
is(rindex("Hello World", "o W"), 4, "Substr, in the middle");
is(rindex("Hello World", "World"), 6, "Substr, at the end");
ok(!defined(rindex("Hello World", "low")), "Substr, no match");
is(rindex("Hello World", "Hello World"), 0, "Substr eq Str");

# Empty strings

is(rindex("Hello World", ""), 11, "Substr is empty");
is(rindex("", ""), 0, "Both strings are empty");
ok(!defined(rindex("", "Hello")), "Only main-string is empty");
is(rindex("Hello", "", 3), 3, "Substr is empty, pos within str");
is(rindex("Hello", "", 5), 5, "Substr is empty, pos at end of str");
nok(rindex("Hello", "", 999).defined, "rindex where pos > length of str return undefined");

# More difficult strings

is(rindex("abcdabcab", "abcd"), 0, "Start-of-substr matches several times");
is(rindex("uuúuúuùù", "úuù"), 4, "Accented chars");
is(rindex("Ümlaut", "Ü"), 0, "Umlaut");
is(rindex("what are these « » unicode characters for ?", "uni"), 19, "over unicode characters");

# .rindex use
is("Hello World".rindex("l"), 9, ".rindex on string");
is("Hello World".rindex(''), 11, ".rindex('') on string gives string length graphemes");

# on scalar variable
my $s = "Hello World";
is(rindex($s, "o"), 7, "rindex on scalar variable");
is($s.rindex("o"), 7, ".rindex on scalar variable");

is(rindex(uc($s), "O"), 7, "rindex on uc");
is($s.uc.rindex("O"), 7, ".uc.rindex ");

# ideas for deeper chained . calls ?
is($s.lc.tc.rindex("w"), 6, ".lc.tc.rindex");

# rindex on non-strings
ok 3459.rindex(5) == 2, 'rindex on integers';

# RT #112818
is "\x261b perl \x261a".rindex('e'), 3, 'rindex with non-latin-1 strings';


# RT #125784
{
    for -1e34, -1e35, 1e34, 1e35 -> $pos {
        is rindex( 'xxy','y', $pos ), Nil, "sub does $pos give Nil";
        is 'xxy'.rindex( 'y', $pos ), Nil, "method does $pos give Nil";
    }
}

# vim: ft=perl6
