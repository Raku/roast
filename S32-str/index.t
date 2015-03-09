use v6;
use Test;

# L<S32::Str/Str/"=item index">

plan 38;

# Type of return value
#?rakudo 2 skip 'StrPos NYI'
#?niecza 2 skip 'StrPos'
isa_ok('abc'.index('b'), StrPos);
isa_ok('abc'.index('d'), StrPos);
ok(!'abc'.index('d'), 'failure object from index() evaluates to false');

# Simple - with just a single char

is(index("Hello World", "H"), 0, "One char, at beginning");
is(index("Hello World", "l"), 2, "One char, in the middle");
is(index("Hello World", "d"), 10, "One char, in the end");
ok(!defined(index("Hello World", "x")), "One char, no match");

is(index("Hello World", "l", 0), 2, "One char, find first match, pos = 0");
is(index("Hello World", "l", 2), 2, "- 1. match again, pos @ match");
is(index("Hello World", "l", 3), 3, "- 2. match");
is(index("Hello World", "l", 4), 9, "- 3. match");
ok(!defined(index("Hello World", "l", 10)), "- no more matches");

# Simple - with a string

is(index("Hello World", "Hello"), 0, "Substr, at beginning");
is(index("Hello World", "o W"), 4, "Substr, in the middle");
is(index("Hello World", "World"), 6, "Substr, at the end");
ok(!defined(index("Hello World", "low")), "Substr, no match");
is(index("Hello World", "Hello World"), 0, "Substr eq Str");

# Empty strings

is(index("Hello World", ""), 0, "Substr is empty");
is(index("", ""), 0, "Both strings are empty");
ok(!defined(index("", "Hello")), "Only main-string is empty");
is(index("Hello", "", 3), 3, "Substr is empty, pos within str");
is(index("Hello", "", 5), 5, "Substr is empty, pos at end of str");
nok(index("Hello", "", 999).defined, "Substr is empty, pos > length of str");

# More difficult strings

is(index("ababcabcd", "abcd"), 5, "Start-of-substr matches several times");

is(index("uuúuúuùù", "úuù"), 4, "Accented chars");
is(index("Ümlaut", "Ü"), 0, "Umlaut");


#  call directly with the .notation

is("Hello".index("l"), 2, ".index on string");

# work on variables

my $a = "word";
is($a.index("o"), 1, ".index on scalar variable");

my @a = <Hello World>;
is(index(@a[0], "l"), 2, "on array element");
is(@a[0].index("l"), 2, ".index on array element");

# index on junctions, maybe this should be moved to t/junctions/ ?

{
    my $j = ("Hello"|"World");
    ok(index($j, "l") == 2, "index on junction");
    ok(index($j, "l") == 3, "index on junction");
    ok($j.index("l")  == 2, ".index on junction");
    ok($j.index("l")  == 3, ".index on junction");
}

ok 1234.index(3) == 2, '.index on non-strings (here: Int)';

{
    my $s = '1023';
    is $s.substr($s.index('0')), '023', 'Str.index("0") works';
    is $s.substr($s.index(0)),   '023', 'Str.index(0) works';
}

# RT #73122
is index("uuúuúuùù", "úuù"), 4, 'index works for non-ascii';

# vim: ft=perl6
