use v6;
use Test;
plan *;

#L<S03/Smart matching/Any Num numeric equality>
{
    ok  ('05' ~~ 5),            '$something ~~ number numifies';
    ok  ('1.2' ~~ 1.2),         '$thing ~~ number does numeric comparison';
    # yes, this warns, but it should still be true
    ok  (Mu ~~ 0),              'Mu ~~ 0';
    ok !(Mu ~~ 2.3),            'Mu ~~ $other_number';
    ok  (3+0i  ~~ 3),           'Complex ~~ Num (+)';
    ok !(3+1i  ~~ 3),           'Complex ~~ Num (-)';
    ok !(4+0i  ~~ 3),           'Complex ~~ Num (-)';
}

done_testing;

# vim: ft=perl6
