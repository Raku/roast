use v6;
use Test;

# L<S32::Str/Str/"=item index">

my $backend = $*RAKU.compiler.backend;

# Type of return value
isa-ok('abc'.index('b'), Int);
isa-ok('abc'.index('d'), Nil);

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

# https://github.com/Raku/old-issue-tracker/issues/1546
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

# index with negative start position not allowed
fails-like { index("xxy", "y", -1) }, X::OutOfRange,
  got => -1,
  'index with negative start position fails';

# https://github.com/Raku/old-issue-tracker/issues/4466
{
    for -1e34, -1e35 -> $pos {
        fails-like { index( 'xxy','y', $pos ) }, X::OutOfRange,
          got => $pos,
          "sub does $pos fails";
        fails-like { 'xxy'.index( 'y', $pos ) }, X::OutOfRange,
          got => $pos,
          "method does $pos fails";
    }
    for 1e34, 1e35 -> $pos {
        fails-like { index( 'xxy','y', $pos ) }, X::OutOfRange,
          got => $pos,
          "sub does $pos fails";
        fails-like { 'xxy'.index( 'y', $pos ) }, X::OutOfRange,
          got => $pos,
          "method does $pos fails";
    }
}

dies-ok { 42.index: Str }, "Cool.index with wrong args does not hang";

fails-like { "foo".substr-eq("o",-42) }, X::OutOfRange,
  "substr-eq with negative position fails";
fails-like { "foo".substr-eq("o",9999999999999999999999999999) }, X::OutOfRange,
  "substr-eq with very large positive position fails";

# tests with just lowercase and no markings
for
  ("foobara", "foobara".match(/\w+/)), (
    \("bar",3),   3,
    \("foobar"),  0,
    \("goo",2),   Nil,
    \("foobarx"), Nil,
    \(<a o>),       1,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku = invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \capture, \result {
            for (
              \(|capture, :!i),
              \(|capture, :!ignorecase),
              \(|capture, :!m),
              \(|capture, :!ignoremark),
              \(|capture, :!i, :!m),
              \(|capture, :!ignorecase, :!ignoremark),
              \(|capture, :i),
              \(|capture, :ignorecase),
              \(|capture, :m),
              \(|capture, :ignoremark),
              \(|capture, :i, :m),
              \(|capture, :ignorecase, :ignoremark),
            ) -> \c {
                if $backend eq "moar"            # MoarVM supports all
                  || !(c<m> || c<ignoremark>) {  # no support ignoremark
                    is-deeply invocant.index(|c), result,
                      "{invocantraku}.index{c.raku.substr(1)} is {result.gist}";
                    is-deeply index(invocant, |c), result,
                      "index({invocantraku}, {c.raku.substr(2,*-1)}) is {result.gist}";
                }
            }
        }
    }
}

# tests with uppercase and markings
for
  ("foöbÀra", "foöbÀra".match(/\w+/)), (
    \("bar", 3),                           Nil,
    \("bar", 3, :i),                       Nil,
    \("bar", "3", :ignorecase),            Nil,
    \("BAR", "3"),                         Nil,
    \("BÀR", 3, :i),                       3,
    \(<a o>, :i),                          1,
    \("BÀR", :ignorecase),                 3,
    \("bAr", "3", :m),                     3,
    \("bAr", "0", :ignoremark),            3,
    \("foobar"),                           Nil,
    \("foobar", :i),                       Nil,
    \("foobar", 0, :ignorecase),           Nil,
    \("foobar", "0", :m),                  Nil,
    \("foobar", :ignoremark),              Nil,
    \("foobar", "0", :i, :m),              0,
    \(<r a>, :i, :m),                      4,
    \("foobar", :ignorecase, :ignoremark), 0,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku = invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \c, \result {
            if $backend eq "moar"            # MoarVM supports all
              || !(c<m> || c<ignoremark>) {  # no support ignoremark
                is-deeply invocant.index(|c), result,
                  "{invocantraku}.index{c.raku.substr(1)} is {result.gist}";
                is-deeply index(invocant, |c), result,
                  "index({invocantraku}, {c.raku.substr(2,*-1)}) is {result.gist}";
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
