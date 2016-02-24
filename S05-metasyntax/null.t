use v6.c;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/null.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 4;

# L<S05/Nothing is illegal/To match the zero-width string, use>

ok("" ~~ m/<?>/, 'Simple null as <?>');
ok("" ~~ m/''/, "Simple null as ''");
ok("a" ~~ m/<?>/, 'Simple null A');

ok("ab" ~~ m{a<?>b}, 'Compound null AB');

# vim: ft=perl6
