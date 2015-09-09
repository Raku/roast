use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/litvar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 33;

# L<S05/Variable (non-)interpolation/The default way in which the engine handles a scalar>

my $var = "a*b";
my @var = <a b ab c>;
my $aref = @var;


# SCALARS

# just document ticket test below
ok($var ~~ m/$var/, 'Simple scalar interpolation');
ok("zzzzzz{$var}zzzzzz" ~~ m/$var/, 'Nested scalar interpolation');
ok(!( "aaaaab" ~~ m/$var/ ), 'Rulish scalar interpolation');

ok(!('a0' ~~ m/$aref[0]/), 'Array ref stringifies before matching'); #OK
#?niecza todo
ok('a b ab c0' ~~ m/$aref[0]/, 'Array ref stringifies before matching'); #OK
ok('a0' ~~ m/@$aref[0]/, 'Array deref ignores 0');                 #OK
ok('bx0' ~~ m/@$aref.[0]/, 'Array deref ignores dot 0');           #OK
ok('c0' ~~ m/@var[0]/, 'Array ignores 0');                         #OK


# ARRAYS
# L<S05/Variable (non-)interpolation/An interpolated array:>

ok("a" ~~ m/@var/, 'Simple array interpolation (a)');
ok("b" ~~ m/@var/, 'Simple array interpolation (b)');
ok("c" ~~ m/@var/, 'Simple array interpolation (c)');
ok(!( "d" ~~ m/@var/ ), 'Simple array interpolation (d)');
ok("ddddaddddd" ~~ m/@var/, 'Nested array interpolation (a)');

ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
ok(!( "abcad" ~~ m/^@var+$/ ), 'Multiple array non-matching');

is("abc" ~~ m/ @var /,     'ab', 'Array using implicit junctive semantics');
is("abc" ~~ m/ | @var /,   'ab', 'Array using explicit junctive semantics');
#?niecza todo "sequential semantics NYI"
is("abc" ~~ m/ || @var /,  'a',  'Array using explicit sequential semantics');

# contextializer $( )

# RT 115298
ok 'foobar' ~~ /$( $_ )/, '$( $_ ) will match';
is $/, 'foobar', '... $( $_ ) matched entire string';
is 'foobar' ~~ /$( $_.substr(3) )/, 'bar', 'Contextualizer with functions calls';
is 'foobar' ~~ /@( <a b c o> )+/,   'ooba', '@( <a b c o> )+';

# RT #117091
{
    my $rex = 'rex';
    ok 'Rex' ~~ m:i/$rex/, 'can case-insensitive match against interpolated var';
    ok 'Rex' ~~ m:i/<$rex>/, 'can case-insensitive match against var in assertion';
}

# $i was picked here because it is an internal variable in rakudo that was
# visible in regex interpolations in the past.
$var = '$i';
throws-like { EVAL '"foo" ~~ /<$var>/' }, X::Undeclared, symbol => '$i',
    'undeclared var in assertion in interpolated string throws';
{
    my $i = 'f+o';
    $var  = '$i';
    is "foo" ~~ /<$var>/, Nil,
        'assertions only reinterpret one level deep';

    $var = '<$i>';
    is "foo" ~~ /<$var>/, 'fo',
        'assertion in reinterpreted assertion matches';
}

$var = 'fo+';
is "foo" ~~ /<$var>/, 'foo', 'string with metachars in assertion matches';

$var = 'fO+';
is "foo" ~~ /:i <$var>/, 'foo', 'string with metachars in assertion matches (:i)';

#?rakudo.jvm 3 skip ':ignoremark needs NFG RT #124500'
$var = 'fö+';
is "foo" ~~ /:m <$var>/, 'foo', 'string with metachars in assertion matches (:m)';

$var = 'fÖ+';
is "foo" ~~ /:i:m <$var>/, 'foo', 'string with metachars in assertion matches (:i:m)';

is "fo+" ~~ /:i:m $var/, 'fo+', 'string with metachars matches literally (:i:m)';

{
    my Str $s;
    my Regex $r = rx{ "a" | "b" | $s | $s };
    nok "fooo" ~~ $r, 'Interpolating Str type object on typed variable fails to match';
}

# vim: ft=perl6
