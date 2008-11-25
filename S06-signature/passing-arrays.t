use v6;
use Test;
plan 3;

{
    sub count(@a) {
        my $x = 0;
        $x++ for @a;
        return $x;
    }

    is count([1, 2, 3, 4]),       1, 'count([1, 2, 3, 4])';
    #?rakudo 2 todo 'RT #60404'
    is count(my @b = 1, 2, 3, 4), 4, 'count(my @b = 1, 2, 3)';
    is count((1, 2, 3)),          3, 'count(1, 2, 3)';
}

