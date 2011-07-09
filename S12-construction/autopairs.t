use v6;

use Test;

plan 4;


#L<S02/"Literals"/"There is now a generalized adverbial form">

{
    eval_lives_ok('my $a; class Ta { has $.a }; my Ta $c .= new(:$a)',
            'class instantiation with autopair, no spaces');
    eval_lives_ok('my $a; class Tb { has $.a }; my Tb $Tb .= new(:$a )',
            'class instantiation with autopair, spaces');
    #?rakudo 2 todo 'nom regression'
    eval_lives_ok('my $a; role Tc { has $.a }; my Tc $c .= new(:$a)',
            'role instantiation with autopair, no spaces');
    eval_lives_ok('my $a; role Td { has $.a }; my Td $c .= new(:$a )',
            'role instantiation with autopair, spaces');
}

# vim: ft=perl6
