use v6;

use Test;

plan 24;

# Unicode version pragma not needed here, as names cannot change.

# L<S15/Character Name>

#?niecza 24 skip "uniname NYI"

is uniname(0x30), "DIGIT ZERO",  "uniname returns a name";
is uniname("0"),  "DIGIT ZERO",  "uniname works in string form";
is uniname("नि"), uniname("न"), "string version of uniname converts to NFG strings to NFC";

is uniname("A"),        "LATIN CAPITAL LETTER A", "uniname() returns current Unicode name for graphic character.";
#?rakudo todo "RT #122470"
is uniname("\0"),       "<control-0000>",         "uniname() returns codepoint label for control character without a current name.";
is uniname("¶"),        "PILCROW SIGN",           "uniname() on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]"), "LINE SEPARATOR",         "uniname() returns current Unicode name for formatting character.";
#?rakudo todo "RT #122471"
is uniname("\x[80]"),   "<control-0080>",         "uniname() returns codepoint label for control character without any name.";

#?rakudo.moar 5 skip ":one NYI"
is uniname("A", :one),        "<graphic-0041>", "uniname(:one) returns non-standard codepoint label for graphic character without Unicode 1 name.";
is uniname("\0", :one),       "NULL",           "uniname(:one) returns Unicode 1 name for control character";
is uniname("¶", :one),        "PARAGRAPH SIGN", "uniname(:one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :one), "<format-2028>",  "uniname(:one) returns non-standard codepoint label for formatting character without Unicode 1 name.";
is uniname("\x[80]", :one),   "<control-0080>", "uniname(:one) returns codepoint label for control character without any name.";

#?rakudo.moar 5 skip ":either NYI"
is uniname("A", :either),        "LATIN CAPITAL LETTER A", "uniname(:either) returns current Unicode name for graphic character.";
is uniname("\0", :either),       "NULL",                   "uniname(:either) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either),        "PILCROW SIGN",           "uniname(:either) on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]", :either), "LINE SEPARATOR",         "uniname(:either) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either),   "<control-0080>",         "uniname(:either) returns codepoint label for control character without any name.";

#?rakudo.moar 5 skip ":either and :one NYI"
is uniname("A", :either :one),        "LATIN CAPITAL LETTER A", "uniname(:either :one) returns current Unicode name for graphic character.";
is uniname("\0", :either :one),       "NULL",                   "uniname(:either :one) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either :one),        "PARAGRAPH SIGN",         "uniname(:either :one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :either :one), "LINE SEPARATOR",         "uniname(:either :one) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either :one),   "<control-0080>",         "uniname(:either :one) returns codepoint label for control character without any name.";

#?rakudo skip "uninames NYI"
is uninames("AB"), ("LATIN CAPITAL LETTER A", "LATIN CAPITAL LETTER B"), "uninames correctly works on every character";
