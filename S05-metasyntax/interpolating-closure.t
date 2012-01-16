use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/rulecode.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 6;

# L<S05/Extensible metasyntax (C<< <...> >>)/A leading & interpolates>

my regex abc { a b c }

my $var = "";
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block second');

$var = rx/<&abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{<.null>} }> cc/, 'Rule block first');

$var = rx/xyz/;
#?rakudo todo 'dunno'
#?niecza todo 'dunno'
ok("aaabccc" !~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block fail');

$var = rx/<&abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block interp');

# RT #102860
ok 'abc' ~~ /<{ '.+' }>/, 'interpolating string with meta characters';
is $/.Str, 'abc', '... gives the right match';

# vim: ft=perl6
