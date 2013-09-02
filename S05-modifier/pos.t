use v6;
use Test;

=begin origin

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/continue.t.

=end origin

plan 40;

# L<S05/Modifiers/causes the pattern to try to match only at>

for ("abcdef") {
    ok(m:pos/abc/, "Matched 1: '$/'" );
    #?pugs todo
    is($/.to, 3, 'Interim position correct');
    ok(m:pos/ghi|def/, "Matched 2: '$/'" );
    #?pugs todo
    is($/.to, 6, 'Final position correct');
}

{
    $_ = "foofoofoo foofoofoo";
    my $/;
    ok(s:global:pos/foo/FOO/, 'Globally contiguous substitution');
    #?pugs todo
    #?rakudo todo "s:pos/// NYI"
    is($_, "FOOFOOFOO foofoofoo", 'Correctly substituted contiguously');
}

#?pugs todo
{
    my $str = "abcabcabc";
    my $/;
    ok($str ~~ m:p/abc/, 'Continued match');

    ok($/.to == 3, 'Continued match pos');

    # since match positions are now part of the match (and not the string),
    # assigning to the string doesn't reset anything
    $str = "abcabcabc";
    my $x = $str ~~ m:i:p/abc/;
    ok($/.to == 6, 'Insensitive continued match pos');

    $x = $str ~~ m:i:p/abc/;
    ok($/.to == 9, 'Insensitive recontinued match pos');
}

#?niecza skip ':i'
{
    my $str = "abcabcabc";
    my @x = $str ~~ m:i:g:p/abc/;
    #?pugs todo
    #?rakudo todo 'm:g'
    is("@x", "abc abc abc", 'Insensitive repeated continued match');
    #?pugs todo
    ok($/.to == 9, 'Insensitive repeated continued match pos');

    ok ($str !~~ m:i:p/abc/, 'no more match, string exhausted');
}

#?niecza skip ':i'
#?pugs todo
{
    my $str = "abcabcabc";
    my @x = ?($str ~~ m:p:i:g/abc/);
    # XXX is that correct?
    #?rakudo todo "m:p:i:g// NYI"
    is($/.to,  3, 'Insensitive scalar repeated continued match pos');
}

#?pugs skip 'Cannot parse regex'
{
   my $str = "abcabcabc";
   my $match = $str.match(/abc/, :p(0));
   ok $match.Bool, "Match anchored to 0";
   is $match.from, 0, "and the match is in the correct position";
   nok $str.match(/abc/, :p(1)).Bool, "No match anchored to 1";
   nok $str.match(/abc/, :p(2)).Bool, "No match anchored to 2";

   $match = $str.match(/abc/, :p(3));
   ok $match.Bool, "Match anchored to 3";
   is $match.from, 3, "and the match is in the correct position";
   nok $str.match(/abc/, :p(4)).Bool, "No match anchored to 4";
   
   $match = $str.match(/abc/, :p(6));
   ok $match.Bool, "Match anchored to 6";
   is $match.from, 6, "and the match is in the correct position";
   nok $str.match(/abc/, :p(7)).Bool, "No match anchored to 7";
   nok $str.match(/abc/, :p(8)).Bool, "No match anchored to 8";
   nok $str.match(/abc/, :p(9)).Bool, "No match anchored to 9";
   nok $str.match(/abc/, :p(10)).Bool, "No match anchored to 10";
}

{
   my $str = "abcabcabc";
   my $match = $str.match(/abc/, :pos(0));
   #?pugs todo
   ok $match.Bool, "Match anchored to 0";
   is $match.from, 0, "and the match is in the correct position";
   nok $str.match(/abc/, :pos(1)).Bool, "No match anchored to 1";
   nok $str.match(/abc/, :pos(2)).Bool, "No match anchored to 2";

   $match = $str.match(/abc/, :pos(3));
   #?pugs todo
   ok $match.Bool, "Match anchored to 3";
   #?pugs todo
   is $match.from, 3, "and the match is in the correct position";
   nok $str.match(/abc/, :pos(4)).Bool, "No match anchored to 4";
   
   $match = $str.match(/abc/, :pos(6));
   #?pugs todo
   ok $match.Bool, "Match anchored to 6";
   #?pugs todo
   is $match.from, 6, "and the match is in the correct position";
   nok $str.match(/abc/, :pos(7)).Bool, "No match anchored to 7";
   nok $str.match(/abc/, :pos(8)).Bool, "No match anchored to 8";
   nok $str.match(/abc/, :pos(9)).Bool, "No match anchored to 9";
   nok $str.match(/abc/, :pos(10)).Bool, "No match anchored to 10";
}

done;

# vim: ft=perl6
