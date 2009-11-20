use v6;

use Test;

plan 5;

{
    my $range = 2..6;
    isa_ok $range, Range, '$range is a Range';
    is $range.min, 2, "2..6.min is 2";
    is $range.max, 6, "2..6.max is 6";
    is $range.excludes_min, Bool::False, "2..6.excludes_min is false";
    is $range.excludes_max, Bool::False, "2..6.excludes_max is false";
}

done_testing;

# vim: ft=perl6
