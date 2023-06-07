use Test;

plan 4;

is "ẛ̣".WHAT, Str, "Strings are of type Str by default.";
#?rakudo 1 skip ':nfg adverb NYI'
is qq:nfg/ẛ̣/.WHAT, Str, ":nfg adverb on quoteforms results in Str.";

#?rakudo.jvm todo "nqp::chars works on Java's chars: https://github.com/Raku/nqp/issues/783"
is "ẛ̣".chars, 1,  "Str.chars returns number of graphemes.";
is "ẛ̣".ord, 0x1E9B, "Str.ord returns first NFC codepoint for NFG grapheme";

# vim: expandtab shiftwidth=4
