# http://perl6advent.wordpress.com/2009/12/08/day-8-comb-your-constraints/

use v6;
use Test;

plan 8;

multi sub very_odd(Int $odd where {$odd % 2}) { Bool::True }
multi sub very_odd(Int $odd) { Bool::False }   #OK not used

ok very_odd(1), 'Type constraint - odd number';
nok very_odd(2), 'Type constraint - even number';

{
    is "Perl 6 Advent".comb(/<alpha>/).join('|'), 'P|e|r|l|A|d|v|e|n|t', 'Comb for <alpha> and join on |';
    is "Perl 6 Advent".comb(/<alpha>+/).join('|'), 'Perl|Advent', 'Comb for <alpha>+ and join on |';
}
is "5065726C36".comb(/<xdigit>**2/)».fmt("0x%s")».chr.join, 'Perl6', 'Comb ASCII hex chars with hyperop to convert to ASCII equivalent';

is ("5065726C36".comb(/<xdigit>**2/).map: { chr "0x" ~ $_ }).join, 'Perl6', 'Comb ASCII hex chars using map to convert to ASCII equivalent';

sub rotate_one( Str $c where { $c.chars == 1 }, Int $n ) {
    return $c if $c !~~ /<alpha>/;
    my $out = $c.ord + $n;
    $out -= 26 if $out > ($c eq $c.uc ?? 'Z'.ord !! 'z'.ord);
    return $out.chr;
}

sub rotate(Str $s where {$s.chars}, Int $n = 3)
{
    return ($s.comb.map: { rotate_one( $_, $n % 26 ) }).join( '' );
}

my Str $mess = 'Perl6 Advent Calendar';
my Int $rotate = 10;

is rotate($mess,$rotate), 'Zobv6 Knfoxd Mkvoxnkb', "Caesar Cipher using .comb and .map";
is rotate($mess), 'Shuo6 Dgyhqw Fdohqgdu', 'Caesar Cipher using parameter defaults';
