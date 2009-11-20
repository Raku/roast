use v6;

use Test;

plan 24;

{
    my $range = 2..6;
    isa_ok $range, Range, '2..6 is a Range';
    is $range.min, 2, "2..6.min is 2";
    is $range.max, 6, "2..6.max is 6";
    is $range.excludes_min, Bool::False, "2..6.excludes_min is false";
    is $range.excludes_max, Bool::False, "2..6.excludes_max is false";
    is $range.perl, "2..6", '.perl is correct';
}

{
    my $range = -1^..7;
    isa_ok $range, Range, '-1^..7 is a Range';
    is $range.min, -1, "-1^..7.min is -1";
    is $range.max, 7, "-1^..7.max is 7";
    is $range.excludes_min, Bool::True, "-1^..7.excludes_min is true";
    is $range.excludes_max, Bool::False, "-1^..7.excludes_max is false";
    is $range.perl, "-1^..7", '.perl is correct';
}

{
    my $range = 3..^-1;
    isa_ok $range, Range, '3..^-1 is a Range';
    is $range.min, 3, "3..^-1.min is 3";
    is $range.max, -1, "3..^-1.max is -1";
    is $range.excludes_min, Bool::False, "3..^-1.excludes_min is false";
    is $range.excludes_max, Bool::True, "3..^-1.excludes_max is true";
    is $range.perl, "3..^-1", '.perl is correct';
}

{
    my $range = 'a'^..^'g';
    isa_ok $range, Range, "'a'^..^'g' is a Range";
    is $range.min, 'a', "'a'^..^'g'.min is 'a'";
    is $range.max, 'g', "'a'^..^'g'.max is 'g'";
    is $range.excludes_min, Bool::True, "'a'^..^'g'.excludes_min is true";
    is $range.excludes_max, Bool::True, "'a'^..^'g'.excludes_max is true";
    is $range.perl, '"a"^..^"g"', '.perl is correct';
}
done_testing;

# vim: ft=perl6
