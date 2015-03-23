use v6;
use Test;

plan 3;

lives_ok { 4.HOW.HOW }, 'Can access meta class of meta class';

eval_dies_ok 'my $x; ($x = "hi").HOW = Block;',
            'Cannot assign to .HOW';

# RT #76928
{
    sub RT76928(%h?) { %h.HOW }
    lives_ok { RT76928() }, 'Can call .HOW on an optional sub parameter';
}

# vim: ft=perl6
