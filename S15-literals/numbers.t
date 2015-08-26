# S15-literals/numbers.t --- test Unicode (namely non-ASCII) numerals

use Test;

plan 41;

# basic test of literals
#?rakudo.jvm 2 skip "is not a valid number"
is ໑໐, 10, "Can use non-ASCII numbers";
is 10, ໑໐, "Can use non-ASCII numbers";

# expression tests
#?rakudo.jvm 3 skip "is not a valid number"
is ٢ * ٤٢, 84, "Non-ASCII numbers can be used in expressions";
is 42 + ٤٢, 84, "Non-ASCII numbers can be mixed with ASCII numbers";
is 42 * 2, ٨٤, "ASCII-only expression can be succesfully compared to non-ASCII number";

# mixed numbers
#?rakudo.jvm 2 skip "is not a valid number"
is ᱄2, 42, "Can mix scripts in one number";
is 4᱂, 42, "Can mix scripts in one number";

# check that only Nd characters are allowed
# XXX might want to check for a specific exception at some point?
eval-dies-ok("say ↈ;", "Numerals in category 'Nl' not allowed as numeric literal");
eval-dies-ok("say 𒐀", "Numerals in category 'Nl' not allowed as numeric literal, even if its value is an integer within the range 0..9");
eval-dies-ok("say ፼", "Numerals in category 'No' not allowed as numeric literal");
eval-dies-ok("say ⓿", "Numerals in category 'No' not allowed as numeric literal, even if its value is an integer within the range 0..9");

# other radices

# binary
is 0b101010, 42, "ASCII binary literals work";
#?rakudo.jvm 2 skip "Confused"
is 0b༡༠༡༠༡༠, 42, "Non-ASCII binary literals work";
is 0b༡༠༡010, 42, "Binary literals with a mixture of scripts work";
eval-dies-ok("say 0b¹0", "Numerals in category 'No' can't be used in binary literals");
eval-dies-ok("say 0b1〇", "Numerals in category 'Nl' can't be used in binary literals");

# octal
is 0o755, 493, "ASCII octal literals work";
#?rakudo.jvm 2 skip "Confused"
is 0o᠗᠕᠕, 493, "Non-ASCII octal literals work";
is 0o᠗5᠕, 493, "Octal literals with a mixture of scripts work";
eval-dies-ok("say 0o7₅₅", "Numerals in category 'No' can't be used in octal literals");
eval-dies-ok("say 0oⅦ55", "Numerals in category 'Nl' can't be used in octal literals");

# hexadecimal
is 0x42, 66, "ASCII hexadecimal literals work";
#?rakudo.jvm 2 skip "Confused"
is 0x๔๒, 66, "Non-ASCII hexadecimal literals work";
is 0x๔2, 66, "Hexadecimal literals with a mixture of scripts work";
eval-dies-ok("say 0x④2", "Numerals in category 'No' can't be used in hexadecimal literals");
eval-dies-ok("say 0x4〢", "Numerals in category 'Nl' can't be used in hexadecimal literals");

is 0xCAFE, 51966, "Uppercase ASCII letters work in hexadecimal literals";
is 0xcafe, 51966, "Lowercase ASCII letters work in hexadecimal literals";
#?rakudo.jvm 3 skip "Confused"
is 0xＣＡＦＥ, 51966, "Uppercase fullwidth letters work in hexadecimal literals";
is 0xｃａｆｅ, 51966, "Lowercase fullwidth letters work in hexadecimal literals";
is 0xCaＦｅ, 51966, "Valid Hex_Digit characters from different scripts can be mixed in hexadecimal literals";
eval-dies-ok("say 0xΓαfe", "Can't use characters without true Hex_Digit properties in hexadecimal literals");
eval-dies-ok("say 0xCAF⒕", "Numerals in category 'No' can't be used in hexadecimal literals");
eval-dies-ok("say 0xC𐏓FE", "Numerals in category 'Nl' can't be used in hexadecimal literals");

# generic radices
is :36<Unicodez>, 2402100600299, "ASCII letters work in general radix numbers";
#?rakudo.jvm 2 skip "Malformed radix number"
is :36<Ｕｎｉｃｏｄｅｚ>, 2402100600299, "Fullwidth letters work in general radix numbers";
is :36<Ｕｎｉcodeｚ>, 2402100600299, "Mixture of ASCII and fullwidth letters work in general radix numbers";
eval-dies-ok("say :36<αω>", "Scripts without Hex_Digit characters not allowed in general radix numbers");

#?rakudo.jvm 1 skip "Malformed radix number"
is :36<utf១៦>, 51760986, "Nd numerals can be used in general radix numbers";
eval-dies-ok("say :36<utfⅧ>", "Nl numerals are not allowed in general radix numbers");
eval-dies-ok("say :36<utf㉜>", "No numerals are not allowed in general radix numbers");
