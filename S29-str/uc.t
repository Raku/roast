use v6;

use Test;

plan 11;

# L<S29/"Str"/=item uc>

is(uc("Hello World"), "HELLO WORLD", "simple");
is(uc(""), "", "empty string");
#?rakudo skip "unicode"
#?DOES 3
{
    is(uc("åäö"), "ÅÄÖ", "some finnish non-ascii chars");
    is(uc("äöü"), "ÄÖÜ", "uc of German Umlauts");
    is(uc("óòúù"), "ÓÒÚÙ", "accented chars");
}
is(uc(lc('HELL..')), 'HELL..', "uc/lc test");

{
    $_ = "Hello World";
    my $x = .uc;
    is $x, "HELLO WORLD", 'uc uses the default $_';
}

{
    my $x = "Hello World";
    is $x.uc, "HELLO WORLD", '$x.uc works';
    is "Hello World".uc, "HELLO WORLD", '"Hello World".uc works';
}

## Bug: GERMAN SHARP S ("ß") should uc() to "SS", but it doesn't
## Compare with: perl -we 'use utf8; print uc "ß"'
# 
# XXX newest Unicode release has an upper-case ß codepoint - please
# clarify if this should be used instead. Commenting the test so far.
#
# Unicode 5.1.0 SpecialCasing.txt has 00DF -> 0053 0053
# nothing maps to 1E9E, the new "capital sharp s" 
# so I think this is right -rhr
#?rakudo skip "unicode"
#?DOES 1
is(uc("ß"), "SS", "uc() of non-ascii chars may result in two chars");

#?rakudo skip "unicode"
#?DOES 1
{
    is("áéíöüóűőú".uc, "ÁÉÍÖÜÓŰŐÚ", ".uc on Hungarian vowels");
}
