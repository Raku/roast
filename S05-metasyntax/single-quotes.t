use v6;
use Test;

=begin description

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/qinterp.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end description

plan 30;

# L<S05/Simplified lexical parsing of patterns/Sequences of one or more glyphs of either type>


ok("ab cd" ~~ m/a 'b c' d/, 'ab cd 1');
ok(!( "abcd" ~~ m/a 'b c' d/ ), 'not abcd 1');
ok("ab cd" ~~ m/ab ' ' c d/, 'ab cd 2');

ok 'abab' ~~ m/'ab' **2/, "Single quotes group";

ok("ab/cd" ~~ m/ab '/' c d/, 'ab/cd');
is("ab/cd" ~~ m/[\w+] +% '/'/, 'ab/cd', "Can use after %");


ok("ab cd" ~~ m/a ‘b c’ d/, 'ab cd 1');
ok(!( "abcd" ~~ m/a ‘b c’ d/ ), 'not abcd 1');
ok("ab cd" ~~ m/ab ‘ ’ c d/, 'ab cd 2');

ok 'abab' ~~ m/‘ab’ **2/, "Single quotes group";

ok("ab/cd" ~~ m/ab ‘/’ c d/, 'ab/cd');
is("ab/cd" ~~ m/[\w+] +% ‘/’/, 'ab/cd', "Can use after %");


ok("ab cd" ~~ m/a ‚b c’ d/, 'ab cd 1');
ok(!( "abcd" ~~ m/a ‚b c’ d/ ), 'not abcd 1');
ok("ab cd" ~~ m/ab ‚ ’ c d/, 'ab cd 2');

ok 'abab' ~~ m/‚ab’ **2/, "Single quotes group";

ok("ab/cd" ~~ m/ab ‚/’ c d/, 'ab/cd');
is("ab/cd" ~~ m/[\w+] +% ‚/’/, 'ab/cd', "Can use after %");


ok("ab cd" ~~ m/a ‚b c‘ d/, 'ab cd 1');
ok(!( "abcd" ~~ m/a ‚b c‘ d/ ), 'not abcd 1');
ok("ab cd" ~~ m/ab ‚ ‘ c d/, 'ab cd 2');

ok 'abab' ~~ m/‚ab‘ **2/, "Single quotes group";

ok("ab/cd" ~~ m/ab ‚/‘ c d/, 'ab/cd');
is("ab/cd" ~~ m/[\w+] +% ‚/‘/, 'ab/cd', "Can use after %");


ok("ab cd" ~~ m/a ｢b c｣ d/, 'ab cd 1');
ok(!( "abcd" ~~ m/a ｢b c｣ d/ ), 'not abcd 1');
ok("ab cd" ~~ m/ab ｢ ｣ c d/, 'ab cd 2');

ok 'abab' ~~ m/｢ab｣ **2/, "Single quotes group";

ok("ab/cd" ~~ m/ab ｢/｣ c d/, 'ab/cd');
is("ab/cd" ~~ m/[\w+] +% ｢/｣/, 'ab/cd', "Can use after %");

# vim: ft=perl6
