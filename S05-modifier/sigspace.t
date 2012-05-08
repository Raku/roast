use v6;

use Test;

=begin pod

Parts of this file were originally derived from the perl5 CPAN module
Perl6::Rules, version 0.3 (12 Apr 2004), file t/word.t.

=end pod

plan 12;

ok(!( "abc  def" ~~ m/abc  def/ ), 'Literal space nonmatch' );
#?pugs todo
ok(   "abcdef"   ~~ m/abc  def/, 'Nonspace match' );
#?pugs todo
ok(   "abc  def" ~~ m:s/abc  def/, 'Word space match' );
#?pugs todo
ok(   'abc  def' ~~ ms/abc def/, 'word space match with ms//');
#?pugs todo
ok(   "abc\ndef" ~~ m:sigspace/abc  def/, 'Word newline match' );
ok(!( "abcdef"   ~~ m:sigspace/abc  def/ ), 'Word nonspace nonmatch' );
#?pugs todo
ok(   "abc  def" ~~ m:sigspace/abc <.ws> def/, 'Word explicit space match');

#?pugs todo
ok 'abc def'     ~~ m/:s abc def/,  'inline :s (+)';
ok 'zabc def'   !~~ m/:s abc def/,  'inline :s implies <.ws> immediately (-)';
#?pugs todo
ok 'zabc def'   ~~  m/:s'abc' def/, 'inline :s implies <.ws> immediately (+)';


# L<S05/Modifiers/The :s modifier is considered sufficiently important>

#?rakudo 2 skip 'mm'
#?niecza 2 skip 'Action method quote:mm not yet implemented'
#?pugs todo
ok 'abc def' ~~ mm/c d/, 'mm// works, implies :s (+)';
ok 'abcdef' !~~ mm/c d/, 'mm// works, implies :s (-)';

# vim: ft=perl6
