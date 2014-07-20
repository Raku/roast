use v6;

use Test;

plan 13;

# L<S32::Str/Str/lc>

is(lc("hello world"), "hello world", "lowercasing string which is already lowercase");
is(lc("Hello World"), "hello world", "simple lc test");
is(lc(""), "", "empty string");
is(lc("ÅÄÖ"), "åäö", "some finnish non-ascii chars");
is(lc("ÄÖÜ"), "äöü", "lc of German Umlauts");
is(lc("ÓÒÚÙ"), "óòúù", "accented chars");
is(lc('A'..'C'), "a b c", "lowercasing char-range");

{
    $_ = "Hello World";
    my $x = .lc;
    is($x, "hello world", 'lc uses $_ as default');
}

{ # test invocant syntax for lc
    my $x = "Hello World";
    is($x.lc, "hello world", '$x.lc works');
    is($x, 'Hello World', 'Invocant unchanged');
    is("Hello World".lc, "hello world", '"Hello World".lc works');
}

is("ÁÉÍÖÜÓŰŐÚ".lc, "áéíöüóűőú", ".lc on Hungarian vowels");

# https://en.wikipedia.org/wiki/Title_case#Special_cases
# "The Greek letter Σ has two different lowercase forms: "ς" in word-final
# position and "σ" elsewhere."

#?niecza todo 'advanced Unicode wizardry'
#?rakudo.moar todo 'case folding, MoarVM #87'
is 'ΣΣΣ'.lc, 'σσς', 'lower-casing of greek Sigma respects word-final special case';

# vim: ft=perl6
