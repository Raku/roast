use v6;
use Test;

my ($r, $p);
$p = -1; # starting index for pod number

plan 3;

# fix for GH #1852: pod handling converts non-breaking space to normal space
#
# from the issue description:
#
#   =head1 Talking about Perl 6
#   say "Talking about Perl 6".comb.map: *.ord;
#   say $=pod[0].contents[0].contents[0].comb.map: *.ord;
#

# Note the unicode hex number for some horizontal whitespace chars are
# (from docs, regexes):
#
#   U+0020 SPACE
#   U+00A0 NO-BREAK SPACE
#   U+0009 CHARACTER TABULATION
#   U+2001 EM QUAD
#
# To enter a unicode hex number using emacs: C-x 8 RET hex RET
=head1 Raku Language

$r = $=pod[++$p];

my @raw-chars = "Raku Language".comb;
my @pod-chars = $r.contents[0].contents[0].comb;
my $raw-char = @raw-chars[4];
my $pod-char = @pod-chars[4];
is $raw-char.ord.base(16), 'A0', 'non-breaking space as entered by the user';
is $pod-char.ord.base(16), 'A0', "user's non-breaking whitespace is unchanged by pod processing";
is $raw-char.ord.base(16), $pod-char.ord.base(16), "user's non-breaking white space is unchanged by pod processing";
