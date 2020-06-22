use v6;

use Test;

plan 48;

# Unicode version pragma not needed here, as names cannot change.

# L<S15/Character Name>

# https://github.com/Raku/old-issue-tracker/issues/3841
is uniname(""), Nil, "uniname an empty string yields Nil";
#?rakudo.jvm skip "Method 'NFC' not found for invocant of class 'Str'"
is uninames(""), (), "uninames an empty string yields an empty list";
is "".uniname, Nil, "''.uniname yields Nil";
#?rakudo.jvm skip "Method 'NFC' not found for invocant of class 'Str'"
is "".uninames, (), "''.uninames yields an empty list";
throws-like "uniname Str", X::Multi::NoMatch, 'cannot call uniname with a Str';
throws-like "Str.uniname", X::Multi::NoMatch, 'cannot call uniname with a Str';
throws-like "uniname Int", X::Multi::NoMatch, 'cannot call uniname with a Int';
throws-like "Int.uniname", X::Multi::NoMatch, 'cannot call uniname with a Int';

# method forms
is 0x30.uniname, "DIGIT ZERO",  "method uniname returns a name";
is "0".uniname,  "DIGIT ZERO",  "method uniname works in string form";


is uniname(0x30), "DIGIT ZERO",  "uniname returns a name";
is uniname("0"),  "DIGIT ZERO",  "uniname works in string form";
is uniname("नि"), uniname("न"), "string version of uniname converts to NFG strings to NFC";

is uniname("A"), "LATIN CAPITAL LETTER A",
  "uniname() returns current Unicode name for graphic character.";
# https://github.com/Raku/old-issue-tracker/issues/3472
is uniname("\0"), "<control-0000>",
  "uniname() returns codepoint label for control character without a current name.";
is uniname("¶"), "PILCROW SIGN", 
  "uniname() on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]"), "LINE SEPARATOR", 
  "uniname() returns current Unicode name for formatting character.";
# https://github.com/Raku/old-issue-tracker/issues/3473
is uniname("\x[80]"), "<control-0080>",
  "uniname() returns codepoint label for control character without any name.";

#?rakudo 5 skip ":one NYI"
is uniname("A", :one), "<graphic-0041>",
  "uniname(:one) returns non-standard codepoint label for graphic character without Unicode 1 name.";
is uniname("\0", :one), "NULL", 
  "uniname(:one) returns Unicode 1 name for control character";
is uniname("¶", :one), "PARAGRAPH SIGN",
  "uniname(:one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :one), "<format-2028>", 
  "uniname(:one) returns non-standard codepoint label for formatting character without Unicode 1 name.";
is uniname("\x[80]", :one), 
  "<control-0080>", "uniname(:one) returns codepoint label for control character without any name.";

# https://github.com/Raku/old-issue-tracker/issues/4196
#?rakudo 5 skip ":either NYI"
is uniname("A", :either), "LATIN CAPITAL LETTER A",
  "uniname(:either) returns current Unicode name for graphic character.";
is uniname("\0", :either), "NULL", 
  "uniname(:either) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either), "PILCROW SIGN", 
  "uniname(:either) on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]", :either), "LINE SEPARATOR", 
  "uniname(:either) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either), "<control-0080>", 
  "uniname(:either) returns codepoint label for control character without any name.";

# https://github.com/Raku/old-issue-tracker/issues/4198
#?rakudo 5 skip ":either and :one NYI"
is uniname("A", :either :one), "LATIN CAPITAL LETTER A",
  "uniname(:either :one) returns current Unicode name for graphic character.";
is uniname("\0", :either :one), "NULL", 
  "uniname(:either :one) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either :one), "PARAGRAPH SIGN",
  "uniname(:either :one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :either :one), "LINE SEPARATOR", 
  "uniname(:either :one) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either :one), "<control-0080>", 
  "uniname(:either :one) returns codepoint label for control character without any name.";

# https://github.com/Raku/old-issue-tracker/issues/3749
is uniname(-1), '<illegal>', "uniname with negative returns <illegal> (1)";
is uniname(-5), '<illegal>', "uniname with negative returns <illegal> (2)";
is uniname(0x110000), '<unassigned>', "uniname too high returns <unassigned> (1)";
is uniname(0x210000), '<unassigned>', "uniname too high returns <unassigned> (2)";

# https://github.com/Raku/old-issue-tracker/issues/3841
#?rakudo.jvm 2 skip "Method 'NFC' not found for invocant of class 'Str'"
is uninames("AB"), ("LATIN CAPITAL LETTER A", "LATIN CAPITAL LETTER B"), "uninames correctly works on every character";
is "AB".uninames, ("LATIN CAPITAL LETTER A", "LATIN CAPITAL LETTER B"), "uninames correctly works on every character";

is uniname("🦋"), "BUTTERFLY", "Can resolve Unicode 9 character name";

#?rakudo.jvm todo "HANGUL SYLLABLES D4DB"
is-deeply 0xD4DB.uniname, "HANGUL SYLLABLE PWILH", "Supports composed Hangul Syllable names";
#?rakudo.jvm todo "CJK UNIFIED IDEOGRAPHS 4FFE"
is-deeply 0x4FFE.uniname, "CJK UNIFIED IDEOGRAPH-4FFE", "U+4FFE is 'CJK UNIFIED IDEOGRAPH-4FFE>";
# Tests all noncharacters as well as makes sure the codepoints before and after those ranges are not
# erronerously set as noncharacters
subtest "Noncharacters" => {
    plan 98;
    for 0xFDD0..0xFDEF {
        ok $_.uniname.starts-with('<noncharacter'), 'nonchar';
    }
        nok (0xFDD0 -1).uniname.starts-with('<noncharacter'), "codepoint below U+FDD0 is not a noncharacter";
        nok (0xFDEF +1).uniname.starts-with('<noncharacter'), "codepoint after U+FDEF is not a noncharacter";
    my Int:D $up = 0x10000;
    my Int:D $value = $up;
    while $value <= 0x10FFFF {
        my Int:D $val = 0xFFFD + $value;
        nok ($val).uniname.starts-with('<noncharacter'), "U+$val.base(16) is a not a noncharacter";
        $val++;
        ok ($val).uniname.starts-with('<noncharacter'), "U+$val.base(16) is a noncharacter";
        $val++;
        ok ($val).uniname.starts-with('<noncharacter'), "U+$val.base(16) is a noncharacter";
        $val++;
        nok ($val).uniname.starts-with('<noncharacter'), "U+$val.base(16) is a not a noncharacter";
        $value += $up;
    }
}
is-deeply 0x10FFFF.uniname, "<noncharacter-10FFFF>", "0x10FFFF is <noncharacter-10FFFF>";
is-deeply 0x110000.uniname, "<unassigned>", "Codepoints higher than 0x10FFFF return <unassigned>";
is-deeply 0x150000.uniname, "<unassigned>", "Codepoints higher than 0x10FFFF return <unassigned>";
is-deeply 0x0378.uniname, "<reserved-0378>", "Unassigned codepoints below 0x10FFFF return <reserved-XXXX>";
is-deeply (-0x20).uniname, "<illegal>", "Codepoints lower than 0x0 return <illegal>";

# vim: expandtab shiftwidth=4
