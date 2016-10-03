use v6;
use Test;

# L<S32::Temporal/C<Date>>

plan 105;

# construction
{
    lives-ok { Date.new('2010-01-01') }, 'Date.new("2010-01-01")';
    lives-ok { Date.new(2010, 1, 1) }, 'List constructor';
    lives-ok { Date.new(:year(2010), :month(1), :day(1)) }, 'named arguments';
    lives-ok { Date.today }, 'Date.today';
    lives-ok { 
        my $dt = DateTime.new(:year(2010),:month(6), :day(4));
        Date.new($dt); 
    }, 'Date.new from DateTime';

    dies-ok { Date.new('malformed') }, 'obviously malformed string';
    dies-ok { Date.new('2010-00-23') }, 'dies on zero-based months';
    dies-ok { Date.new('2010-13-23') }, 'dies on month 13';
    dies-ok { Date.new('2010-01-00') }, 'dies on zero-based days';
    dies-ok { Date.new('2010-01-32') }, 'dies on day of month 32';
    dies-ok { Date.new('1999-02-29') }, 'dies on 29 February 1999';
    dies-ok { Date.new('1900-02-29') }, 'dies on 29 February 1900';
    lives-ok { Date.new('2000-02-29') }, '...but not 29 February 2000';

    isa-ok Date.new(2010, 1, 1), Date, 'Date.new() returns a Date';

    my $date = Date.new('1999-01-29');
    dies-ok { $date.clone(month => 2) }, 'dies on 29 February 1999 (Date.clone)';
    lives-ok { $date.clone(:month(2), :year(2000)) }, '..but not 29 February 2000 (Date.clone)';
}

# RT #112376, stringification
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

    is $d.is-leap-year,   Bool::True, 'leap year';
    is $d.days-in-month,          29, 'days in month';
}

# arithmetics

sub d($x) { Date.new($x); }
{
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

    is $a cmp $a, Order::Same, 'cmp ( 0)';
    is $a cmp $b, Order::Less, 'cmp (-1)';
    is $c cmp $a, Order::More, 'cmp (+1)';


    is $a <=> $a, Order::Same, '<=> ( 0)';
    is $a <=> $b, Order::Less, '<=> (-1)';
    is $c <=> $a, Order::More, '<=> (+1)';
}

ok d('2011-01-14') ~~ d('2011-01-14'), 'Can smartmatch Date objects';

{
    is d('2013-12-23').later(day => 1), d('2013-12-24'), 'adding 1 day';
    is d('2014-01-31').later(day => 1), d('2014-02-01'), 'adding 1 day, overflowing to February';
    is d('2014-02-28').later(days => 2), d('2014-03-02'), 'adding 2 days, overflowing to March';
    is d('2013-12-23').later(week => 1), d('2013-12-30'), 'adding 1 week';
    is d('2014-01-31').later(week => 1), d('2014-02-07'), 'adding 1 week, overflowing to February';
    is d('2014-02-28').later(weeks => 2), d('2014-03-14'), 'adding 2 weeks, overflowing to March';
    is d('2014-12-30').later(weeks => 3), d('2015-01-20'), 'adding 3 weeks, overflowing to years';
    is d('2014-12-30').later(months => 3), d('2015-03-30'), 'adding 3 months, overflowing to years';
    is d('2014-12-30').later(months => 15), d('2016-03-30'), 'adding 15 months, overflowing to years';
    is d('2014-12-30').later(years => 3), d('2017-12-30'), 'adding 3 years';
    is d('2013-12-24').earlier(day => 1), d('2013-12-23'), 'subtracting 1 day';
    is d('2014-02-01').earlier(day => 1), d('2014-01-31'), 'subtracting 1 day, overflowing from February';
    is d('2014-03-02').earlier(days => 2), d('2014-02-28'), 'subtracting 2 days, overflowing from March';
    is d('2013-12-30').earlier(week => 1), d('2013-12-23'), 'subtracting 1 week';
    is d('2014-02-07').earlier(week => 1), d('2014-01-31'), 'subtracting 1 week, overflowing from February';
    is d('2014-03-14').earlier(weeks => 2), d('2014-02-28'), 'subtracting 2 weeks, overflowing from March';
    is d('2015-01-20').earlier(weeks => 3), d('2014-12-30'), 'subtracting 3 weeks, overflowing to years';
    lives-ok { Date.new('2010-01-31').later(month => 1) }, '.later does not try to create an impossible date';
    is d('2014-02-07').earlier(months => 3), d('2013-11-07'), 'subtracting 3 months, underflowing year';
    is d('2014-02-07').earlier(months => 15), d('2012-11-07'), 'subtracting 15 months, underflowing 2 years';
    is d('2014-02-07').earlier(year => 1), d('2013-02-07'), 'subtracting 1 year';
}

# RT #125681
{
    is d("0000-01-01").truncated-to("week"), "-0001-12-27", "negative dates ISO-8601 rendering";
    is d("9900-01-01") + 100000, "+10173-10-16", "very large years, ISO-8601 rendering";
}

# RT #125682 Overflows
{
    is d('2015-12-25').later( years => 1_000_000_000_000 ), "+1000000002015-12-25", "adding large years does not overflow";
    is d('2015-12-25').earlier( days => 1_000_000_000_000 ),   "-2737904992-12-29", "subtracting large days does not underflow";
}

# RT #127010 negative years
{
    is d('-1234-12-24'), '-1234-12-24', 'negative years handled correctly';
}

# problem lizmat found
is d("2016-02-29").later(:1year), "2017-02-28",
  'moving a year from a leap-date into a year without leap-date';

is Date.new(2015,12,29,:formatter({sprintf "%2d/%2d/%4d",.day,.month,.year})),
   '29/12/2015', 'formatter with y,m,d';
is Date.new('2015-12-29',:formatter({sprintf "%2d/%2d/%4d",.day,.month,.year})),
   '29/12/2015', 'formatter with "yyyy-mm-dd"';

# RT #127170
{
    role Foo { has @.a = 7, 8, 9 }
    class BarDate is Date does Foo {}
    is BarDate.today.a, [7,8,9], 'did role attributes get initialized ok';
}

{
    class FooDate is Date { has $.foo };
    for (2016,2,20), '2016-02-20', \(:2016year,:2month,:20day) -> $date {
        my $fd = FooDate.new(|$date, foo => 42);
        is $fd.year, 2016, "is year in FooDate ok";
        is $fd.month,   2, "is month in FooDate ok";
        is $fd.day,    20, "is day in FooDate ok";
        is $fd.foo,    42, "is foo in FooDate ok";
    }
}

# RT #128545
throws-like { Date.new: "2016-07\x[308]-05" }, X::Temporal::InvalidFormat,
    'synthetics are rejected in constructor string';

{ # coverage; 2016-09-28
    subtest 'can create Date from Instant' => {
        constant $i = Instant.from-posix: 1234567890;

        is Date.new($i).Str, '2009-02-13', 'Instant only';
        is Date.new($i, :formatter{ "It is {.year}" }).Str, 'It is 2009',
            'Instant, with a custom formatter';
    }

    is-deeply Date.new('2016-09-28').perl.EVAL,
              Date.new('2016-09-28'), 'can roundtrip .perl output';

    is-deeply (62 + Date.new: '2016-11-10'), Date.new('2017-01-11'),
        'can Int + Date to increment date by Int days';
}
