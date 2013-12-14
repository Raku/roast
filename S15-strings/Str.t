use v6;

use Test;

plan 5;

is "ẛ̣".WHAT, Str, "Strings are of type Str by default.";
#?rakudo 1 skip ':nfg adverb NYI'
#?niecza 1 skip ':nfg adverb NYI'
is qq:nfg/ẛ̣/.WHAT, Str, ":nfg adverb on quoteforms results in Str.";

is "ẛ̣".chars, 1,  "Str.chars returns number of graphemes.";
#?rakudo 1 skip 'Str.graphs NYI'
is "ẛ̣".graphs, 1, "Str.graphs returns number of graphemes.";
ok "ẛ̣".ord < 0, "Str.ord returns negative number for NFG grapheme.";
