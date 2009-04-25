use v6;

use Test;
plan 2;

eval_lives_ok 'class A { eval q/method x { "OH HAI" }/ }',
    'RT 61354 define method with eval in class should live';
is eval('class A { eval q/method x { "OH HAI" }/ }; A.x'), 'OH HAI',
    'RT 61354 define method with eval in class';

