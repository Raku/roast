use v6.c;
use Test;

# L<S32::Str/Str/"=item samecase">

=begin pod

Basic test for the samecase() builtin with a string (Str).

=end pod

plan 8;

# As a function
is( samecase('Perl6', 'abcdE'), 'perl6', 'as a function');

# As a method
is( ''.samecase(''), '', 'empty string' );
is( 'Hello World !'.samecase('AbCdEfGhIjKlMnOpQrStUvWxYz'), 'HeLlO WoRlD !', 'literal');


# On a variable
my Str $a = 'Just another Perl6 hacker';
is( $a.samecase('XXXXXXXXXXXXXXXXXXXXXXXXX'), 'JUST ANOTHER PERL6 HACKER', 'with a Str variable' );
is( $a.samecase('äääääääääääääääääääääääää'), 'just another perl6 hacker', 'with a Str variable and <unicode> arg');
is( $a, 'Just another Perl6 hacker', 'samecase should not be in-place' );
is( $a .= samecase('aaaaaaaaaaaaaaaaaaaaaaaa'), 'just another perl6 hacker', 'after a .= samecase(...)' );

# samecase with unicode
is( 'ä€»«'.samecase('xXxX'), 'ä€»«', 'some unicode characters' );


# vim: ft=perl6
