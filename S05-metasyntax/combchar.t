use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/combchar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 3;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
} else {

# L<S05/Extensible metasyntax (C<< <...> >>)/matches any logical grapheme>

my $unichar = "\c[GREEK CAPITAL LETTER ALPHA]";
my $combchar = "\c[LATIN CAPITAL LETTER A]\c[COMBINING ACUTE ACCENT]";

#?pugs todo 'feature'
ok("A" ~~ m/^<.>$/, 'ASCII');
ok($combchar ~~ m/^<.>$/, 'Unicode combining');
ok($unichar ~~ m/^<.>$/, 'Unicode');

}

