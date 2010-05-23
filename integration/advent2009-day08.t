# http://perl6advent.wordpress.com/2009/12/08/day-8-comb-your-constraints/

use v6;
use Test;

plan 6;

multi sub very_odd(Int $odd where {$odd % 2}) { Bool::True }
multi sub very_odd(Int $odd) { Bool::False }

ok very_odd(1), 'Type constraint - odd number';
nok very_odd(2), 'Type constraint - even number';

#?rakudo skip ".comb(/<alpha>/) doesn't work in current rakudo"
{
    is "Perl 6 Advent".comb(/<alpha>/).join('|'), 'P|e|r|l|A|d|v|e|n|t', 'Comb for <alpha> and join on |';
    is "Perl 6 Advent".comb(/<alpha>+/).join('|'), 'Perl|Advent', 'Comb for <alpha>+ and join on |';
}
#?rakudo skip "fails on current rakudo"
is "5065726C36".comb(/<xdigit>**2/)».fmt("0x%s")».chr.join, 'Perl6', 'Comb ASCII hex chars with hyperop to convert to ASCII equivalent';

is ("5065726C36".comb(/<xdigit>**2/).map: { chr "0x" ~ $_ }).join, 'Perl6', 'Comb ASCII hex chars using map to convert to ASCII equivalent';
