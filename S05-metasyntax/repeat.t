use v6;

use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/repeat.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# Note: single-quotes.t tests repetition on single quoted items in regexes.

plan 46;

# L<S05/Bracket rationalization/The general repetition specifier is now>

# Exact repetition
ok("abcabcabcabcd" ~~ m/'abc'**4/, 'Fixed exact repetition');
is $/, 'abc' x 4, '...with the correct capture';
ok(!("abcabcabcabcd" ~~ m/'abc'**5/), 'Fail fixed exact repetition');
ok("abcabcabcabcd"    ~~ m/'abc'**{4}/, 'Fixed exact repetition using closure');
ok(!( "abcabcabcabcd" ~~ m/'abc'**{5}/ ), 'Fail fixed exact repetition using closure');

# Closed range repetition
ok("abcabcabcabcd" ~~ m/'abc'**2..4/, 'Fixed range repetition');
ok(!( "abc"        ~~ m/'abc'**2..4/ ), 'Fail fixed range repetition');
ok("abcabcabcabcd" ~~ m/'abc'**{2..4}/, 'Fixed range repetition using closure');
ok(!( "abc"        ~~ m/'abc'**{2..4}/ ), 'Fail fixed range repetition using closure');

# Open range repetition
ok("abcabcabcabcd" ~~ m/'abc'**2..*/, 'Open range repetition');
ok(!( "abcd"       ~~ m/'abc'**2..*/ ), 'Fail open range repetition');
ok("abcabcabcabcd" ~~ m/'abc'**{2..*}/, 'Open range repetition using closure');
ok(!( "abcd"       ~~ m/'abc'**{2..*}/), 'Fail open range repetition using closure');

# Closed non inclusive range repetition
ok("abcabcabcabcd" ~~ m/'abc'**2..^5/, 'Fixed non inclusive max range repetition');
ok(!( "abc"        ~~ m/'abc'**2..^5/ ), 'Fail fixed non inclusive max range repetition');
ok("abcabcabcabcd" ~~ m/'abc'**1^..4/, 'Fixed non inclusive min range repetition');
ok(!( "abc"        ~~ m/'abc'**1^..4/ ), 'Fail fixed non inclusive min range repetition');
ok("abcabcabcabcd" ~~ m/'abc'**1^..^5/, 'Fixed non inclusive min & max range repetition');
ok(!( "abc"        ~~ m/'abc'**1^..^5/ ), 'Fail fixed non inclusive min & max range repetition');
say $/;
ok("abcabcabcabcd" ~~ m/'abc'**^5/, 'Fixed non inclusive max repetition');
is $/, 'abc' x 4, '...with the correct capture';
ok("abcabcabcabcd" ~~ m/'abc'**^2/, 'Fixed non inclusive max repetition');
is $/, 'abc' x 1, '...with the correct capture';
ok("babcabcabcabcd" ~~ m/'abc'**^2/, 'Fixed non inclusive max repetition');
is $/, '', '...with the correct capture';

# Open non inclusive range repetition
ok("abcabcabcabcd" ~~ m/'abc'**1^..*/, 'Open non inclusive min range repetition');
ok(!( "abcd"       ~~ m/'abc'**1^..*/ ), 'Fail open non inclusive min range repetition');

# It is illegal to return a list, so this easy mistake fails:
throws-like '"foo" ~~ m/o{1,3}/', X::Obsolete, 'P5-style {1,3} range mistake is caught';
throws-like '"foo" ~~ m/o{1,}/', X::Obsolete,  'P5-style {1,} range mistake is caught';

is(~('foo,bar,baz,' ~~ m/[<alpha>+]+ %  ','/), 'foo,bar,baz',  '% with a term worked');
is(~('foo,bar,baz,' ~~ m/[<alpha>+]+ %% ','/), 'foo,bar,baz,', '%% with a term worked');
is(~('foo, bar,' ~~ m/[<alpha>+]+ % [','\s*]/), 'foo, bar', '% with a more complex term');

ok 'a, b, c' !~~ /:s^<alpha>+%\,$/, 'with no spaces around %, no spaces can be matched';
ok 'a, b, c'  ~~ /:s^ <alpha> +% \, $/, 'with spaces around %, spaces can be matched';
ok 'a , b ,c' ~~ /:s^ <alpha> +% \, $/, 'same, but with leading spaces';

# RT #76792
ok ('a b,c,d' ~~ token { \w \s \w+ % \, }), 'can combine % with backslash character classes';

# RT #119513
{
    ok ("a" x 1_0 ~~ /a ** 1_0/, 'underscore in quantifier numeral (1)' );
    ok ( "a_0" !~~ /a ** 1_0/, 'underscore in quantifier numeral (2)' );
}

# RT #111956
{
    throws-like q[/ * /], X::Syntax::Regex::SolitaryQuantifier,
        message => "Quantifier quantifies nothing",
        'adequate error message when quantifier follows nothing (1)';
    throws-like q[/ a+ + /], X::Syntax::Regex::SolitaryQuantifier,
        message => "Quantifier quantifies nothing",
        'adequate error message when quantifier follows nothing (2)';
}

# RT #77786
{
    throws-like q[/ : /], X::Syntax::Regex::SolitaryBacktrackControl,
        'adequate error message when backtrack control is out of control';
}

# RT #72440
ok '1a2a3bc' ~~ /^ \d+ % abc $/, '% only takes single atom as separator';
nok '1ab2ab3c' ~~ /^ \d+ % abc $/, '% only takes single atom as separator';

# RT #125521
{
    my $m = 'AAA' ~~ /$<letter>=(A)**{3}/;
    is +$m<letter>, 3, 'dynamic quantifiers interact correctly with captures';
}

# RT #77564
{
    throws-like q[/ {}* /], X::Syntax::Regex::NonQuantifiable,
        message => 'Can only quantify a construct that produces a match',
        'adequate error message when quantifier follows non-match construct (1)';
    throws-like q[/ <?{1}>? /], X::Syntax::Regex::NonQuantifiable,
        message => 'Can only quantify a construct that produces a match',
        'adequate error message when quantifier follows non-match construct (2)';
}

# vim: ft=perl6
