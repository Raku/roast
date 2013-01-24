use v6;
use Test;

plan 216;

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

isa_ok time, Int, 'time returns an Int';

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/immutable>
# --------------------------------------------------------------------

{
    my $dt = ymd 1999, 5, 6;
    dies_ok { $dt.year = 2000 }, 'DateTimes are immutable (1)';
    dies_ok { $dt.minute = 30 }, 'DateTimes are immutable (2)';
    dies_ok { $dt.timezone = 0 }, 'DateTimes are immutable (3)';
    dies_ok { $dt.formatter = { $dt.hour } }, 'DateTimes are immutable (4)';
}

# --------------------------------------------------------------------
# Input validation
# --------------------------------------------------------------------

# L<S32::Temporal/C<DateTime>/outside of the ranges specified>

lives_ok { dt month => 1 }, 'DateTime accepts January';
dies_ok  { dt month => 0 }, 'DateTime rejects month 0';
dies_ok  { dt month => -1 }, 'DateTime rejects month -1';
lives_ok { dt month => 12 }, 'DateTime accepts December';
dies_ok  { dt month => 13 }, 'DateTime rejects month 13';
lives_ok { dt month => 1, day => 31 }, 'DateTime accepts January 31';
dies_ok  { dt month => 1, day => 32 }, 'DateTime rejects January 32';
lives_ok { dt month => 6, day => 30 }, 'DateTime accepts June 30';
dies_ok  { dt month => 6, day => 31 }, 'DateTime rejects June 31';
dies_ok  { dt month => 2, day => 30 }, 'DateTime rejects February 30';
lives_ok { ymd 1996, 2, 29 }, 'DateTime accepts 29 Feb 1996';
dies_ok  { ymd 1995, 2, 29 }, 'DateTime rejects 29 Feb 1995';
lives_ok { ymd 2000, 2, 29 }, 'DateTime accepts 29 Feb 2000';
lives_ok { ymdc 2000, 2, 29 }, 'DateTime accepts 29 Feb 2000 (clone)';
lives_ok { ds '2000-02-29T22:33:44' }, 'DateTime accepts 29 Feb 2000 (ISO)';
dies_ok  { ymd 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900';
dies_ok  { ymdc 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900 (clone)';
dies_ok  { ds '1900-02-29T22:33:44' }, 'DateTime rejects 29 Feb 1900 (ISO)';
lives_ok { dt hour => 0 }, 'DateTime accepts hour 0';
dies_ok  { dt hour => -1 }, 'DateTime rejects hour 0';
lives_ok { dt hour => 23 }, 'DateTime accepts hour 23';
dies_ok  { dt hour => 24 }, 'DateTime rejects hour 24';
lives_ok { dt minute => 0 }, 'DateTime accepts minute 0';
dies_ok  { dt minute => -1 }, 'DateTime rejects minute -1';
lives_ok { dt minute => 59 }, 'DateTime accepts minute 59';
lives_ok { dtc minute => 59 }, 'DateTime accepts minute 59 (clone)';
lives_ok { ds '1999-01-01T00:59:22' }, 'DateTime accepts minute 59 (ISO)';
lives_ok { DateTime.new: date => Date.new(1999, 1, 1), minute => 59 }, 'DateTime accepts minute 59 (with Date)';
dies_ok  { dt minute => 60 }, 'DateTime rejects minute 60';
dies_ok  { dtc minute => 60 }, 'DateTime rejects minute 60 (clone)';
dies_ok  { ds '1999-01-01T00:60:22' }, 'DateTime rejects minute 60 (ISO)';
dies_ok  { dt date => Date.new(1999, 1, 1), minute => 60 }, 'DateTime rejects minute 60 (with Date)';
lives_ok { dt second => 0 }, 'DateTime accepts second 0';
lives_ok { dt second => 1/2 }, 'DateTime accepts second 1/2';
dies_ok  { dt second => -1 }, 'DateTime rejects second -1';
dies_ok  { dt second => -1/2 }, 'DateTime rejects second -1/2';
lives_ok { dt second => 59.5 }, 'DateTime accepts second 59.5';
lives_ok { dtc second => 59.5 }, 'DateTime accepts second 59.5 (clone)';
dies_ok  { dt second => 62 }, 'DateTime rejects second 62';
dies_ok  { dtc second => 62 }, 'DateTime rejects second 62 (clone)';
dies_ok  { ds '1999-01-01T12:10:62' }, 'DateTime rejects second 62 (ISO)';
dies_ok  { dt date => Date.new(1999, 1, 1), second => 62 }, 'DateTime rejects second 62 (with Date)';

# Validate leap seconds.

dies_ok  { ds '1999-01-01T12:10:60' }, 'Leap-second validation: Wrong time and date';
dies_ok  { ds '1999-01-01T23:59:60' }, 'Leap-second validation: Wrong date';
dies_ok  { ds '1999-06-30T23:59:60' }, 'Leap-second validation: Wrong year (1)';
dies_ok  { ds '1999-12-31T23:59:60' }, 'Leap-second validation: Wrong year (2)';
dies_ok  { ds '1998-06-30T23:59:60' }, 'Leap-second validation: Wrong; June 30 on a year with a leap second in December 31';
dies_ok  { ds '1998-12-31T23:58:60' }, 'Leap-second validation: Wrong minute';
dies_ok  { ds '1998-12-31T22:59:60' }, 'Leap-second validation: Wrong hour';
lives_ok { ds '1998-12-31T23:59:60' }, 'Leap-second validation: Okay; December 31';
dies_ok  { ds '1997-12-31T23:59:60' }, 'Leap-second validation: Wrong; December 31 on a year with a leap second in June 30';
dies_ok  { dt year => 1997, month => 12, day => 31,
              hour => 23, minute => 59, second => 60.9 }, 'Leap-second validation: Wrong; December 31 on a year with a leap second in June 30 (second 60.9)';
lives_ok { ds '1997-06-30T23:59:60' }, 'Leap-second validation: Okay; June 30';
lives_ok { dt year => 1997, month => 6, day => 30,
              hour => 23, minute => 59, second => 60.9 }, 'Leap-second validation: Okay; June 30 (second 60.9)';
dies_ok  { ds '1997-06-30T23:59:61' }, 'Leap-second validation: Wrong; there are no seconds 61 (in the 20th century, anyway).';

dies_ok  { ds '1998-12-31T23:59:60+0200' }, 'Leap-second validation: Wrong because of TZ; December 31';
lives_ok { ds '1999-01-01T01:59:60+0200' }, 'Leap-second validation: Okay because of TZ; January 1';
dies_ok  { ds '1997-06-30T23:59:60-0200' }, 'Leap-second validation: Wrong because of TZ; June 30';
lives_ok { ds '1997-06-30T21:59:60-0200' }, 'Leap-second validation: Okay because of TZ; June 30';
dies_ok  { dt year => 1998, month => 12, day => 31,
              hour => 23, minute => 59, second => 60.9,
              timezone => 2*60*60 }, 'Leap-second validation: Wrong because of TZ; December 31 (second 60.9)';
lives_ok { dt year => 1999, month => 1, day => 1,
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
        is show-dt($dt), show-dt(eval $dt.perl), ".perl round-tripping with $dt";
        $t2 += $offset;
        $dt = DateTime.new($t2);
        is show-dt($dt), join(' ', test-gmtime $t2), "crosscheck $dt";
        is show-dt($dt), show-dt(eval $dt.perl), ".perl round-tripping with $dt";
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
is ds('2009-12-31T22:33:44+1100'), '2009-12-31T22:33:44+1100', 'round-tripping ISO 8601 (+1100)';
is ds('2009-12-31T22:33:44'), '2009-12-31T22:33:44Z', 'DateTime.new(Str) defaults to UTC';
is DateTime.new('2009-12-31T22:33:44',
        timezone => 12*60*60 + 34*60),
    '2009-12-31T22:33:44+1234', 'DateTime.new(Str) with :timezone';
is DateTime.new('2009-12-31T22:33:44',
        formatter => { ($^dt.hour % 12) ~ 'ish' } ),
    '10ish', 'DateTime.new(Str) with formatter';

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'truncated-to'>
# --------------------------------------------------------------------

{
    my $moon-landing = dt    # Although the seconds part is fictional.
       year => 1969, month => 7, day => 20,
       hour => 8, minute => 17, second => 32.4;
    my $dt = $moon-landing.truncated-to(:second);
    is $dt.second, 32, 'DateTime.truncated-to(:second)';
    $dt = $moon-landing.truncated-to(:minute);
    is ~$dt, '1969-07-20T08:17:00Z', 'DateTime.truncated-to(:minute)';
    $dt = $moon-landing.truncated-to(:hour);
    is ~$dt, '1969-07-20T08:00:00Z', 'DateTime.truncated-to(:hour)';
    $dt = $moon-landing.truncated-to(:day);
    is ~$dt, '1969-07-20T00:00:00Z', 'DateTime.truncate-to(:day)';
}

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'one additional constructor: now'>
# --------------------------------------------------------------------

{
    my $t = time;
    1 while time == $t; # loop until the next second
    $t = time;
    my $dt1 = DateTime.new($t);
    my $dt2 = DateTime.now.utc;        # $dt1 and $dt2 might differ very occasionally
    #?rakudo todo 'nom regression'
    is show-dt($dt1), show-dt($dt2), 'DateTime.now uses current time';

    $t = time;
    1 while time == $t;
    $t = time;
    $dt1 = DateTime.new($t);
    $dt2 = DateTime.now(
        timezone => 22*60*60,
        formatter => { ~($^x.hour) });
    is ~$dt2, ~(($dt1.hour + 22) % 24), 'DateTime.now with time zone and formatter';
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
    is $dt.posix, 7321, 'DateTime.posix (1970-01-01T01:01:01-0101)';
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
    lives_ok { $date = $dt.Date(); }, 'DateTime.Date';
    isa_ok $date, Date, 'Date object is correct class';
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

{
    my $tz = sub ($dt, $to-utc) {
        $to-utc
          ?? $dt.year == 2001 ?? 1 !! 2
          !! 3
    };
    my $dt = dt year => 2001, timezone => $tz;
    is $dt.offset, 1, 'DateTime.offset (function, 1)';
    $dt = dt year => 2000, timezone => $tz;
    is $dt.offset, 2, 'DateTime.offset (function, 2)';
}

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
    is ~$dt, '2005-02-04T17:25:00+0400', 'DateTime.in-timezone (adding hours)';
    $dt = with-tz(tz('+0000'), -1);
    is ~$dt, '2005-02-04T14:25:00-0100', 'DateTime.in-timezone (subtracting hours)';
    $dt = with-tz(tz('-0100'), 0);
    is ~$dt, '2005-02-04T16:25:00Z', 'DateTime.in-timezone (-0100 to UTC)';
    $dt = tz('-0100').utc;
    is ~$dt, '2005-02-04T16:25:00Z', 'DateTime.utc (from -0100)';
    $dt = with-tz(tz('+0100'), -1);
    is ~$dt, '2005-02-04T13:25:00-0100', 'DateTime.in-timezone (+ hours to - hours)';
    $dt = with-tz(tz('-0200'), -5);
    is ~$dt, '2005-02-04T12:25:00-0500', 'DateTime.in-timezone (decreasing negative hours)';
    $dt = with-tz(tz('+0000'), 0, -13);
    is ~$dt, '2005-02-04T15:12:00-0013', 'DateTime.in-timezone (negative minutes)';
    $dt = with-tz(tz('+0000'), 0, 0, -5);
    is hms($dt), '15,24,55', 'DateTime.in-timezone (negative seconds)';
    $dt = with-tz(tz('+0000'), 0, -27);
    is ~$dt, '2005-02-04T14:58:00-0027', 'DateTime.in-timezone (hour rollover 1)';
    $dt = with-tz(tz('+0000'), 0, 44);
    is ~$dt, '2005-02-04T16:09:00+0044', 'DateTime.in-timezone (hour rollover 2)';
    $dt = with-tz(tz('+0311'), -2, -27);
    is ~$dt, '2005-02-04T09:47:00-0227', 'DateTime.in-timezone (hours and minutes)';
    $dt = with-tz(tz('+0311'), -2, -27, -19);
    is hms($dt), '9,46,41', 'DateTime.in-timezone (hours, minutes, and seconds)';
    $dt = with-tz(tz('+0000'), -18, -55);
    is ~$dt, '2005-02-03T20:30:00-1855', 'DateTime.in-timezone (one-day rollover)';
    $dt = with-tz(tz('-1611'), 16, 55);
    is ~$dt, '2005-02-06T00:31:00+1655', 'DateTime.in-timezone (two-day rollover)';
    $dt = with-tz(ds('2005-01-01T02:22:00+0300'), 0, 35);
    is ~$dt, '2004-12-31T23:57:00+0035', 'DateTime.in-timezone (year rollover)';

    $dt = with-tz(dt(second => 15.5), 0, 0, 5);
    #?rakudo todo 'nom regression'
    is $dt.second, 20.5, 'DateTime.in-timezone (fractional seconds)';

    $dt = dt(year => 2005, month => 1, day => 3,
             hour => 2, minute => 22, second => 4,
             timezone => 13).in-timezone(-529402);
      # A difference from UTC of 6 days, 3 hours, 3 minutes, and
      # 22 seconds.
    is show-dt($dt), '29 18 23 27 12 2004 1', 'DateTime.in-timezone (big rollover)';    

    # DateTime doesn't implement DST, but it ought to make
    # implementing DST possible. We test that here.

    sub nyc-tz($dt, $to-utc) { # America/New_York
        3600 * (us2007dst($dt, $to-utc ?? 2 !! 7) ?? -4 !! -5)
    }

    sub lax-tz($dt, $to-utc) { # America/Los_Angeles
        3600 * (us2007dst($dt, $to-utc ?? 2 !! 10) ?? -7 !! -8)
    }

    sub us2007dst($dt, $critical-hour) {
        my $t = ($dt.month, $dt.day, $dt.hour);
        ([or] (3, 11, $critical-hour) »<=>« $t) == 0|-1
           and ([or] $t »<=>« (11, 4, $critical-hour)) == -1
    }

    sub nyc-dt($year, $month, $day, $hour, $minute) {
        dt :$year, :$month, :$day, :$hour, :$minute,
            timezone => &nyc-tz
    }

    $dt = ds('2007-01-02T02:22:00Z').in-timezone(&nyc-tz);
    is ~$dt, '2007-01-01T21:22:00-0500', 'DateTime.in-timezone (UTC to NYC, outside of DST)';
    $dt = ds('2007-08-01T02:22:00Z').in-timezone(&nyc-tz);
    is ~$dt, '2007-07-31T22:22:00-0400', 'DateTime.in-timezone (UTC to NYC, during DST)';
    $dt = ds('2007-03-11T06:55:00Z').in-timezone(&nyc-tz);
    is ~$dt, '2007-03-11T01:55:00-0500', 'DateTime.in-timezone (UTC to NYC, just before DST)';
    $dt = ds('2007-03-11T07:02:00Z').in-timezone(&nyc-tz);
    is ~$dt, '2007-03-11T03:02:00-0400', 'DateTime.in-timezone (UTC to NYC, just after DST)';
    $dt = ds('2007-03-11T09:58:00+0303').in-timezone(&nyc-tz);
    is ~$dt, '2007-03-11T01:55:00-0500', 'DateTime.in-timezone (+0303 to NYC, just before DST)';
    $dt = ds('2007-03-10T14:50:00-1612').in-timezone(&nyc-tz);
    is ~$dt, '2007-03-11T03:02:00-0400', 'DateTime.in-timezone (-1612 to NYC, just after DST)';
    $dt = nyc-dt(2007,  1,  1,   21, 22).utc;
    is ~$dt, '2007-01-02T02:22:00Z', 'DateTime.utc (from NYC, outside of DST)';
    $dt = nyc-dt(2007,  7, 31,   22, 22).utc;
    is ~$dt, '2007-08-01T02:22:00Z', 'DateTime.utc (from NYC, during DST)';
    $dt = nyc-dt(2007,  7, 31,   22, 22).utc;
    is ~$dt, '2007-08-01T02:22:00Z', 'DateTime.utc (from NYC, during DST)';
    $dt = nyc-dt(2007,  3, 11,    1, 55).utc;
    is ~$dt, '2007-03-11T06:55:00Z', 'DateTime.utc (from NYC, just before DST)';
    $dt = with-tz(nyc-dt(2007,  3, 11,    3,  2), -16, -12);
    is ~$dt, '2007-03-10T14:50:00-1612', 'DateTime.in-timezone (NYC to -1612, just after DST)';
    $dt = nyc-dt(2007,  3, 11,    1, 55).in-timezone(&lax-tz);
    is ~$dt, '2007-03-10T22:55:00-0800', 'DateTime.in-timezone (NYC to LAX, just before NYC DST)';
    $dt = nyc-dt(2007,  3, 11,    3,  2).in-timezone(&lax-tz);
    is ~$dt, '2007-03-10T23:02:00-0800', 'DateTime.in-timezone (NYC to LAX, just after NYC DST)';
    $dt = nyc-dt(2007,  3, 11,    6,  2).in-timezone(&lax-tz);
    is ~$dt, '2007-03-11T03:02:00-0700', 'DateTime.in-timezone (NYC to LAX, just after LAX DST)';
}

# --------------------------------------------------------------------
# Miscellany
# --------------------------------------------------------------------

# RT #77910
# Ensure that any method of producing a DateTime keeps attributes
# that should be Ints Ints.
{
    isa_ok dt(second => 1/3).year, Int, 'DateTime.new(...).year isa Int';
    isa_ok dt(second => 1/3).hour, Int, 'DateTime.new(...).hour isa Int';
    isa_ok dt(hour => 13, second => 1/3).hour, Int, 'DateTime.new(..., hour => 13).hour isa Int';
    isa_ok dtc(second => 1/3).year, Int, '$dt.clone(...).year isa Int';
    isa_ok dtc(second => 1/3).hour, Int, '$dt.clone(...).hour isa Int';
    isa_ok dtc(hour => 13, second => 1/3).hour, Int, '$dt.clone(..., hour => 13).hour isa Int';
    isa_ok DateTime.new(5).year, Int, 'DateTime.new(Int).year isa Int';
    isa_ok DateTime.new(5).hour, Int, 'DateTime.new(Int).hour isa Int';
    isa_ok DateTime.new(now).year, Int, 'DateTime.new(Instant).year isa Int';
    isa_ok DateTime.new(now).hour, Int, 'DateTime.new(Instant).hour isa Int';
    isa_ok ds('2005-02-04T15:25:00Z').year, Int, 'ds(Str).year isa Int';
    isa_ok ds('2005-02-04T15:25:00Z').hour, Int, 'ds(Str).hour isa Int';
    isa_ok dt.in-timezone(60*60).year, Int, 'dt.in-timezone(Int).year isa Int';
    isa_ok dt.in-timezone(60*60).hour, Int, 'dt.in-timezone(Int).hour isa Int';
    isa_ok dt.truncated-to(:week).year, Int, 'dt.truncated-to(:week).year isa Int';
    isa_ok dt.truncated-to(:week).hour, Int, 'dt.truncated-to(:week).hour isa Int';
    isa_ok DateTime.now.year, Int, 'DateTime.now.year isa Int';
    isa_ok DateTime.now.hour, Int, 'DateTime.now.hour isa Int';
}

is DateTime.now.Date, Date.today, 'coercion to Date';

{
    is ds('2013-12-23T12:34:36Z').delta(1, second),
       ds('2013-12-23T12:34:37Z'),
       'adding 1 second';

    is ds('2013-12-23T12:34:36Z').delta(10, seconds),
       ds('2013-12-23T12:34:46Z'),
       'adding 10 seconds';

    is ds('2013-12-23T12:34:56Z').delta(14, seconds),
       ds('2013-12-23T12:35:10Z'),
       'adding 14 seconds, overflowing to minutes';

    is ds('2013-12-23T12:59:56Z').delta(74, seconds),
       ds('2013-12-23T13:01:10Z'),
       'adding 74 seconds, overflowing to hours';

    is ds('2013-12-23T23:59:59Z').delta(1, second),
       ds('2013-12-24T00:00:00Z'),
       'adding 1 second, overflowing to days';

    is ds('2013-12-31T23:59:59Z').delta(1, second),
       ds('2014-01-01T00:00:00Z'),
       'adding 1 second, overflowing to years';

    is ds('2012-06-30T23:59:59Z').delta(1, second),
       ds('2012-06-30T23:59:60Z'),
       'delting to a leap second';

    is ds('2008-12-31T23:59:60Z').delta(1, second),
       ds('2009-01-01T00:00:00Z'),
       'delting from a leap second';

    is ds('2013-12-23T12:34:36Z').delta(1, minute),
       ds('2013-12-23T12:35:36Z'),
       'adding 1 minute';

    is ds('2013-12-23T12:34:36Z').delta(10, minutes),
       ds('2013-12-23T12:44:36Z'),
       'adding 10 minutes';

    is ds('2013-12-23T12:56:34Z').delta(14, minutes),
       ds('2013-12-23T13:10:34Z'),
       'adding 14 minutes, overflowing to hours';

    is ds('2013-12-23T12:34:36Z').delta(1, hour),
       ds('2013-12-23T13:34:36Z'),
       'adding 1 hour';

    is ds('2013-12-23T12:34:36Z').delta(10, hours),
       ds('2013-12-23T22:34:36Z'),
       'adding 10 hours';

    is ds('2013-12-23T12:56:34Z').delta(14, hours),
       ds('2013-12-24T02:56:34Z'),
       'adding 14 horus, overflowing to days';

    is ds('2013-12-23T12:34:36Z').delta(1, day),
       ds('2013-12-24T12:34:36Z'),
       'adding 1 day';

    is ds('2014-01-31T12:34:36Z').delta(1, day),
       ds('2014-02-01T12:34:36Z'),
       'adding 1 day, overflowing to February';

    is ds('2014-02-28T12:56:34Z').delta(2, days),
       ds('2014-03-02T12:56:34Z'),
       'adding 2 days, overflowing to March';

    is ds('2008-12-31T23:59:60Z').delta(1, day),
       ds('2009-01-02T00:00:00Z'),
       'adding a day to a leap second';

    is ds('1972-12-31T23:59:60Z').delta(1, year),
       ds('1973-12-31T23:59:60Z'),
       'adding a year to a leap second, landing on another leap second';

    is ds('2013-12-23T12:34:36Z').delta(1, week),
       ds('2013-12-30T12:34:36Z'),
       'adding 1 week';

    is ds('2014-01-31T12:34:36Z').delta(1, week),
       ds('2014-02-07T12:34:36Z'),
       'adding 1 week, overflowing to February';

    is ds('2014-02-28T12:56:34Z').delta(2, weeks),
       ds('2014-03-14T12:56:34Z'),
       'adding 2 weeks, overflowing to March';

    is ds('2014-12-30T12:56:34Z').delta(3, weeks),
       ds('2015-01-20T12:56:34Z'),
       'adding 3 weeks, overflowing to years';

    is ds('2013-12-23T12:34:37Z').delta(-1, second),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 second';

    is ds('2013-12-23T12:34:46Z').delta(-10, seconds),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 seconds';

    is ds('2013-12-23T12:35:10Z').delta(-14, seconds),
       ds('2013-12-23T12:34:56Z'),
       'subtracting 14 seconds, overflowing to minutes';

    is ds('2013-12-23T13:01:10Z').delta(-74, seconds),
       ds('2013-12-23T12:59:56Z'),
       'subtracting 74 seconds, overflowing to hours';

    is ds('2013-12-24T00:00:00Z').delta(-1, second),
       ds('2013-12-23T23:59:59Z'),
       'subtracting 1 second, overflowing to days';

    is ds('2014-01-01T00:00:00Z').delta(-1, second),
       ds('2013-12-31T23:59:59Z'),
       'subtracting 1 second, overflowing to years';

    is ds('2013-12-23T12:35:36Z').delta(-1, minute),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 minute';

    is ds('2013-12-23T12:44:36Z').delta(-10, minutes),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 minutes';

    is ds('2013-12-23T13:10:34Z').delta(-14, minutes),
       ds('2013-12-23T12:56:34Z'),
       'subtracting 14 minutes, overflowing to hours';

    is ds('2013-12-23T13:34:36Z').delta(-1, hour),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 hour';

    is ds('2013-12-23T22:34:36Z').delta(-10, hours),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 10 hours';

    is ds('2013-12-24T02:56:34Z').delta(-14, hours),
       ds('2013-12-23T12:56:34Z'),
       'subtracting 14 horus, overflowing to days';

    is ds('2013-12-24T12:34:36Z').delta(-1, day),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 day';

    is ds('2014-02-01T12:34:36Z').delta(-1, day),
       ds('2014-01-31T12:34:36Z'),
       'subtracting 1 day, overflowing to February';

    is ds('2014-03-02T12:56:34Z').delta(-2, days),
       ds('2014-02-28T12:56:34Z'),
       'subtracting 2 days, overflowing to March';

    is ds('2013-12-30T12:34:36Z').delta(-1, week),
       ds('2013-12-23T12:34:36Z'),
       'subtracting 1 week';

    is ds('2014-02-07T12:34:36Z').delta(-1, week),
       ds('2014-01-31T12:34:36Z'),
       'subtracting 1 week, overflowing to February';

    is ds('2014-03-14T12:56:34Z').delta(-2, weeks),
       ds('2014-02-28T12:56:34Z'),
       'subtracting 2 weeks, overflowing to March';

    is ds('2015-01-20T12:56:34Z').delta(-3, weeks),
       ds('2014-12-30T12:56:34Z'),
       'subtracting 3 weeks, overflowing to years';
}

done;
