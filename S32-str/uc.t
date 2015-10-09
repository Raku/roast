use v6;

use Test;

plan 19;

# L<S32::Str/"Str"/=item uc>

is(uc("Hello World"), "HELLO WORLD", "simple");
is(uc(""), "", "empty string");
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
#
#?niecza todo 'German language weirdness'
#?rakudo.moar todo 'case folding of German sharp S, RT #121377'
is(uc("ß"), "SS", "uc() of non-ascii chars may result in two chars");

{
    is("áéíöüóűőú".uc, "ÁÉÍÖÜÓŰŐÚ", ".uc on Hungarian vowels");
}

is ~(0.uc),         ~0, '.uc on Int';
is ~(0.tc),         ~0, '.tc on Int';
is ~(0.lc),         ~0, '.lc on Int';

#?DOES 3 
{
    role A {
        has $.thing = 3;
    }
    for <uc lc tc> -> $meth {
        my $str = "('Nothing much' but A).$meth eq 'Nothing much'.$meth";
        ok EVAL($str), $str;
    }
}

# There are a handful of chars that have a precomposed lowercase, but no
# precomposed uppercase. That is, NFC is sufficient for the lowercase to
# be an NFG string, but on uppercasing there's no way to represent it in
# NFC and so we need to produce a synthetic.
#?rakudo.jvm skip 'NFG'
{
    my $s = "\c[GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS]";
    is $s.uc, "\c[GREEK CAPITAL LETTER IOTA]\c[COMBINING DIAERESIS]\c[COMBINING ACUTE ACCENT]",
        "Correct uppercasing of char with no precomposed upper";
   is $s.uc.chars, 1, "Char with no precomposed upper gets NFG'd so upper is one grapheme";
}

# vim: ft=perl6
