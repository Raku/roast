use v6.c;

use Test;

plan 39;

# Unicode version pragma not needed here, as names cannot change.

# L<S15/Character Name>

is uniname(""), Nil, "uniname an empty string yields Nil";
#?rakudo.jvm skip "Method 'NFC' not found for invocant of class 'Str' RT #124500"
is uninames(""), (), "uninames an empty string yields an empty list";
is "".uniname, Nil, "''.uniname yields Nil";
#?rakudo.jvm skip "Method 'NFC' not found for invocant of class 'Str' RT #124500"
is "".uninames, (), "''.uninames yields an empty list";
throws-like "uniname Str", X::Multi::NoMatch, 'cannot call uniname with a Str';
throws-like "Str.uniname", X::Multi::NoMatch, 'cannot call uniname with a Str';
throws-like "uniname Int", X::Multi::NoMatch, 'cannot call uniname with a Int';
throws-like "Int.uniname", X::Multi::NoMatch, 'cannot call uniname with a Int';

# method forms
#?niecza 2 skip "uniname NYI"
is 0x30.uniname, "DIGIT ZERO",  "method uniname returns a name";
is "0".uniname,  "DIGIT ZERO",  "method uniname works in string form";

#?niecza 24 skip "uniname NYI"

is uniname(0x30), "DIGIT ZERO",  "uniname returns a name";
is uniname("0"),  "DIGIT ZERO",  "uniname works in string form";
is uniname("नि"), uniname("न"), "string version of uniname converts to NFG strings to NFC";

is uniname("A"),        "LATIN CAPITAL LETTER A", "uniname() returns current Unicode name for graphic character.";
is uniname("\0"),       "<control-0000>",         "uniname() returns codepoint label for control character without a current name.";
is uniname("¶"),        "PILCROW SIGN",           "uniname() on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]"), "LINE SEPARATOR",         "uniname() returns current Unicode name for formatting character.";
is uniname("\x[80]"),   "<control-0080>",         "uniname() returns codepoint label for control character without any name.";

#?rakudo 5 skip ":one NYI RT #125069"
is uniname("A", :one),        "<graphic-0041>", "uniname(:one) returns non-standard codepoint label for graphic character without Unicode 1 name.";
is uniname("\0", :one),       "NULL",           "uniname(:one) returns Unicode 1 name for control character";
is uniname("¶", :one),        "PARAGRAPH SIGN", "uniname(:one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :one), "<format-2028>",  "uniname(:one) returns non-standard codepoint label for formatting character without Unicode 1 name.";
is uniname("\x[80]", :one),   "<control-0080>", "uniname(:one) returns codepoint label for control character without any name.";

#?rakudo 5 skip ":either NYI RT #125070"
is uniname("A", :either),        "LATIN CAPITAL LETTER A", "uniname(:either) returns current Unicode name for graphic character.";
is uniname("\0", :either),       "NULL",                   "uniname(:either) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either),        "PILCROW SIGN",           "uniname(:either) on character with current & Unicode 1 name returns current name.";
is uniname("\x[2028]", :either), "LINE SEPARATOR",         "uniname(:either) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either),   "<control-0080>",         "uniname(:either) returns codepoint label for control character without any name.";

#?rakudo 5 skip ":either and :one NYI RT #one NYI RT#:125071"
is uniname("A", :either :one),        "LATIN CAPITAL LETTER A", "uniname(:either :one) returns current Unicode name for graphic character.";
is uniname("\0", :either :one),       "NULL",                   "uniname(:either :one) returns Unicode 1 name for control character without a current name.";
is uniname("¶", :either :one),        "PARAGRAPH SIGN",         "uniname(:either :one) on character with current & Unicode 1 name returns Unicode 1 name.";
is uniname("\x[2028]", :either :one), "LINE SEPARATOR",         "uniname(:either :one) returns current Unicode name for formatting character.";
is uniname("\x[80]", :either :one),   "<control-0080>",         "uniname(:either :one) returns codepoint label for control character without any name.";

# RT #124144
is uniname(-1), '<illegal>', "uniname with negative returns <illegal> (1)";
is uniname(-5), '<illegal>', "uniname with negative returns <illegal> (2)";
is uniname(0x110000), '<unassigned>', "uniname too high returns <unassigned> (1)";
is uniname(0x210000), '<unassigned>', "uniname too high returns <unassigned> (2)";

#?rakudo.jvm 2 skip "Method 'NFC' not found for invocant of class 'Str' RT #124500"
is uninames("AB"), ("LATIN CAPITAL LETTER A", "LATIN CAPITAL LETTER B"), "uninames correctly works on every character";
is "AB".uninames, ("LATIN CAPITAL LETTER A", "LATIN CAPITAL LETTER B"), "uninames correctly works on every character";
