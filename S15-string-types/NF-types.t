use v6;

use Test;

plan 10;

#### Tests both of the NFC and NFD types.

## NFC

# https://github.com/Raku/old-issue-tracker/issues/4136
#?rakudo 1 skip 'NFC quoting adverb NYI RT #124995'
{
    is q:nfc"ẛ̣".WHAT, NFC, ":nfc adverb on quoteforms produces NFC string type.";
    is "ẛ̣".NFC.WHAT, NFC, "Str literal can be converted to NFC.";

    my $NFC = q:nfc'ẛ̣';

    is $NFC.chars, 2, "NFC.chars returns number of codepoints.";
    is $NFC.codes, 2, "NFC.codes returns number of codepoints.";

    is $NFC.comb, <ẛ ̣>, "NFC correctly normalized ẛ̣";

    # note: more "correctly normalized" tests needed, esp. wrt correct order of
    # combining marks.
}

## NFD
# https://github.com/Raku/old-issue-tracker/issues/4137
#?rakudo 1 skip 'NFD quoting adverb NYI RT #124996'
{
    is q:nfd"ẛ̣".WHAT, NFD, ":nfd adverb on quoteforms produces NFD string type.";
    is "ẛ̣".NFD.WHAT, NFD, "Str literal can be converted to NFD.";

    my $NFD = q:nfd'ẛ̣';

    is $NFD.chars, 3, "NFD.chars returns number of codepoints.";
    is $NFD.codes, 3, "NFD.codes returns number of codepoints.";

    is $NFD.comb, <ſ ̣ ̇>, "NFD correctly normalized ẛ̣";
}

# vim: expandtab shiftwidth=4
