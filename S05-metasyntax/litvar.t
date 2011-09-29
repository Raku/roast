use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/litvar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 30;

# L<S05/Variable (non-)interpolation/The default way in which the engine handles a scalar>

my $var = "a*b";
my @var = <a b c>;
my %var = (a=>1, b=>2, c=>3);
my $aref = \@var;
my $href = \%var;


# SCALARS

# just document ticket test below
#?rakudo skip 'RT 61960'
#?pugs 2 todo 'bug'
ok($var ~~ m/$var/, 'Simple scalar interpolation');
ok("zzzzzz{$var}zzzzzz" ~~ m/$var/, 'Nested scalar interpolation');
ok(!( "aaaaab" ~~ m/$var/ ), 'Rulish scalar interpolation');

#?pugs 6 todo 'feature'
#?niecza todo
ok('a' ~~ m/$aref[0]/, 'Array ref 0');
#?niecza todo
ok('a' ~~ m/$aref.[0]/, 'Array ref dot 0');
#?niecza todo
ok('a' ~~ m/@var[0]/, 'Array 0');

#?niecza todo
ok('1' ~~ m/$href.{'a'}/, 'Hash ref dot A');
#?niecza todo
ok('1' ~~ m/$href{'a'}/, 'Hash ref A');
#?niecza todo
ok('1' ~~ m/%var{'a'}/, 'Hash A');

#?niecza todo
ok('1' ~~ m/$href.<a>/, 'Hash ref dot A');
#?niecza todo
ok('1' ~~ m/$href<a>/, 'Hash ref A');
#?niecza todo
ok('1' ~~ m/%var<a>/, 'Hash A');

ok(!( 'a' ~~ m/$aref[1]/ ), 'Array ref 1');
ok(!( 'a' ~~ m/$aref.[1]/ ), 'Array ref dot 1');
ok(!( 'a' ~~ m/@var[1]/ ), 'Array 1');
ok(!( '1' ~~ m/$href.{'b'}/ ), 'Hash ref dot B');
ok(!( '1' ~~ m/$href{'b'}/ ), 'Hash ref B');
ok(!( '1' ~~ m/%var{'b'}/ ), 'Hash B');
ok(!( '1' ~~ m/$href.<b>/ ), 'Hash ref dot B');
ok(!( '1' ~~ m/$href<b>/ ), 'Hash ref B');
ok(!( '1' ~~ m/%var<b>/ ), 'Hash B');

# REGEXES
# However, if $var contains a Regex object, instead of attempting to convert it to a string, it is called as a subrule
# A simple test for this
my $rx = rx/foo/;
#?niecza todo
ok('foobar' ~~ /$rx bar/,  'regex object in a regex');
ok('quxbaz' !~~ /$rx baz/, 'nonmatching regex object in a regex');


# ARRAYS
# L<S05/Variable (non-)interpolation/An interpolated array:>

#?pugs 3 todo 'feature'
#?niecza todo
ok("a" ~~ m/@var/, 'Simple array interpolation (a)');
#?niecza todo
ok("b" ~~ m/@var/, 'Simple array interpolation (b)');
#?niecza todo
ok("c" ~~ m/@var/, 'Simple array interpolation (c)');
ok(!( "d" ~~ m/@var/ ), 'Simple array interpolation (d)');
#?pugs 2 todo 'feature'
#?niecza todo
ok("ddddaddddd" ~~ m/@var/, 'Nested array interpolation (a)');

#?niecza todo
ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
ok(!( "abcad" ~~ m/^@var+$/ ), 'Multiple array non-matching');

# vim: ft=perl6
