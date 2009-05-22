use v6;
use Test;

=begin origin

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/continue.t.

=end origin

plan 14;

#?pugs emit force_todo(1,2,3,4,6);

# L<S05/Modifiers/causes the pattern to try to match only at>

for ("abcdef") {
    ok(m:pos/abc/, "Matched 1: '$/'" );
    is($/.to, 3, 'Interim position correct');
    ok(m:pos/ghi|def/, "Matched 2: '$/'" );
    is($/.to, 6, 'Final position correct');
}

my $_ = "foofoofoo foofoofoo";
ok(s:global:pos/foo/FOO/, 'Globally contiguous substitution');
is($_, "FOOFOOFOO foofoofoo", 'Correctly substituted contiguously');

{
    my $str = "abcabcabc";
    ok($str ~~ m:p/abc/, 'Continued match');

    ok($/.to == 3, 'Continued match pos');

    # since match positions are now part of the match (and not the string),
    # assigning to the string doesn't reset anything
    $str = "abcabcabc";
    my $x = $str ~~ m:i:p/abc/;
    ok($/.to == 6, 'Insensitive continued match pos');

    $x = $str ~~ m:i:p/abc/;
    ok($/.to == 9, 'Insensitive recontinued match pos');

    $str = "abcabcabc";
    my @x = $str ~~ m:i:g:p/abc/;
    is("@x", "abc abc abc", 'Insensitive repeated continued match');
    ok($/.to == 9, 'Insensitive repeated continued match pos');

    ok ($str !~~ m:i:p/abc/, 'no more match, string exhausted';
}

my $str = "abcabcabc";
my @x = ?($str ~~ m:p:i:g/abc/);
# XXX is that correct?
is($/.to,  3, 'Insensitive scalar repeated continued match pos');

# vim: ft=perl6
