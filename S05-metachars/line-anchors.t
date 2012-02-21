use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/anchors.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# L<S05/New metacharacters/"^^ and $$ match line beginnings and endings">

plan 19;

my $str = q{abc
def
ghi};

#?pugs todo
ok(   $str ~~ m/^abc/, 'SOS abc' );
ok(!( $str ~~ m/^bc/ ), 'SOS bc' );
#?pugs todo
ok(   $str ~~ m/^^abc/, 'SOL abc' );
ok(!( $str ~~ m/^^bc/ ), 'SOL bc' );
#?pugs todo
ok(   $str ~~ m/abc\n?$$/, 'abc newline EOL' );
#?pugs todo
ok(   $str ~~ m/abc$$/, 'abc EOL' );
ok(!( $str ~~ m/ab$$/ ), 'ab EOL' );
ok(!( $str ~~ m/abc$/ ), 'abc EOS' );
ok(!( $str ~~ m/^def/ ), 'SOS def' );
#?pugs todo
ok(   $str ~~ m/^^def/, 'SOL def' );
#?pugs todo
ok(   $str ~~ m/def\n?$$/, 'def newline EOL' );
#?pugs todo
ok(   $str ~~ m/def$$/, 'def EOL' );
ok(!( $str ~~ m/def$/ ), 'def EOS' );
ok(!( $str ~~ m/^ghi/ ), 'SOS ghi' );
#?pugs todo
ok(   $str ~~ m/^^ghi/, 'SOL ghi' );
#?pugs todo
ok(   $str ~~ m/ghi\n?$$/, 'ghi newline EOL' );
#?pugs todo
ok(   $str ~~ m/ghi$$/, 'ghi EOL' );
#?pugs todo
ok(   $str ~~ m/ghi$/, 'ghi EOS' );
#?pugs todo
ok(   $str ~~ m/^abc$$\n^^d.*f$$\n^^ghi$/, 'All dot' );

# vim: ft=perl6
