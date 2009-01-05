use v6;

use Test;

# L<S29/Str/=item length>

=begin pod

Various length tests (though "length" should not be used)

This does not adequately test .chars, which is language dependent
and needs more careful tests.

L<"http://www.unicode.org/unicode/reports/tr11/">

=end pod

plan 57;

eval_dies_ok('"moose".length', 'Str.length properly not implemented');

# string literals, for sanity

# L<S29/Str/=item bytes>

#?rakudo 3 skip '.bytes not implemented'
is("".bytes,         0, "empty string");
is("moose".bytes,    5, "moose");
my $x = undef;
dies_ok { $x.bytes }, "undef.bytes fail()s";
# See thread "undef.chars" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22595">

# L<S29/Str/=item chars>

# Precedence tests
ok (chars "abcdef" > 4),     "chars() has the right precedence (1)";
is (chars("abcdef" > 4)), 0, "chars() has the right precedence (2)";

# and the real tests.

# Please add test strings in your favorite script, especially if
# it is boustrophedonic or otherwise interesting.
my @stringy = <@stringy>;
my @data = (
    # string            octets codepoints grapheme chars
    "",                      0,        0,         0,  0,
    "moose",                 5,        5,         5,  5,
    "møøse",                 7,        5,         5,  5,
    "C:\\Program Files",    16,       16,        16, 16,
    ~@stringy,               8,        8,         8,  8,
    "\x020ac \\x020ac",     11,        9,         9,  9,
    "בדיקה",                10,        5,         5,  5,
    "בדיקה 123",            14,        9,         9,  9,
    "rántottcsirke",        14,        13,       13, 13,
    "aáeéiíoóöőuúüű",       23,        14,       14, 14,
    "AÁEÉIÍOÓÖŐUÚÜŰ",       23,        14,       14, 14,
    "»«",                    4,         2,        2,  2,
    ">><<",                  4,         4,        4,  4,

);
#:map { my %hash; %hash<string bytes codes graphs> = $_; \%hash };

# L<S29/Str/=item bytes>
# L<S29/Str/=item chars>
# L<S29/Str/=item codes>
# L<S29/Str/=item graphs>

for @data -> $string, $bytes, $codes, $graphs, $chars {
    is($string.bytes, $bytes, "'{$string}'.bytes");
    is($string.chars, $chars, "'{$string}'.chars");
    is($string.codes, $codes, "'{$string}'.codes");
    is($string.graphs, $graphs, "'{$string}'.graphs");
}

# test something with a codepoint above 0xFFFF to catch errors that an
# UTF-16 based implementation might make

is '丽'.codes,  1, '.codes on a >0xFFFF char';
is '丽'.graphs, 1, '.graphs on a >0xFFFF char';

