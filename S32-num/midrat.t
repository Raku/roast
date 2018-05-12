use v6;
use Test;

# Tests for MidRat type

plan 1;

subtest 'creation; too-large Rat literals get promoted to MidRats' => {
    plan 10;

    cmp-ok  0.0000000000000000001.WHAT,  '=:=', Rat, 'decimal literal';
    cmp-ok <0.0000000000000000001>.WHAT, '=:=', Rat,
        'angle brackets decimal literal';
    cmp-ok <1/9999999999999999999>.WHAT, '=:=', Rat,
        'angle brackets fraction literal';
    cmp-ok Rat.new(1, 9999999999999999999).WHAT, '=:=', Rat,
        'Rat.new';

    cmp-ok  0.00000000000000000001.WHAT,  '=:=', MidRat, 'decimal literal';
    cmp-ok <0.00000000000000000001>.WHAT, '=:=', MidRat,
        'angle brackets decimal literal';
    cmp-ok <1/99999999999999999999>.WHAT, '=:=', MidRat,
        'angle brackets fraction literal';
    cmp-ok Rat.new(1, 99999999999999999999).WHAT, '=:=', MidRat,
        'Rat.new with too large denominator produces MidRat';
    cmp-ok MidRat.new(1, 2).WHAT, '=:=', MidRat,
        'MidRat.new';

    cmp-ok (1/99999999999999999999).WHAT, '=:=', Num,
        'plain Int division with too-large denominator does NOT produce MidRat';
}

# vim: ft=perl6
