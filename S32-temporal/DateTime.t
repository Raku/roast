use v6;
use Test;

plan 299;

my $orwell = DateTime.new(year => 1984);

sub dt(*%args) { DateTime.new(|{year => 1984, %args}) }
sub dtc(*%args) { $orwell.clone(|%args) }

sub ymd($year, $month, $day) { DateTime.new: :$year, :$month, :$day }
sub ymdc($year, $month, $day) { dtc :$year, :$month, :$day }

sub ds(Str $s) { DateTime.new($s) }

sub tz($tz) { ds "2005-02-04T15:25:00$tz" }

sub show-dt($dt) {
    join ' ', floor($dt.second), $dt.minute, $dt.hour,
        $dt.day, $dt.month, $dt.year, $dt.day-of-week
}

# An independent calculation to cross check the Temporal algorithms.
sub test-gmtime( Int $t is copy ) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday);
    $sec  = $t % 60; $t div= 60; # $t is now epoch minutes
    $min  = $t % 60; $t div= 60; # $t is now epoch hours
    $hour = $t % 24; $t div= 24; # $t is now epoch days
    # Not a sophisticated or fast algorithm, just an understandable one
    # only valid from 1970-01-01 until 2100-02-28
    $wday = ($t+3) % 7;  # 1970-01-01 was a Thursday
                         # Monday is $wday 0, unlike Perl 5.
    $year = 70; # (Unix epoch 0) == (Gregorian 1970) == (Perl year 70)
    loop ( $yday = 365; $t >= $yday; $year++ ) {
        $t -= $yday; # count off full years of 365 or 366 days
        $yday = (($year+1) % 4 == 0) ?? 366 !! 365;
    }
    $yday = $t;
    #         Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @days = 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31;
    @days[1] = ($year % 4 == 0) ?? 29 !! 28;       # calibrate February
    loop ( $mon = 0; $t >= @days[$mon]; $mon++ ) {
        $t -= @days[$mon];   # count off full months of whatever days
    }
    $mday = $t + 1;
    return ($sec, $min, $hour, $mday, $mon + 1, $year + 1900, $wday + 1);
}        #   0     1      2      3       4          5             6

# --------------------------------------------------------------------
# L<S32::Temporal/C<time>>
# --------------------------------------------------------------------

isa-ok time, Int, 'time returns an Int';

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/immutable>
# --------------------------------------------------------------------

{
    my $dt = ymd 1999, 5, 6;
    dies-ok { $dt.year = 2000 }, 'DateTimes are immutable (1)';
    dies-ok { $dt.minute = 30 }, 'DateTimes are immutable (2)';
    dies-ok { $dt.timezone = 0 }, 'DateTimes are immutable (3)';
    dies-ok { $dt.formatter = { $dt.hour } }, 'DateTimes are immutable (4)';
}

# --------------------------------------------------------------------
# Input validation
# --------------------------------------------------------------------

dies-ok { DateTime.new }, 'Must provide arguments to DateTime';

# L<S32::Temporal/C<DateTime>/outside of the ranges specified>

lives-ok { dt month => 1 }, 'DateTime accepts January';
dies-ok  { dt month => 0 }, 'DateTime rejects month 0';
dies-ok  { dt month => -1 }, 'DateTime rejects month -1';
lives-ok { dt month => 12 }, 'DateTime accepts December';
dies-ok  { dt month => 13 }, 'DateTime rejects month 13';
lives-ok { dt month => 1, day => 31 }, 'DateTime accepts January 31';
dies-ok  { dt month => 1, day => 32 }, 'DateTime rejects January 32';
lives-ok { dt month => 6, day => 30 }, 'DateTime accepts June 30';
dies-ok  { dt month => 6, day => 31 }, 'DateTime rejects June 31';
dies-ok  { dt month => 2, day => 30 }, 'DateTime rejects February 30';
lives-ok { ymd 1996, 2, 29 }, 'DateTime accepts 29 Feb 1996';
dies-ok  { ymd 1995, 2, 29 }, 'DateTime rejects 29 Feb 1995';
lives-ok { ymd 2000, 2, 29 }, 'DateTime accepts 29 Feb 2000';
lives-ok { ymdc 2000, 2, 29 }, 'DateTime accepts 29 Feb 2000 (clone)';
lives-ok { ds '2000-02-29T22:33:44' }, 'DateTime accepts 29 Feb 2000 (ISO)';
dies-ok  { ymd 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900';
dies-ok  { ymdc 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900 (clone)';
dies-ok  { ds '1900-02-29T22:33:44' }, 'DateTime rejects 29 Feb 1900 (ISO)';
lives-ok { dt hour => 0 }, 'DateTime accepts hour 0';
dies-ok  { dt hour => -1 }, 'DateTime rejects hour 0';
lives-ok { dt hour => 23 }, 'DateTime accepts hour 23';
dies-ok  { dt hour => 24 }, 'DateTime rejects hour 24';
lives-ok { dt minute => 0 }, 'DateTime accepts minute 0';
dies-ok  { dt minute => -1 }, 'DateTime rejects minute -1';
lives-ok { dt minute => 59 }, 'DateTime accepts minute 59';
lives-ok { dtc minute => 59 }, 'DateTime accepts minute 59 (clone)';
lives-ok { ds '1999-01-01T00:59:22' }, 'DateTime accepts minute 59 (ISO)';
lives-ok { DateTime.new: date => Date.new(1999, 1, 1), minute => 59 }, 'DateTime accepts minute 59 (with Date)';
dies-ok  { dt minute => 60 }, 'DateTime rejects minute 60';
dies-ok  { dtc minute => 60 }, 'DateTime rejects minute 60 (clone)';
dies-ok  { ds '1999-01-01T00:60:22' }, 'DateTime rejects minute 60 (ISO)';
dies-ok  { dt date => Date.new(1999, 1, 1), minute => 60 }, 'DateTime rejects minute 60 (with Date)';
lives-ok { dt second => 0 }, 'DateTime accepts second 0';
lives-ok { dt second => 1/2 }, 'DateTime accepts second 1/2';
dies-ok  { dt second => -1 }, 'DateTime rejects second -1';
dies-ok  { dt second => -1/2 }, 'DateTime rejects second -1/2';
lives-ok { dt second => 59.5 }, 'DateTime accepts second 59.5';
lives-ok { dtc second => 59.5 }, 'DateTime accepts second 59.5 (clone)';
dies-ok  { dt second => 62 }, 'DateTime rejects second 62';
dies-ok  { dtc second => 62 }, 'DateTime rejects second 62 (clone)';
dies-ok  { ds '1999-01-01T12:10:62' }, 'DateTime rejects second 62 (ISO)';
dies-ok  { dt date => Date.new(1999, 1, 1), second => 62 }, 'DateTime rejects second 62 (with Date)';

# Validate leap seconds.

dies-ok  { ds '1999-01-01T12:10:60' }, 'Leap-second validation: Wrong time and date';
dies-ok  { ds '1999-01-01T23:59:60' }, 'Leap-second validation: Wrong date';
dies-ok  { ds '1999-06-30T23:59:60' }, 'Leap-second validation: Wrong year (1)';
dies-ok  { ds '1999-12-31T23:59:60' }, 'Leap-second validation: Wrong year (2)';
dies-ok  { ds '1998-06-30T23:59:60' }, 'Leap-second validation: Wrong; June 30 on a year with a leap second in December 31';
dies-ok  { ds '1998-12-31T23:58:60' }, 'Leap-second validation: Wrong minute';
dies-ok  { ds '1998-12-31T22:59:60' }, 'Leap-second validation: Wrong hour';
lives-ok { ds '1998-12-31T23:59:60' }, 'Leap-second validation: Okay; December 31';
dies-ok  { ds '1997-12-31T23:59:60' }, 'Leap-second validation: Wrong; December 31 on a year with a leap second in June 30';
dies-ok  { dt year => 1997, month => 12, day => 31,
              hour => 23, minute => 59, second => 60.9 }, 'Leap-second validation: Wrong; December 31 on a year with a leap second in June 30 (second 60.9)';
lives-ok { ds '1997-06-30T23:59:60' }, 'Leap-second validation: Okay; June 30';
lives-ok { dt year => 1997, month => 6, day => 30,
              hour => 23, minute => 59, second => 60.9 }, 'Leap-second validation: Okay; June 30 (second 60.9)';
dies-ok  { ds '1997-06-30T23:59:61' }, 'Leap-second validation: Wrong; there are no seconds 61 (in the 20th century, anyway).';

dies-ok  { ds '1998-12-31T23:59:60+0200' }, 'Leap-second validation: Wrong because of TZ; December 31';
lives-ok { ds '1999-01-01T01:59:60+0200' }, 'Leap-second validation: Okay because of TZ; January 1';
dies-ok  { ds '1997-06-30T23:59:60-0200' }, 'Leap-second validation: Wrong because of TZ; June 30';
lives-ok { ds '1997-06-30T21:59:60-0200' }, 'Leap-second validation: Okay because of TZ; June 30';
dies-ok  { dt year => 1998, month => 12, day => 31,
              hour => 23, minute => 59, second => 60.9,
              timezone => 2*60*60 }, 'Leap-second validation: Wrong because of TZ; December 31 (second 60.9)';
lives-ok { dt year => 1999, month => 1, day => 1,
              hour => 1, minute => 59, second => 60.9,
              timezone => 2*60*60 }, 'Leap-second validation: Okay because of TZ; January 1 (second 60.9)';

# --------------------------------------------------------------------
# DateTime.new(Int)
# --------------------------------------------------------------------

# L<S32::Temporal/C<DateTime>/DateTime.new(time)>

is show-dt(DateTime.new(0)), '0 0 0 1 1 1970 4', 'DateTime at beginning of Unix epoch';
is show-dt(DateTime.new(946684799)), '59 59 23 31 12 1999 5', 'from POSIX at 1999-12-31T23:59:59Z';
  # last second of previous millennium, FSVO 'millennium'.
is show-dt(DateTime.new(946684800)), '0 0 0 1 1 2000 6', 'from POSIX at 2000-01-01T00:00:00Z';
  # one second later, sing Auld Lang Syne.

# compare dates for a series of times earlier and later than "now", so
# that every test run will use different values
# and test round-tripping with .perl while we're at it
{
    my $t = time;
    my $t1 = $t;
    my $t2 = $t;
    # the offset changes all time components and causes overflow/underflow
    my $offset = ((((7*31+1)*24+10)*60+21)*60+21);
    for 1, 2, 3 {
        $t1 -= $offset;
        my $dt = DateTime.new($t1);
        is show-dt($dt), join(' ', test-gmtime $t1), "crosscheck $dt";
        is show-dt($dt), show-dt(EVAL $dt.perl), ".perl round-tripping with $dt";
        $t2 += $offset;
        $dt = DateTime.new($t2);
        is show-dt($dt), join(' ', test-gmtime $t2), "crosscheck $dt";
        is show-dt($dt), show-dt(EVAL $dt.perl), ".perl round-tripping with $dt";
    }
}

{
    my $dt = DateTime.new(946684799,
        timezone => -(5*60*60 + 55*60),
        formatter => { .day ~ '/' ~ .month ~ '/' ~ .year ~ ' ' ~
                       .second ~ 's' ~ .minute ~ 'm' ~ .hour ~ 'h' });
    is ~$dt, '31/12/1999 59s4m18h', 'DateTime.new(Int) with time zone and formatter';
}

# L<S32::Temporal/C<DateTime>/'Ambiguous POSIX times'>

is show-dt(DateTime.new(915148800)), '0 0 0 1 1 1999 5', 'from POSIX at 1999-01-01T00:00:00Z';
  # 915148800 is also the POSIX time of the leap second
  # 1998-12-31T23:59:60.
is show-dt(DateTime.new(425865600)), '0 0 0 1 7 1983 5', 'from POSIX at 1983-07-01T00:00:00Z';
  # 425865600 is also the POSIX time of the leap second
  # 1983-06-30T23:59:60.

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'A shorter way to send in date'>
# DateTime.new(Str)
# --------------------------------------------------------------------

is ds('2009-12-31T22:33:44Z'), '2009-12-31T22:33:44Z', 'round-tripping ISO 8601 (Z)';
is ds('2009-12-31T22:33:44+0000'), '2009-12-31T22:33:44Z', 'round-tripping ISO 8601 (+0000 to Z)';
is ds('2009-12-31T22:33:44+1100'), '2009-12-31T22:33:44+11:00', 'round-tripping ISO 8601 (+1100)';
is ds('2009-12-31T22:33:44'), '2009-12-31T22:33:44Z', 'DateTime.new(Str) defaults to UTC';
is DateTime.new('2009-12-31T22:33:44',
        timezone => 12*60*60 + 34*60),
    '2009-12-31T22:33:44+12:34', 'DateTime.new(Str) with :timezone';
is DateTime.new('2009-12-31T22:33:44',
        formatter => { ($^dt.hour % 12) ~ 'ish' } ),
    '10ish', 'DateTime.new(Str) with formatter';

# additional timezone offset formats that are acceptable per ISO 8601
is ds('2012-12-22T07:02:00+12'), '2012-12-22T07:02:00+12:00', 'offset with no minutes specified';
is ds('2012-12-22T07:02:00-12'), '2012-12-22T07:02:00-12:00', 'negative offset with no minutes specified';
is ds('2012-12-22T07:02:00+12:00'), '2012-12-22T07:02:00+12:00', 'colonated offset';
is ds('2012-12-22T07:02:00-12:00'), '2012-12-22T07:02:00-12:00', 'negative colonated offset';
is ds('2012-12-22T07:02:00+12:45'), '2012-12-22T07:02:00+12:45', 'colonated non-zero offset';
is ds('2012-12-22T07:02:00-12:45'), '2012-12-22T07:02:00-12:45', 'colonated negative non-zero offset';

is ds('2012-12-22T07:02:00+00'), '2012-12-22T07:02:00Z', '+00 with no minutes';
is ds('2012-12-22T07:02:00-00'), '2012-12-22T07:02:00Z', '-00 with no minutes';
is ds('2012-12-22T07:02:00+00:00'), '2012-12-22T07:02:00Z', 'colonated +00';
is ds('2012-12-22T07:02:00-00:00'), '2012-12-22T07:02:00Z', 'colonated -00';

is ds('2015-12-11T20:41:10.5Z'), '2015-12-11T20:41:10.500000Z', 'More seconds precision';
is ds('2015-12-11T20:41:10.562000+00:00'), '2015-12-11T20:41:10.562000Z', 'More seconds precision';

dies-ok { ds('2012-12-22T07:02:00+00:') }, '+00 with trailing colon';
dies-ok { ds('2012-12-22T07:02:00+0') }, 'single digit hour +0';
dies-ok { ds('2012-12-22T07:02:00+0:') }, '+0 with trailing colon';

dies-ok { ds('2012-12-22T07:02:00+12:') }, 'dies because of trailing colon';
dies-ok { ds('2012-12-22T07:02:00+7') }, 'dies with a single digit hour offset';
dies-ok { ds('2012-12-22T07:02:00+7:') }, 'single digit hour, trailing colon';

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'truncated-to'>
# --------------------------------------------------------------------

{
    my $moon-landing = dt    # Although the seconds part is fictional.
       year => 1969, month => 7, day => 20,
       hour => 8, minute => 17, second => 32.4;
    my $dt = $moon-landing.truncated-to('second');
    is $dt.second, 32, 'DateTime.truncated-to(second)';
    $dt = $moon-landing.truncated-to('minute');
    is ~$dt, '1969-07-20T08:17:00Z', 'DateTime.truncated-to(minute)';
    $dt = $moon-landing.truncated-to('hour');
    is ~$dt, '1969-07-20T08:00:00Z', 'DateTime.truncated-to(hour)';
    $dt = $moon-landing.truncated-to('day');
    is ~$dt, '1969-07-20T00:00:00Z', 'DateTime.truncate-to(day)';
}

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'one additional constructor: now'>
# --------------------------------------------------------------------

{
    my $t = time;
    Nil while time == $t; # loop until the next second
    $t = time;
    my $dt1 = DateTime.new($t);
    my $dt2 = DateTime.now.utc;        # $dt1 and $dt2 might differ very occasionally
    is show-dt($dt1), show-dt($dt2), 'DateTime.now uses current time';

    $t = time;
    Nil while time == $t;
    $t = time;
    $dt1 = DateTime.new($t);
    $dt2 = DateTime.now(
        timezone => 22*60*60,
        formatter => { ~($^x.hour) });
    is ~$dt2, ~(($dt1.hour + 22) % 24), 'DateTime.now with time zone and formatter';

    is-approx(DateTime.now.Instant, now,
        'DateTime.now agrees with now pseudo-constant');
}

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'the method posix'>
# --------------------------------------------------------------------

{
    is dt(year => 1970).posix, 0, 'DateTime.posix (1970-01-01T00:00:00Z)';
    my $dt = dt
        year => 1970, month  => 1, day => 1,
        hour =>    1, minute => 1, second => 1;
    is $dt.posix, 3661, 'DateTime.posix (1970-01-01T01:01:01Z)';
    $dt = dt
        year => 1970, month  => 1, day => 1,
        hour =>    1, minute => 1, second => 1,
        timezone => -1*60*60 -1*60;
    is $dt.posix, 7321, 'DateTime.posix (1970-01-01T01:01:01-01:01)';
    # round-trip test for the current time
    my $t = time;
    my @t = test-gmtime $t;
    $dt = dt
        year => @t[5], month => @t[4], day => @t[3],
        hour => @t[2], minute => @t[1], second => @t[0];
    is $dt.posix, $t, "at $dt, POSIX is {$dt.posix}";
}

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The method whole-second'>
# --------------------------------------------------------------------

is dt(second => 22).whole-second, 22, 'DateTime.whole-second (22)';
is dt(second => 22.1).whole-second, 22, 'DateTime.whole-second (22.1)';
is dt(second => 15.9).whole-second, 15, 'DateTime.whole-second (15.9)';
is dt(second => 0).whole-second, 0, 'DateTime.whole-second (0)';
is dt(second => 0.9).whole-second, 0, 'DateTime.whole-second (0.9)';
is ds('1997-06-30T23:59:60Z').whole-second, 60, 'DateTime.whole-second (60)';

{
    my $dt = dt year => 1997, month => 6, day => 30,
                hour => 23, minute => 59, second => 60.5;
    is $dt.whole-second, 60, 'DateTime.whole-second (60.5)';
}

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The Date method'>
# --------------------------------------------------------------------

{
    my $dt = ymd 2010, 6, 4;
    my $date;
    lives-ok { $date = $dt.Date(); }, 'DateTime.Date';
    isa-ok $date, Date, 'Date object is correct class';
    is $date.year, 2010, 'Date year';
    is $date.month, 6, 'Date month';
    is $date.day, 4, 'Date day';
}

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The method offset'>
# --------------------------------------------------------------------

is tz(    'Z').offset,      0, 'DateTime.offset (Z)';
is tz('+0000').offset,      0, 'DateTime.offset (+0000)';
is tz('-0000').offset,      0, 'DateTime.offset (-0000)';
is tz('+0015').offset,    900, 'DateTime.offset (+0015)';
is tz('-0015').offset,   -900, 'DateTime.offset (-0015)';
is tz('+0700').offset,  25200, 'DateTime.offset (+0700)';
is tz('-0700').offset, -25200, 'DateTime.offset (-0700)';
is tz('+1433').offset,  52380, 'DateTime.offset (+1433)';
is tz('-1433').offset, -52380, 'DateTime.offset (-1433)';
is dt(timezone => 3661).offset, 3661, 'DateTime.offset (1 hour, 1 minute, 1 second)';

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/in-timezone>
# --------------------------------------------------------------------

{
    sub with-tz($dt, $hours, $minutes=0, $seconds=0) {
        $dt.in-timezone($hours*60*60 + $minutes*60 + $seconds);
    }
    sub hms($dt) {
        $dt.hour ~ ',' ~ $dt.minute ~ ',' ~ $dt.second
    }

    my $dt = with-tz(tz('+0200'), 4);
    is ~$dt, '2005-02-04T17:25:00+04:00', 'DateTime.in-timezone (adding hours)';
    $dt = with-tz(tz('+0000'), -1);
    is ~$dt, '2005-02-04T14:25:00-01:00', 'DateTime.in-timezone (subtracting hours)';
    $dt = with-tz(tz('-0100'), 0);
    is ~$dt, '2005-02-04T16:25:00Z', 'DateTime.in-timezone (-0100 to UTC)';
    $dt = tz('-0100').utc;
    is ~$dt, '2005-02-04T16:25:00Z', 'DateTime.utc (from -0100)';
    $dt = with-tz(tz('+0100'), -1);
    is ~$dt, '2005-02-04T13:25:00-01:00', 'DateTime.in-timezone (+ hours to - hours)';
    $dt = with-tz(tz('-0200'), -5);
    is ~$dt, '2005-02-04T12:25:00-05:00', 'DateTime.in-timezone (decreasing negative hours)';
    $dt = with-tz(tz('+0000'), 0, -13);
    is ~$dt, '2005-02-04T15:12:00-00:13', 'DateTime.in-timezone (negative minutes)';
    $dt = with-tz(tz('+0000'), 0, 0, -5);
    is hms($dt), '15,24,55', 'DateTime.in-timezone (negative seconds)';
    $dt = with-tz(tz('+0000'), 0, -27);
    is ~$dt, '2005-02-04T14:58:00-00:27', 'DateTime.in-timezone (hour rollover 1)';
    $dt = with-tz(tz('+0000'), 0, 44);
    is ~$dt, '2005-02-04T16:09:00+00:44', 'DateTime.in-timezone (hour rollover 2)';
    $dt = with-tz(tz('+0311'), -2, -27);
    is ~$dt, '2005-02-04T09:47:00-02:27', 'DateTime.in-timezone (hours and minutes)';
    $dt = with-tz(tz('+0311'), -2, -27, -19);
    is hms($dt), '9,46,41', 'DateTime.in-timezone (hours, minutes, and seconds)';
    $dt = with-tz(tz('+0000'), -18, -55);
    is ~$dt, '2005-02-03T20:30:00-18:55', 'DateTime.in-timezone (one-day rollover)';
    $dt = with-tz(tz('-1611'), 16, 55);
    is ~$dt, '2005-02-06T00:31:00+16:55', 'DateTime.in-timezone (two-day rollover)';
    $dt = with-tz(ds('2005-01-01T02:22:00+0300'), 0, 35);
    is ~$dt, '2004-12-31T23:57:00+00:35', 'DateTime.in-timezone (year rollover)';

    $dt = with-tz(dt(second => 15.5), 0, 0, 5);
    is $dt.second, 20.5, 'DateTime.in-timezone (fractional seconds)';

    $dt = dt(year => 2005, month => 1, day => 3,
             hour => 2, minute => 22, second => 4,
             timezone => 13).in-timezone(-529402);
      # A difference from UTC of 6 days, 3 hours, 3 minutes, and
      # 22 seconds.
    is show-dt($dt), '29 18 23 27 12 2004 1', 'DateTime.in-timezone (big rollover)';

}

# --------------------------------------------------------------------
# Miscellany
# --------------------------------------------------------------------

# RT #77910
# Ensure that any method of producing a DateTime keeps attributes
# that should be Ints Ints.
{
    isa-ok dt(second => 1/3).year, Int, 'DateTime.new(...).year isa Int';
    isa-ok dt(second => 1/3).hour, Int, 'DateTime.new(...).hour isa Int';
    isa-ok dt(hour => 13, second => 1/3).hour, Int, 'DateTime.new(..., hour => 13).hour isa Int';
    isa-ok dtc(second => 1/3).year, Int, '$dt.clone(...).year isa Int';
    isa-ok dtc(second => 1/3).hour, Int, '$dt.clone(...).hour isa Int';
    isa-ok dtc(hour => 13, second => 1/3).hour, Int, '$dt.clone(..., hour => 13).hour isa Int';
    isa-ok DateTime.new(5).year, Int, 'DateTime.new(Int).year isa Int';
    isa-ok DateTime.new(5).hour, Int, 'DateTime.new(Int).hour isa Int';
    isa-ok DateTime.new(now).year, Int, 'DateTime.new(Instant).year isa Int';
    isa-ok DateTime.new(now).hour, Int, 'DateTime.new(Instant).hour isa Int';
    isa-ok ds('2005-02-04T15:25:00Z').year, Int, 'ds(Str).year isa Int';
    isa-ok ds('2005-02-04T15:25:00Z').hour, Int, 'ds(Str).hour isa Int';
    isa-ok dt.in-timezone(60*60).year, Int, 'dt.in-timezone(Int).year isa Int';
    isa-ok dt.in-timezone(60*60).hour, Int, 'dt.in-timezone(Int).hour isa Int';
    isa-ok dt.truncated-to('week').year, Int, 'dt.truncated-to(week).year isa Int';
    isa-ok dt.truncated-to('week').hour, Int, 'dt.truncated-to(week).hour isa Int';
    isa-ok DateTime.now.year, Int, 'DateTime.now.year isa Int';
    isa-ok DateTime.now.hour, Int, 'DateTime.now.hour isa Int';
}

is DateTime.now.Date, Date.today,
    'coercion to Date (this test can fail if run exactly at midnight)';

{
    is ds('2013-12-23T12:34:36Z').later(second => 1),
       ds('2013-12-23T12:34:37Z'),
       'adding 1 second';

    is ds('2013-12-23T12:34:36Z').later(seconds => 10),
       ds('2013-12-23T12:34:46Z'),
       'adding 10 seconds';

    is ds('2013-12-23T12:34:56Z').later(seconds => 14),
       ds('2013-12-23T12:35:10Z'),
       'adding 14 seconds, overflowing to minutes';

    is ds('2013-12-23T12:59:56Z').later(seconds => 74),
       ds('2013-12-23T13:01:10Z'),
       'adding 74 seconds, overflowing to hours';

    is ds('2013-12-23T23:59:59Z').later(second => 1),
       ds('2013-12-24T00:00:00Z'),
       'adding 1 second, overflowing to days';

    is ds('2013-12-31T23:59:59Z').later(second => 1),
       ds('2014-01-01T00:00:00Z'),
       'adding 1 second, overflowing to years';

    is ds('2012-06-30T23:59:59Z').later(second => 1),
       ds('2012-06-30T23:59:60Z'),
       'delting to a leap second';

    is ds('2008-12-31T23:59:60Z').later(second => 1),
       ds('2009-01-01T00:00:00Z'),
       'delting from a leap second';

    is ds('2013-12-23T12:34:36Z').later(minute => 1),
       ds('2013-12-23T12:35:36Z'),
       'adding 1 minute';

    is ds('2013-12-23T12:34:36Z').later(minutes => 10),
       ds('2013-12-23T12:44:36Z'),
       'adding 10 minutes';

    is ds('2013-12-23T12:56:34Z').later(minutes => 14),
       ds('2013-12-23T13:10:34Z'),
       'adding 14 minutes, overflowing to hours';

    is ds('2013-12-23T12:34:36Z').later(hour => 1),
       ds('2013-12-23T13:34:36Z'),
       'adding 1 hour';

    is ds('2013-12-23T12:34:36Z').later(hours => 10),
       ds('2013-12-23T22:34:36Z'),
       'adding 10 hours';

    is ds('2013-12-23T12:56:34Z').later(hours => 14),
       ds('2013-12-24T02:56:34Z'),
       'adding 14 hours, overflowing to days';

    is ds('2013-12-23T12:34:36Z').later(day => 1),
       ds('2013-12-24T12:34:36Z'),
       'adding 1 day';

    is ds('2014-01-31T12:34:36Z').later(day => 1),
       ds('2014-02-01T12:34:36Z'),
       'adding 1 day, overflowing to February';

    is ds('2014-02-28T12:56:34Z').later(days => 2),
       ds('2014-03-02T12:56:34Z'),
       'adding 2 days, overflowing to March';

    is ds('2008-12-31T23:59:60Z').later(day => 1),
       ds('2009-01-01T23:59:59Z'),
       'adding a day to a leap second clips';

    is ds('1972-12-31T23:59:60Z').later(year => 1),
       ds('1973-12-31T23:59:60Z'),
       'adding a year to a leap second, landing on another leap second';

    is ds('2013-12-23T12:34:36Z').later(week => 1),
       ds('2013-12-30T12:34:36Z'),
       'adding 1 week';

    is ds('2014-01-31T12:34:36Z').later(week => 1),
       ds('2014-02-07T12:34:36Z'),
       'adding 1 week, overflowing to February';

    is ds('2014-02-28T12:56:34Z').later(weeks => 2),
       ds('2014-03-14T12:56:34Z'),
       'adding 2 weeks, overflowing to March';

    is ds('2014-12-30T12:56:34Z').later(weeks => 3),
       ds('2015-01-20T12:56:34Z'),
       'adding 3 weeks, overflowing to years';

    is ds('2013-12-23T12:34:37Z').earlier(second => 1),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 second';

    is ds('2013-12-23T12:34:46Z').earlier(seconds => 10),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 seconds';

    is ds('2013-12-23T12:35:10Z').earlier(seconds => 14),
       ds('2013-12-23T12:34:56Z'),
       'subtracting 14 seconds, overflowing to minutes';

    is ds('2013-12-23T13:01:10Z').earlier(seconds => 74),
       ds('2013-12-23T12:59:56Z'),
       'subtracting 74 seconds, overflowing to hours';

    is ds('2013-12-24T00:00:00Z').earlier(second => 1),
       ds('2013-12-23T23:59:59Z'),
       'subtracting 1 second, overflowing to days';

    is ds('2014-01-01T00:00:00Z').earlier(second => 1),
       ds('2013-12-31T23:59:59Z'),
       'subtracting 1 second, overflowing to years';

    is ds('2013-12-23T12:35:36Z').earlier(minute => 1),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 minute';

    is ds('2013-12-23T12:44:36Z').earlier(minutes => 10),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 minutes';

    is ds('2013-12-23T13:10:34Z').earlier(minutes => 14),
       ds('2013-12-23T12:56:34Z'),
       'subtracting 14 minutes, overflowing to hours';

    is ds('2013-12-23T13:34:36Z').earlier(hour => 1),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 hour';

    is ds('2013-12-23T22:34:36Z').earlier(hours => 10),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 hours';

    is ds('2013-12-24T02:56:34Z').earlier(hours => 14),
       ds('2013-12-23T12:56:34Z'),
       'subtracting 14 hours, overflowing to days';

    is ds('2013-12-24T12:34:36Z').earlier(day => 1),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 day';

    is ds('2014-02-01T12:34:36Z').earlier(day => 1),
       ds('2014-01-31T12:34:36Z'),
       'subtracting 1 day, overflowing to February';

    is ds('2014-03-02T12:56:34Z').earlier(days => 2),
       ds('2014-02-28T12:56:34Z'),
       'subtracting 2 days, overflowing to March';

    is ds('2013-12-30T12:34:36Z').earlier(week => 1),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 week';

    is ds('2014-02-07T12:34:36Z').earlier(week => 1),
       ds('2014-01-31T12:34:36Z'),
       'subtracting 1 week, overflowing to February';

    is ds('2014-03-14T12:56:34Z').earlier(weeks => 2),
       ds('2014-02-28T12:56:34Z'),
       'subtracting 2 weeks, overflowing to March';

    is ds('2015-01-20T12:56:34Z').earlier(weeks => 3),
       ds('2014-12-30T12:56:34Z'),
       'subtracting 3 weeks, overflowing to years';

    is ds('2008-12-31T23:59:60Z').earlier(day => 1),
       ds('2008-12-30T23:59:59Z'),
       'subtracting a day from a leap second clips';

    is ds('2009-01-01T00:00:00Z').earlier(second => 1),
       ds('2008-12-31T23:59:60Z'),
       'subtracting a second from time can land on a leap second';

    lives-ok {
        ds('2010-01-31T12:56:34Z').later(month => 1);
    }, '.later does not try to create an impossible datetime';
}

# RT #121990 Smartmatch against a Date
{
    my $now = DateTime.now;
    my $today = Date.today;
    my $not-now = ds('1971-10-28T10:45:00');

    ok $now ~~ $today, "positive smartmatch against a Date";
    ok $not-now !~~ $today, "negative smartmatch against a Date";
}

# RT #125555 Comparison ops
{
    my $d0 = ds('1971-10-28T10:45:00');
    my $d1 = $d0;
    my $d2 = ds('1998-10-19T02:03:00');

    ok $d0 == $d1,  "$d0 == $d1";
    ok $d0 != $d2,  "$d0 != $d2";
    ok $d0 <= $d1,  "$d0 <= $d1";
    ok $d0 <= $d2,  "$d0 <= $d2";
    ok $d0 < $d2,   "$d0 < $d2";
    ok $d0 >= $d1,  "$d0 >= $d1";
    ok $d2 >= $d1,  "$d2 >= $d1";
    ok $d2 > $d1,   "$d2 > $d1";
    ok ($d0 cmp $d1) == 0,  "$d0 cmp $d1 == 0";
    ok ($d0 cmp $d2) == -1, "$d0 cmp $d2 == -1";
    ok ($d2 cmp $d1) == 1,  "$d2 cmp $d1 == 1";
    ok $d0 before $d2,   "$d0 before $d2";
    ok $d2 after $d1,   "$d2 after $d1";
}

# RT #124683
throws-like { DateTime.new("1994-05-03T00:00:00+00:99") }, X::OutOfRange, what => rx{minute};

# RT #125872
is ds("2015-08-23T02:27:33-07:00"), ds("2015-08-23t02:27:33-07:00"), "t and T work, are same";
is ds("2015-08-23T02:27:33Z"), ds("2015-08-23t02:27:33z"), "z and Z work, are same";

# RT #125686 Date overflows
is ds('1994-05-03T12:00:00Z').later(days => 536106031).Str, "+1469802-10-18T12:00:00Z", "adding large values of days does not overflow";
is ds('2015-12-24T12:23:00Z').later(days => -537643699).Str, "-1470003-07-12T12:23:00Z", "subtracting large values days does not overflow";

# RT #127003 comma not accepted
is ds("2000-01-01T00:00:00,456"), "2000-01-01T00:00:00.456000Z",
  'second value with a comma works';

# RT #127004
is ds("+9992000-01-01T00:00:00"), "+9992000-01-01T00:00:00Z",
  'large value of year in string works';
is ds("-4004-10-23T00:00:00"), "-4004-10-23T00:00:00Z",
  'negative value of year in string works';

# problem labster++ found
is DateTime.new(127317232781632218937129), "+4034522497029953-07-13T17:38:49Z",
  'very large value for epoch';

# problem lizmat found
is ds("2016-02-29T00:00:00").later(:1year), "2017-02-28T00:00:00Z",
  'moving a year from a leap-date into a year without leap-date';

# RT #127170
{
    my role Foo { has @.a = 7, 8, 9 }
    my class BarDate is DateTime does Foo {}
    is-deeply BarDate.now.a, [7, 8, 9],
        'did role attributes get initialized ok';
}

{
    my class FooDateTime is DateTime { has $.foo };
    for (2016,2,20,21,53,7),
        '2016-02-20T21:53:07',
        \(:2016year,:2month,:20day,:21hour,:53minute,:7second)
    -> $datetime {
        my $fdt = FooDateTime.new(|$datetime, foo => 42);
        isa-ok    $fdt, FooDateTime, 'created object is of right type';
        isa-ok    $fdt, DateTime,    'created object is a subclass';
        is-deeply $fdt.year, 2016,   'is year in FooDateTime ok';
        is-deeply $fdt.month,   2,   'is month in FooDateTime ok';
        is-deeply $fdt.day,    20,   'is day in FooDateTime ok';
        is-deeply $fdt.hour,   21,   'is hour in FooDateTime ok';
        is-deeply $fdt.minute, 53,   'is minute in FooDateTime ok';
        is-deeply $fdt.second,  7,   'is second in FooDateTime ok';
        is-deeply $fdt.foo,    42,   'is foo in FooDateTime ok';
    }
}

# RT #128545
subtest 'synthetics not allowed in date formats' => {
    throws-like { DateTime.new: "20\x[308]16-07-05T00:00:00+01:00" },
        X::Temporal::InvalidFormat, 'DateTime.new (+01:00 format)';

    throws-like { DateTime.new: "2016-07-05T00:0\x[308]0:00Z" },
        X::Temporal::InvalidFormat, 'DateTime.new (Z format)';
}

{ # coverage; 2019-10-03
    subtest 'DateTime.offset-in-hours' => {
        plan 9;

        my $d = '2016-10-03T20:20:20';
        is DateTime.new($d ~ '+00:00').offset-in-hours,  0,      'UTC';
        is DateTime.new($d ~ '+01:00').offset-in-hours,  1,      '+1';
        is DateTime.new($d ~ '-01:00').offset-in-hours, -1,      '-1';
        is DateTime.new($d ~ '+04:30').offset-in-hours,  4.5,    '+4:30';
        is DateTime.new($d ~ '-04:30').offset-in-hours, -4.5,    '-4:30';
        is DateTime.new($d ~ '+04:05').offset-in-hours,  4+1/12, '+4:05';
        is DateTime.new($d ~ '-04:05').offset-in-hours, -4-1/12, '-4:05';
        is DateTime.new($d ~ '+42:30').offset-in-hours,  42.5,   '+42:30';
        is DateTime.new($d ~ '-42:30').offset-in-hours, -42.5,   '-42:30';
    }

    subtest 'DateTime <=> DateTime' => {
        plan 21;

        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Same,
            'Same (same offsets)';
        is  DateTime.new('1986-02-22T21:22:22+21:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Same,
            'Same (LHS has smaller offset)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T21:22:22+21:22'), Order::Same,
            'Same (RHS has smaller offset)';
        is  DateTime.new('1986-02-24T22:22:22+48:22') <=>
            DateTime.new('1986-02-20T22:22:22-47:38'), Order::Same,
            'Same (multi-day difference in offsets)';

        is  DateTime.new('1985-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different years)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1985-02-22T22:22:22+22:22'), Order::More,
            'More (different years)';

        is  DateTime.new('1986-01-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different months)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-01-22T22:22:22+22:22'), Order::More,
            'More (different months)';

        is  DateTime.new('1986-02-21T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different days)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-21T22:22:22+22:22'), Order::More,
            'More (different days)';

        is  DateTime.new('1986-02-22T21:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different hours)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T21:22:22+22:22'), Order::More,
            'More (different hours)';

        is  DateTime.new('1986-02-22T22:21:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different minutes)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:21:22+22:22'), Order::More,
            'More (different minutes)';

        is  DateTime.new('1986-02-22T22:22:21+22:22') <=>
            DateTime.new('1986-02-22T22:22:22+22:22'), Order::Less,
            'Less (different seconds)';
        is  DateTime.new('1986-02-22T22:22:22+22:22') <=>
            DateTime.new('1986-02-22T22:22:21+22:22'), Order::More,
            'More (different seconds)';

        is  DateTime.new('2016-12-31T23:59:59Z') <=>
            DateTime.new('2016-12-31T23:59:60Z'), Order::Less,
            'Less (leap seconds)';
        is  DateTime.new('2017-01-01T00:00:00Z') <=>
            DateTime.new('2016-12-31T23:59:60Z'), Order::More,
            'Moar (leap seconds)';

        # This behaviour is per RFC7164, section 3:
        # https://tools.ietf.org/html/rfc7164#section-3
        # The leap second always happens in UTC and the 60th second
        # in other timezones occurs in whatever hour UTC's second happens
        is  DateTime.new('2017-01-01T00:00:00Z') <=> DateTime.new('2016-12-31T23:00:00-01:00'), Order::Same,
            'Same (leap seconds) (1)';
        is  DateTime.new('2016-12-31T23:59:60Z') <=> DateTime.new('2016-12-31T22:59:60-01:00'), Order::Same,
            'Same (leap seconds) (2)';
        #?rakudo skip 'Cannot parse leap on non-23:59'
        is  DateTime.new('2016-12-31T23:59:60Z') <=> DateTime.new('2017-01-01T01:00:60+01:00'), Order::Same,
            'Same (leap seconds) (3)';
    }
}

# This behaviour is per RFC7164, section 3:
# https://tools.ietf.org/html/rfc7164#section-3
# The leap second always happens in UTC and the 60th second
# in other timezones occurs in whatever hour UTC's second happens
subtest 'can parse leap second in non-UTC timezones' => {
    my \h := 3600;
    plan +my @tzs = flat (
        10000, 100*h, 30*h, 24*h, 12*h, 3*h, 0, .5*h, 123, 432, 1
    ).map: {-$_, $_}

    my \utc := DateTime.new: '2016-12-31T23:59:60Z';
    for @tzs {
        #?rakudo skip 'Cannot parse leap on non-23:59'
        cmp-ok $d, '==', utc, "parsed correct date for .in-timezone($_)";
    }
}

{
    my $dt = DateTime.now;
    subtest 'DateTime:D.Date returns correct date' => {
        plan 4;

        cmp-ok    $dt.Date, '~~', Date:D,    '.Date returns Date:D';
        is-deeply $dt.Date.year,  $dt.year,  '.year is right';
        is-deeply $dt.Date.month, $dt.month, '.month is right';
        is-deeply $dt.Date.day,   $dt.day,   '.day is right';
    }
    is-deeply DateTime.Date,     Date, 'DateTime:U.Date returns Date:U';
    is-deeply DateTime.DateTime, DateTime, 'DateTime:U.DateTime returns self';
    is-deeply      $dt.DateTime, $dt,     'DateTime:D.DateTime returns self';
}

subtest '.hh-mm-ss' => {
    plan 5;

    is-deeply Date.today.DateTime.hh-mm-ss, '00:00:00', 'Date -> DateTime';
    is-deeply DateTime.new('2006-01-01T00:00:00Z').earlier(:1second).hh-mm-ss,
              '23:59:60', 'leap second';

    my $d = DateTime.new(4242);
    is-deeply $d.hh-mm-ss, '01:10:42', 'posix 4242';
    is-deeply $d.later(:13hours).hh-mm-ss, '14:10:42', '13 hours later';
    is-deeply $d.earlier(:50hours).hh-mm-ss, '23:10:42', '50 hours earlier';
}

# https://github.com/rakudo/rakudo/commit/9eed2768d4751b4585bbd335016ca0d9ef
throws-like { DateTime.new: :2016year, 42 }, Exception,
    'unexpected named arg with positional arg to .new throws';

{ # https://github.com/rakudo/rakudo/commit/6b850babd5
    constant $dt1 = DateTime.new: :2017year, :11month, :15day, :18hour,
        :36minute, :second(17.25), :timezone(-5*3600);
    constant $dt2 = DateTime.new: :2015year, :12month, :25day, :3hour,
        :6minute,  :second(7.77),  :timezone(14*3600);
    constant $dur = Duration.new: 59826610.48;

    is-deeply $dt1 - $dt2, $dur, 'DateTime - DateTime = Duration';
    is-deeply $dt1 - $dur, $dt2.in-timezone($dt1.timezone),
        'DateTime - Duration = DateTime';

    is-deeply $dt1 − $dt2, $dur, 'DateTime − DateTime = Duration(U+2212 minus)';
    is-deeply $dt1 − $dur, $dt2.in-timezone($dt1.timezone),
        'DateTime − Duration = DateTime(U+2212 minus)';

    is-deeply $dt2 + $dur, $dt1.in-timezone($dt2.timezone),
        'DateTime + Duration = DateTime';
    is-deeply $dur + $dt2, $dt1.in-timezone($dt2.timezone),
        'Duration + DateTime = DateTime';
}

# comparison operators

{
    my $dt1 = DateTime.now;
    my $dt2 = $dt1.later(:1hour);
     ok $dt1 <  $dt2, 'DateTime <  DateTime';
     ok $dt1 <= $dt2, 'DateTime <= DateTime';
    nok $dt1 == $dt2, 'DateTime == DateTime';
     ok $dt1 != $dt2, 'DateTime != DateTime';
    nok $dt1 >  $dt2, 'DateTime >  DateTime';
    nok $dt1 >= $dt2, 'DateTime >= DateTime';
}

# https://github.com/rakudo/rakudo/issues/1762
# https://github.com/rakudo/rakudo/issues/1760
subtest 'subsecond .later/.earlier' => {
    plan 6;
    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').later(:second(.7)),
        DateTime.new('1879-03-14T00:00:00.700Z'), '.7s later';
    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').later(:second(.007)),
        DateTime.new('1879-03-14T00:00:00.007Z'), '.007s later';
    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').later(:second(2.707)),
        DateTime.new('1879-03-14T00:00:02.707Z'), '2.707s later';

    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').earlier(:second(.7)),
        DateTime.new('1879-03-13T23:59:59.300Z'), '.7s earlier';
    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').earlier(:second(.007)),
        DateTime.new('1879-03-13T23:59:59.993Z'), '.007s earlier';
    is-deeply
        DateTime.new('1879-03-14T00:00:00.000Z').earlier(:second(2.707)),
        DateTime.new('1879-03-13T23:59:57.293Z'), '2.707s earlier';
}
