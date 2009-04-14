use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/rulecode.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 4;

regex abc { a b c } 

my $var = "";
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block second');

$var = rx/<.abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{<.null>} }> cc/, 'Rule block first');

$var = rx/xyz/;
ok("aaabccc" !~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block fail');

$var = rx/<.abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block interp');

# vim: ft=perl6
