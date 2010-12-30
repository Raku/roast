use v6;
use Test;

#L<S03/Smart matching/array value slice truth>
{ 
    ok ((Mu, 1, Mu) ~~ .[1]),
        "element 1 of (Mu, 1, Mu) is true";
    ok !((Mu, Mu) ~~ .[0]),
        "element 0 of (Mu, Mu) is false";
    ok ((0, 1, 2, 3) ~~ .[1, 2, 3]),
        "array slice .[1,2,3] of (0,1,2,3) is true";
    ok !((0, 1, 2, 3) ~~ .[0]),
        "array slice .[0] of (0,1,2,3) is false";
    ok !((0, 1, 2, 3) ~~ .[0,1]),
        "array slice .[0,1] of (0,1,2,3) is false";
}

done_testing;

# vim: ft=perl6
