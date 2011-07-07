use v6;

use Test;

plan 9;

# L<S03/Minimal whitespace DWIMmery/Whitespace is no longer allowed before>

my @arr = <1 2 3 4 5>;
eval_dies_ok('@arr [0]', 'array with space before opening brackets does not work');

my %hash = {a => 1, b => 2};
eval_dies_ok('%hash <a>', 'hash with space before opening brackets does not work (1)');
eval_dies_ok('%hash {"a"}', 'hash with space before opening braces does not work (2)');

# XXX this one is wrong, it's parsed as code( (5) )
# STD.pm agrees on that.
#sub code (Int $a) {2 * $a}
#eval_dies_ok('code (5)', 'sub call with space before opening parens does not work');

class Thing {method whatever (Int $a) {3 * $a}}
eval_dies_ok('Thing .new', 'whitespace is not allowed before . after class name');
eval_dies_ok('Thing. new', 'whitespace is not allowed after . after class name');

my $o = Thing.new;
eval_dies_ok('$o .whatever(5)', 'whitespace is not allowed before . before method');
eval_dies_ok('$o. whatever(5)', 'whitespace is not allowed after . before method');

eval_lives_ok 'my @rt80330; [+] @rt80330', 'a [+] with whitespace works';
#?rakudo todo 'RT 80330'
eval_dies_ok  'my @rt80330; [+]@rt80330', 'a [+] without whitespace dies';

# vim: ft=perl6
