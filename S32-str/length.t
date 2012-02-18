use v6;

use Test;

# L<S32::Str/Str/=item length>

=begin pod

Various length tests (though "length" should not be used)

Don't mismatch "length" with the "width" property for Unicode characters.

L<"http://www.unicode.org/unicode/reports/tr11/">

=end pod

plan 46;

eval_dies_ok('"moose".length', 'Str.length properly not implemented');

# string literals, for sanity

# L<S32::Str/Str/=item bytes>

# .bytes is under-specified and considered doubtful. 
# I am commenting out the .bytes tests in this file.
# See http://irclog.perlgeek.de/perl6/2011-12-23#i_4870398
#                                          --colomon
# is("".bytes,         0, "empty string");
# is("moose".bytes,    5, "moose");
# my $x = Nil;
# dies_ok { $x.bytes }, "undefined.bytes fail()s";
# See thread "undef.chars" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22595">

# L<S32::Str/Str/=item chars>

# Precedence tests
#?niecza 2 skip '"abcdef" > 4 makes niecza unhappy'
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

# L<S32::Str/Str/=item bytes>
# L<S32::Str/Str/=item chars>
# L<S32::Str/Str/=item codes>
# L<S32::Str/Str/=item graphs>

for @data -> $string, $bytes, $codes, $graphs, $chars {
    # is($string.bytes, $bytes, "'{$string}'.bytes");
    is($string.chars, $chars, "'{$string}'.chars");
    is($string.codes, $codes, "'{$string}'.codes");
    #?niecza skip ".graphs NYI"
    is($string.graphs, $graphs, "'{$string}'.graphs");
}

# test something with a codepoint above 0xFFFF to catch errors that an
# UTF-16 based implementation might make

is "\x[E0100]".codes,  1, '.codes on a >0xFFFF char'; # \c[VARIATION SELECTOR-17]
#?niecza skip ".graphs NYI"
is "\x[E0100]".graphs, 1, '.graphs on a >0xFFFF char'; # \c[VARIATION SELECTOR-17]

# test graphemes without a precomposed character in Unicode 5
#?rakudo 1 skip '.codes not implemented'
#?pugs todo
is "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]".codes, 2, '.codes on grapheme without precomposite';
#?rakudo 1 skip '.graphs not implemented'
#?niecza skip ".graphs NYI"
#?pugs todo
is "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]".graphs, 1, '.graphs on grapheme without precomposite';


# vim: ft=perl6
