use v6;
use Test;

=begin origin

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/continue.t.

=end origin

plan 6;

#?pugs emit force_todo(1,2,3,4,6);
#?rakudo emit skip_rest("regexes not implemented");

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

