use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/litvar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 22;

# L<S05/Variable (non-)interpolation/The default way in which the engine handles a scalar>

my $var = "a*b";
my @var = <a b ab c>;
my $aref = \@var;


# SCALARS

# just document ticket test below
#?pugs 2 todo 'bug'
ok($var ~~ m/$var/, 'Simple scalar interpolation');
ok("zzzzzz{$var}zzzzzz" ~~ m/$var/, 'Nested scalar interpolation');
ok(!( "aaaaab" ~~ m/$var/ ), 'Rulish scalar interpolation');

#?pugs 3 todo 'feature'
ok('a0' ~~ m/$aref[0]/, 'Array ref 0');
ok('bx0' ~~ m/$aref.[0]/, 'Array ref dot 0');
ok('c0' ~~ m/@var[0]/, 'Array 0');

# REGEXES
# However, if $var contains a Regex object, instead of attempting to convert it to a string, it is called as a subrule
# A simple test for this
my $rx = rx/foo/;
#?pugs todo
ok('foobar' ~~ /$rx bar/,  'regex object in a regex');
ok('quxbaz' !~~ /$rx baz/, 'nonmatching regex object in a regex');


# ARRAYS
# L<S05/Variable (non-)interpolation/An interpolated array:>

#?pugs 3 todo 'feature'
ok("a" ~~ m/@var/, 'Simple array interpolation (a)');
ok("b" ~~ m/@var/, 'Simple array interpolation (b)');
ok("c" ~~ m/@var/, 'Simple array interpolation (c)');
ok(!( "d" ~~ m/@var/ ), 'Simple array interpolation (d)');
#?pugs 2 todo 'feature'
ok("ddddaddddd" ~~ m/@var/, 'Nested array interpolation (a)');

ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
ok(!( "abcad" ~~ m/^@var+$/ ), 'Multiple array non-matching');

#?pugs 3 todo 'feature'
is("abc" ~~ m/ @var /,     'ab', 'Array using implicit junctive semantics');
is("abc" ~~ m/ | @var /,   'ab', 'Array using explicit junctive semantics');
#?niecza todo "sequential semantics NYI"
is("abc" ~~ m/ || @var /,  'a',  'Array using explicit sequential semantics');

# contextializer $( )

# RT 115298
#?pugs 4 todo
ok 'foobar' ~~ /$( $_ )/, '$( $_ ) will match';
is $/, 'foobar', '... $( $_ ) matched entire string';
is 'foobar' ~~ /$( $_.substr(3) )/, 'bar', 'Contextualizer with functions calls';
is 'foobar' ~~ /@( <a b c o> )+/,   'ooba', '@( <a b c o> )+';

done;

# vim: ft=perl6
