use v6;

use Test;

plan 8;

# L<S02/Lists/To force non-lazy list flattening, use the eager list operator>

# Ranges should be the easiest way to get an Iterator for testing eager
{
    my $range = 1 .. 5;
    is(=$range, 1, 'non-eager range iteration');
    ok($range eqv 2 .. 5, 'rest of range is intact');
    my @rest = eager =$range;
    is(@rest, <2 3 4 5>, 'all of range was returned in the correct order');
    ok(!$range, 'range is empty');
}

# L<S02/Lists/A variant of eager is the hyper list operator>
{
    my $range = 1 .. 5;
    is(=$range, 1, 'non-hyper range iteration');
    ok($range eqv 2 .. 5, 'rest of range is intact');
    my @rest = hyper =$range;
    is(sort @rest, <2 3 4 5>, 'all of range was returned in some order');
    ok(!$range, 'range is empty');
}
