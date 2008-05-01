use v6-alpha;

use Test;

# String appending with ~ operator
# L<S03/Changes to Perl 5 operators/string concatenation becomes stitching>

plan 4;

# Again, mostly stolen from Perl 5

my $a = 'ab' ~ 'c';
is($a, 'abc', '~ two literals correctly');

my $b = 'def';

my $c = $a ~ $b;
is($c, 'abcdef', '~ two variables correctly');

$c ~= "xyz";
is($c, 'abcdefxyz', '~= a literal string correctly');

my $d = $a;
$d ~= $b;
is($d, 'abcdef', '~= variable correctly');
