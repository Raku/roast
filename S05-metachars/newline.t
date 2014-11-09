use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/newline.t.

=end pod

plan 15;

# L<S05/Changed metacharacters/"\n now matches a logical (platform independent) newline">

ok("\n" ~~ m/\n/, '\n');

ok("\o15\o12" ~~ m/\n/, 'CR/LF');
ok("\o12" ~~ m/\n/, 'LF');
ok("a\o12" ~~ m/\n/, 'aLF');
ok("\o15" ~~ m/\n/, 'CR');
ok("\x85" ~~ m/\n/, 'NEL');
ok("\x2028" ~~ m/\n/, 'LINE SEP');

ok(!( "abc" ~~ m/\n/ ), 'not abc');

ok(!( "\n" ~~ m/\N/ ), 'not \n');

ok(!( "\o12" ~~ m/\N/ ), 'not LF');
ok(!( "\o15\o12" ~~ m/\N/ ), 'not CR/LF');
ok(!( "\o15" ~~ m/\N/ ), 'not CR');
ok(!( "\x85" ~~ m/\N/ ), 'not NEL');
ok(!( "\x2028" ~~ m/\N/ ), 'not LINE SEP');

ok("abc" ~~ m/\N/, 'abc');


# vim: ft=perl6
