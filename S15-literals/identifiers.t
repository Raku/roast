# S15-literals/identifiers.t --- tests Unicode (namely non-ASCII) identifiers

use Test;

plan 7;

# tests that the proper characters are supported
eval-lives-ok('my $foo', "Handles ASCII identifier");
eval-lives-ok('my $ｆｏｏ', "Handles non-ASCII identifier");
eval-dies-ok('my $১০kinds', "Doesn't allow non-ASCII digits at start of identifier");

eval-dies-ok('my $̈a;', "Combining marks not allowed as first character of identifier");

my $ẛ̣ = 42; # LATIN SMALL LETTER LONG S WITH DOT ABOVE + COMBINING DOT BELOW

# this reference is spelled in source as LATIN SMALL LETTER LONG S + COMBINING
# DOT ABOVE + COMBINING DOT BELOW
is $ẛ̣, 42, "Identifiers are normalized";

# XXX it would be nice to test for NFG normalization, but since .name returns a
# Str (which is in NFG), there's no way you can test through that. Test left
# here, commented out, in case a way to test this does come up in the future.
#is $ẛ̣.VAR.name.chars, 2, "Identifiers are normalized to NFG";

# these two tests make sure normalization goes source -> NFD -> NFC -> NFG, that
# is no occurence of NFKD or NFKC in the process (note that the -> NFD step is a
# part of normalizing to NFC, it's spelled out here just for clarity)

my $ﬁ = True;
my $fi = False;

is $fi, False, "Identifiers are not put through compatability decomposition";
is $ﬁ, True, "Identifiers are not put through compatability decomposition";
