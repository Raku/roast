use v6;

use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/word.t.

=end pod

plan 7;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
} else {

#?pugs emit force_todo(3,4,5);

ok(!( "abc  def" ~~ m/abc  def/ ), 'Literal space nonmatch' );
ok(   "abcdef"   ~~ m/abc  def/, 'Nonspace match' );
ok(   "abc  def" ~~ m:s/abc  def/, 'Word space match' );
ok(   "abc\ndef" ~~ m:sigspace/abc  def/, 'Word newline match' );
ok(!( "abcdef"   ~~ m:sigspace/abc  def/ ), 'Word nonspace nonmatch' );
ok(!( "abc  def" ~~ m:sigspace/abc <?sp> def/ ), 'Word explicit space non-match');
ok(   "abc  def" ~~ m:sigspace/abc <?ws> def/, 'Word explicit space match');

}

