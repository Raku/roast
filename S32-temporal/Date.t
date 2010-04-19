use v6;
use Test;

plan *;

# construction
{
    lives_ok { Date.new('2010-01-01') }, 'Date.new("2010-01-01")';
    lives_ok { Date.new(2010, 1, 1) }, 'List constructor';
    lives_ok { Date.new(:year(2010), :month(1), :day(1)) }, 'named arguments';
    lives_ok { Date.today}, 'Date.today';

    dies_ok { Date.new('malformed') }, 'obviously malformed string';
    dies_ok { Date.new('2010-00-23') }, 'dies on zero-based months';
    dies_ok { Date.new('2010-01-00') }, 'dies on zero-based days';

    isa_ok Date.new(2010, 01, 01), Date, 'Date.new() returns a Date';
}

# stringification
is ~Date.new(:year(2010), :month(3), :day(5)), '2010-03-05',
    'normal Date strinfies sanely';

# accessors

{
    my $d;

    ok ($d = Date.new('2000-02-28')), 'creation' or die "Something's very wrong";
    is $d.year, 2000,    'year';
    is $d.month,   2,    'month';
    is $d.day,    28,    'day';

    is $d.day-of-week,             1, 'Day of week';

    is $d.leap-year,      Bool::True, 'leap year';
    is $d.days-in-month,          29, 'days in month';
}

# arithmetics
# much of this is blatantly stolen from the Date::Simple test suite
# and redistributed under the terms of the Artistic License 2.0 with
# permission of the original authors (John Tobey, Marty Pauly).

sub d($x) { Date.new($x); }
{
    is d('1966-10-15').day-of-week, 6, 'Day of week (1)';
    is d('2401-03-01').day-of-week, 4, 'Day of week (2)';
    is d('2401-02-28').day-of-week, 3, 'Day of week (3)';
    is d('2400-03-01').day-of-week, 3, 'Day of week (4)';
    is d('2400-02-29').day-of-week, 2, 'Day of week (5)';
    is d('2400-02-28').day-of-week, 1, 'Day of week (6)';
    is d('2101-03-01').day-of-week, 2, 'Day of week (7)';
    is d('2101-02-28').day-of-week, 1, 'Day of week (8)';
    is d('2100-03-01').day-of-week, 1, 'Day of week (9)';
    is d('2100-02-28').day-of-week, 7, 'Day of week (10)';
    is d('2001-03-01').day-of-week, 4, 'Day of week (11)';
    is d('2001-02-28').day-of-week, 3, 'Day of week (12)';
    is d('2000-03-01').day-of-week, 3, 'Day of week (13)';
    is d('2000-02-29').day-of-week, 2, 'Day of week (14)';
    is d('2000-02-28').day-of-week, 1, 'Day of week (15)';
    is d('1901-03-01').day-of-week, 5, 'Day of week (16)';
    is d('1901-02-28').day-of-week, 4, 'Day of week (17)';
    is d('1900-03-01').day-of-week, 4, 'Day of week (18)';
    is d('1900-02-28').day-of-week, 3, 'Day of week (19)';
    is d('1801-03-01').day-of-week, 7, 'Day of week (20)';
    is d('1801-02-28').day-of-week, 6, 'Day of week (21)';
    is d('1800-03-01').day-of-week, 6, 'Day of week (22)';
    is d('1800-02-28').day-of-week, 5, 'Day of week (23)';
    is d('1701-03-01').day-of-week, 2, 'Day of week (24)';
    is d('1701-02-28').day-of-week, 1, 'Day of week (25)';
    is d('1700-03-01').day-of-week, 1, 'Day of week (26)';
    is d('1700-02-28').day-of-week, 7, 'Day of week (27)';
    is d('1601-03-01').day-of-week, 4, 'Day of week (28)';
    is d('1601-02-28').day-of-week, 3, 'Day of week (29)';
    is d('1600-03-01').day-of-week, 3, 'Day of week (30)';
    is d('1600-02-29').day-of-week, 2, 'Day of week (31)';
    is d('1600-02-28').day-of-week, 1, 'Day of week (32)';


    is d('2010-04-12').succ, '2010-04-13', 'simple .succ';
    is d('2010-04-12').pred, '2010-04-11', 'simple .pred';

    is d('2000-02-28').succ, '2000-02-29', '.succ with leap year (1)';
    is d('2000-02-28').pred, '2000-02-27', '.pred with leap year (1)';

    is d('2000-02-29').succ, '2000-03-01', '.succ with leap year (2)';
    is d('2000-02-29').pred, '2000-02-28', '.pred with leap year (2)';
    is d('2000-03-01').pred, '2000-02-29', '.pred with leap year (3)';
}

# arithmetic operators
{
    is d('2000-02-28') + 7,  '2000-03-06', '+7';
    is d('2000-03-06') - 14, '2000-02-21', '-14';

    is d('2000-02-28') - d('2000-02-21'), 7, 'Difference of two dates';

    is d('2000-02-21') + 0, d('2000-02-21'), '+0';
    is d('2000-02-21') + -3, d('2000-02-21') - 3, '+ -3 == - 3';

    my ($a, $b, $c);
    # $a < $b < $c;
    $a = d('1963-07-02');
    $b = d('1964-02-01');
    $c = d('1964-02-02');

    ok  $a == $a, '== (+)';
    nok $a == $b, '== (-)';

    ok  $a != $c, '!= (+)';
    nok $a != $a, '!= (-)';

    ok  $b <= $b, '<= (+)';
    ok  $b <= $c, '<= (+)';
    nok $b <= $a, '<= (-)';

    nok $a <  $a, '<  (-)';
    ok  $a <  $b, '<  (+)';
    nok $b <  $a, '<  (-)';

    ok  $a >= $a, '>= (+)';
    ok  $b >= $a, '>= (+)';
    nok $b >= $c, '>= (-)';

    nok $a >  $a, '> (-)';
    ok  $b >  $a, '> (+)';
    nok $a >  $b, '> (-)';

    is $a cmp $a,  0, 'cmp ( 0)';
    is $a cmp $b, -1, 'cmp (-1)';
    is $c cmp $a,  1, 'cmp (+1)';


    is $a <=> $a,  0, '<=> ( 0)';
    is $a <=> $b, -1, '<=> (-1)';
    is $c <=> $a,  1, '<=> (+1)';
}

done_testing;
