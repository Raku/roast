use v6;

use Test;

=begin pod

Parts of this file were originally derived from the perl5 CPAN module
Perl6::Rules, version 0.3 (12 Apr 2004), file t/word.t.

=end pod

plan 16;

ok(!( "abc  def" ~~ m/abc  def/ ), 'Literal space nonmatch' );
ok(   "abcdef"   ~~ m/abc  def/, 'Nonspace match' );
ok(   "abc  def" ~~ m:s/abc  def/, 'Word space match' );
ok(   'abc  def' ~~ ms/abc def/, 'word space match with ms//');
ok(   "abc\ndef" ~~ m:sigspace/abc  def/, 'Word newline match' );
ok(!( "abcdef"   ~~ m:sigspace/abc  def/ ), 'Word nonspace nonmatch' );
ok(   "abc  def" ~~ m:sigspace/abc <.ws> def/, 'Word explicit space match');

ok 'abc def'     ~~ m/:s abc def/,  'inline :s (+)';
ok 'zabc def'   ~~  m/:s'abc' def/, "inline :s (+)";
ok 'zabc def'   ~~ m/:s abc def/,   "inline :s doesn't imply <.ws> immediately (-)";


# L<S05/Modifiers/The :s modifier is considered sufficiently important>

ok 'abc def' ~~ ms/c d/, 'ms// works, implies :s (+)';
ok 'abcdef' !~~ ms/c d/, 'ms// works, implies :s (-)';

# RT #119053
# RT #109874
{
    role Foo { rule foo { foo } }
    grammar Spacey does Foo {
        rule TOP { ^ <foo> }
    }
    grammar NonSpacey does Foo {
        rule TOP { ^<foo> }
    }
    ok ?Spacey.parse\  (" foo"), "Semantics of sigspace after ^";
    ok !NonSpacey.parse(" foo"), "Semantics of sigspace after ^";
    ok ?Spacey.parse\  ("foo"),  "Semantics of sigspace after ^";
    ok ?NonSpacey.parse("foo"),  "Semantics of sigspace after ^";
}

# vim: ft=perl6
