use v6.d;

use Test;

=begin pod

Basic tests for the ord() and chr() built-in.

=end pod

# L<S29/Conversions/ord>
# L<S29/Conversions/ords>
# L<S29/Conversions/chr>
# L<S29/Conversions/chrs>

# What is the best way to test 0 through 31??
my @maps = (
  " ",    32,
  "!",    33,
  '"',    34,
  "#",    35,
  '$',    36,
  "%",    37,
  "&",    38,
  "'",    39,
  "(",    40,
  ")",    41,
  "*",    42,
  "+",    43,
  ",",    44,
  "-",    45,
  ".",    46,
  "/",    47,
  "0",    48,
  "1",    49,
  "2",    50,
  "3",    51,
  "4",    52,
  "5",    53,
  "6",    54,
  "7",    55,
  "8",    56,
  "9",    57,
  ":",    58,
  ";",    59,
  "<",    60,
  "=",    61,
  ">",    62,
  "?",    63,
  "@",    64,
  "A",    65,
  "B",    66,
  "C",    67,
  "D",    68,
  "E",    69,
  "F",    70,
  "G",    71,
  "H",    72,
  "I",    73,
  "J",    74,
  "K",    75,
  "L",    76,
  "M",    77,
  "N",    78,
  "O",    79,
  "P",    80,
  "Q",    81,
  "R",    82,
  "S",    83,
  "T",    84,
  "U",    85,
  "V",    86,
  "W",    87,
  "X",    88,
  "Y",    89,
  "Z",    90,
  "[",    91,
  "\\",   92,
  "]",    93,
  "^",    94,
  "_",    95,
  "`",    96,
  "a",    97,
  "b",    98,
  "c",    99,
  "d",    100,
  "e",    101,
  "f",    102,
  "g",    103,
  "h",    104,
  "i",    105,
  "j",    106,
  "k",    107,
  "l",    108,
  "m",    109,
  "n",    110,
  "o",    111,
  "p",    112,
  "q",    113,
  "r",    114,
  "s",    115,
  "t",    116,
  "u",    117,
  "v",    118,
  "w",    119,
  "x",    120,
  "y",    121,
  "z",    122,
  '{',    123,
  "|",    124,
  '}',    125,
  "~",    126,

  # Unicode tests
  "ä",    228,
  "€",    8364,
  "»",    187,
  "«",    171,

  # Special chars
  "\o00", 0,
  "\o01", 1,
  "\o03", 3,
);

plan 55 + @maps;

for @maps -> $char, $code {
  my $descr = "\\{$code}{$code >= 32 ?? " == '{$char}'" !! ""}";
  is ord($char), $code, "ord() works for $descr";
  is chr($code), $char, "chr() works for $descr";
}

for 0...31 -> $code {
  my $char = chr($code);
  is ord($char), $code, "ord(chr($code)) is $code";
}

is ords('ABCDEFGHIJK'), '65 66 67 68 69 70 71 72 73 74 75', "ords() works as expected";
is chrs(65..75), 'ABCDEFGHIJK', "chrs() method works as expected";
is chrs(ords('ABCDEFGHIJK')), 'ABCDEFGHIJK', "chrs(ords()) round-trips correctly";
is ords(chrs(65..75)), '65 66 67 68 69 70 71 72 73 74 75', "ords(chrs()) round-trips correctly";

is 'A'.ord, 65, "there's a .ord method";
is 65.chr, 'A', "there's a .chr method";

is ('ABCDEFGHIJK').ords, '65 66 67 68 69 70 71 72 73 74 75', "there's a .ords method";
is (65..75).chrs, 'ABCDEFGHIJK', "there's a .chrs method";
is ('ABCDEFGHIJK').ords.chrs, 'ABCDEFGHIJK', "ords > chrs round-trips correctly";
is (65..75).chrs.ords, '65 66 67 68 69 70 71 72 73 74 75', "chrs > ords round-trips correctly";

is chrs(104, 101, 108, 108, 111), 'hello', 'chrs works with a list of ints';

#?rakudo todo 'chr surrogate RT #124834'
dies-ok {chr(0xD800)}, "chr of surrogate";
lives-ok {chr(0x2FFFE)}, "chr of noncharacter";
lives-ok {chr(0x2FFFF)}, "chr of noncharacter";
dies-ok {chr(0x10FFFF+1)}, "chr out of range (max)";
dies-ok {chr(-1)}, "chr out of range (negative)";

ok !defined(ord("")), 'ord("") returns an undefined value';

#?rakudo.jvm skip 'high character name lookup RT #124838'
is "\c[DROMEDARY CAMEL]".ord, 0x1F42A, "ord of named high character";
is chr(0x1F42A).ord, 0x1F42A, "chr > ord round trip of high character";

{
    #?rakudo.jvm todo 'NFG on JVM'
    is "\c[LATIN CAPITAL LETTER A, COMBINING DOT ABOVE]".ord, 550, '.ord gives first NFC codepoint (1)';
    is "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE]".ord, 550, '.ord gives first NFC codepoint (2)';
}

is chrs("104", "101", "108", "108", "111"), 'hello', 'chrs works with a list of numifiable strings';

# RT #130913
subtest 'chr with large codepoints throws useful error' => {
    my @tests = 'chr 2⁶³-1',   '(2⁶³-1).chr', 'chr 2⁶³',
                '2⁶³.chr',     'chr 2¹⁰⁰',    '(2¹⁰⁰).chr';
    plan +@tests;
    throws-like $_, Exception, .perl for @tests;
}

#vim: ft=perl6
