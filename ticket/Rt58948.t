use v6;

use Test;
plan 2;

multi sub max($a, $b) {
    if defined $a && defined $b {
        if $a >= $b {return $a}
        else { return $b }
    }
    elsif defined $a { return $a }
    elsif defined $b { return $b }
    else { return undef }
}

multi sub max($a, $b, $c) {
    return max(max($a, $b), $c);
}

sub max3 { return 9 } # for fudging tests ...

eval_lives_ok 'max(9,2,1)', 'RT 58948 multi subs override max lives';
is eval('max(9,2,1)'), 9, 'RT 58948 multi subs override max' ;


