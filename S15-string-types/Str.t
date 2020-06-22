use v6;

use Test;

plan 4;

is "ẛ̣".WHAT, Str, "Strings are of type Str by default.";
#?rakudo 1 skip ':nfg adverb NYI'
is qq:nfg/ẛ̣/.WHAT, Str, ":nfg adverb on quoteforms results in Str.";

# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo.jvm todo "NFG on JVM"
is "ẛ̣".chars, 1,  "Str.chars returns number of graphemes.";
is "ẛ̣".ord, 0x1E9B, "Str.ord returns first NFC codepoint for NFG grapheme";

# vim: expandtab shiftwidth=4
