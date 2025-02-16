use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/lookaround.t.

=end pod

plan 15;

# L<S05/Extensible metasyntax (C<< <...> >>)/The special named assertions include:>

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

# https://github.com/Raku/old-issue-tracker/issues/6468
is ('abc' ~~ /<?after ^^>/).from, 0, '^^ in <?after ...>';
is ('abc' ~~ /<?after ^>/).from,  0, '^ in <?after ...>';
is ('abc' ~~ /<?after $$>/).from, 3, '$$ in <?after ...>';
is ('abc' ~~ /<?after $>/).from,  3, '$ in <?after ...>';

# https://github.com/rakudo/rakudo/issues/2791
{
    is "C"  ~~ / <:Lu> <!before \S > /, 'C', 'did assertion at end work';
}

# vim: expandtab shiftwidth=4
