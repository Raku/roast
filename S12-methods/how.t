use v6;
use Test;

plan 2;

lives_ok { 4.HOW.HOW }, 'Can access meta class of meta class';

eval_dies_ok 'my $x; ($x = "hi").HOW = Block;',
            'Cannot assign to .HOW';

# vim: ft=perl6
