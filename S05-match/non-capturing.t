use v6;
use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/noncap.t.

=end pod

# L<S05/Bracket rationalization/"[...] is no longer a character class.
# It now delimits a non-capturing group.">

plan 9;

my $str = "abbbbbbbbc";

ok($str ~~ m{a(b+)c}, 'Matched 1');
ok($/, 'Saved 1');
is($/, $str, 'Grabbed all 1');
is($/[0], substr($str,1,*-1), 'Correctly captured 1');

ok($str ~~ m{a[b+]c}, 'Matched 2');
ok($/, 'Saved 2');
is($/, $str, 'Grabbed all 2');
ok(!defined($/[0]), "Correctly didn't capture 2");

{
    my rule abc {abc}

    my rule once {<&abc>}

    my rule mumble {<notabc>}

    ok("abcabcabcabcd" ~~ m/<&once>/, 'Once match');
}


# vim: ft=perl6
