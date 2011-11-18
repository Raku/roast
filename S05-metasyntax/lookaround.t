use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/lookaround.t.

=end pod

plan 10;

#?pugs emit force_todo(1,4,9,10);

# L<S05/Extensible metasyntax (C<< <...> >>)/The special named assertions include:>

#?rakudo 4 skip 'after NYI'
ok("a cdef" ~~ m/<after a <.ws> c> def/, 'Lookbehind');
ok(!( "acdef" ~~ m/<after a <.ws> c> def/ ), 'Lookbehind failure');
ok(!( "a cdef" ~~ m/<!after a <.ws> c> def/ ), 'Negative lookbehind failure');
ok("acdef" ~~ m/<!after a <.ws> c> def/, 'Negative lookbehind');

ok("abcd f" ~~ m/abc <before d <.ws> f> (.)/, 'Lookahead');
is(~$0, 'd', 'Verify lookahead');
ok(!( "abcdef" ~~ m/abc <before d <.ws> f>/ ), 'Lookahead failure');
ok(!( "abcd f" ~~ m/abc <!before d <.ws> f>/ ), 'Negative lookahead failure');
ok("abcdef" ~~ m/abc <!before d <.ws> f> (.)/, 'Negative lookahead');
is(~$0, 'd', 'Verify negative lookahead');


# vim: ft=perl6
