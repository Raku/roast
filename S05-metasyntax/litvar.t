use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/litvar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 29;

# L<S05/Variable (non-)interpolation/The default way in which the engine handles a scalar>

my $var = "a*b";
my @var = <a b c>;
my %var = (a=>1, b=>2, c=>3);
my $aref = \@var;
my $href = \%var;


# SCALARS

ok($var ~~ m/$var/, 'Simple scalar interpolation', :todo<bug>);
ok("zzzzzz{$var}zzzzzz" ~~ m/$var/, 'Nested scalar interpolation', :todo<bug>);
ok(!( "aaaaab" ~~ m/$var/ ), 'Rulish scalar interpolation');

ok('a' ~~ m/$aref[0]/, 'Array ref 0', :todo<feature>);
ok('a' ~~ m/$aref.[0]/, 'Array ref dot 0', :todo<feature>);
ok('a' ~~ m/@var[0]/, 'Array 0', :todo<feature>);

ok('1' ~~ m/$href.{a}/, 'Hash ref dot A', :todo<feature>);
ok('1' ~~ m/$href{a}/, 'Hash ref A', :todo<feature>);
ok('1' ~~ m/%var{a}/, 'Hash A', :todo<feature>);

ok(!( 'a' ~~ m/$aref[1]/ ), 'Array ref 1');
ok(!( 'a' ~~ m/$aref.[1]/ ), 'Array ref dot 1');
ok(!( 'a' ~~ m/@var[1]/ ), 'Array 1');
ok(!( '1' ~~ m/$href.{b}/ ), 'Hash ref dot B');
ok(!( '1' ~~ m/$href{b}/ ), 'Hash ref B');
ok(!( '1' ~~ m/%var{b}/ ), 'Hash B');

# REGEXES
# However, if $var contains a Regex object, instead of attempting to convert it to a string, it is called as a subrule
# A simple test for this
my $rx = rx/foo/;
ok('foobar' ~~ /$rx bar/,  'regex object in a regex');
ok('quxbaz' !~~ /$rx baz/, 'nonmatching regex object in a regex');


# ARRAYS
# L<S05/Variable (non-)interpolation/An interpolated array:>

ok("a" ~~ m/@var/, 'Simple array interpolation (a)', :todo<feature>);
ok("b" ~~ m/@var/, 'Simple array interpolation (b)', :todo<feature>);
ok("c" ~~ m/@var/, 'Simple array interpolation (c)', :todo<feature>);
ok(!( "d" ~~ m/@var/ ), 'Simple array interpolation (d)');
ok("ddddaddddd" ~~ m/@var/, 'Nested array interpolation (a)', :todo<feature>);

ok("abca" ~~ m/^@var+$/, 'Multiple array matching', :todo<feature>);
ok(!( "abcad" ~~ m/^@var+$/ ), 'Multiple array non-matching');


# HASHES
# L<S05/Variable (non-)interpolation/An interpolated hash provides>

ok("a" ~~ m/%var/, 'Simple hash interpolation (a)', :todo<feature>);
ok("b" ~~ m/%var/, 'Simple hash interpolation (b)', :todo<feature>);
ok("c" ~~ m/%var/, 'Simple hash interpolation (c)', :todo<feature>);
ok(!( "d" ~~ m/%var/ ), 'Simple hash interpolation (d)');
ok("====a=====" ~~ m/%var/, 'Nested hash interpolation (a)', :todo<feature>);
ok(!( "abca" ~~ m/^%var$/ ), 'Simple hash non-matching');

ok("a b c a" ~~ m:s/^[ %var]+$/, 'Simple hash repeated matching', :todo<feature>);
