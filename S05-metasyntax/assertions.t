use v6;

use Test;

plan 4;

# L<S05/"Extensible metasyntax (C<< <...> >>)"/indicates a code assertion:>

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/assert.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

ok("1"       ~~ m/ (\d) <?{$0 < 5}> /,           '1 < 5');
ok("5"      !~~ m/ (\d) <?{$/[*-1] < 5}>/,       '5 !< 5');

ok("x254"    ~~ m/x (\d+): <?{$/[*-1] < 255}> /, '254 < 255');
ok("x255"   !~~ m/x (\d+): <?{$/[*-1] < 255}> /, '255 !< 255');

# vim: ft=perl6
