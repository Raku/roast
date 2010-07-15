use v6;
use Test;

plan *;

sub dt(*%args) { DateTime.new(year => 1984, |%args) }

sub ymd($year, $month, $day) { dt :$year, :$month, :$day }

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
# L<S32::Temporal/'C<time>'>
# --------------------------------------------------------------------

isa_ok time, Int, 'time returns an Int';

# --------------------------------------------------------------------
# Input validation
# --------------------------------------------------------------------

# L<S32::Temporal/'C<DateTime>'/outside of the ranges specified>

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
lives_ok { ds '2000-02-29T22:33:44Z' }, 'DateTime accepts 29 Feb 2000 (ISO)';
dies_ok  { ymd 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900';
dies_ok  { ds '1900-02-29T22:33:44Z' }, 'DateTime rejects 29 Feb 1900 (ISO)';
lives_ok { dt hour => 0 }, 'DateTime accepts hour 0';
dies_ok  { dt hour => -1 }, 'DateTime rejects hour 0';
lives_ok { dt hour => 23 }, 'DateTime accepts hour 23';
dies_ok  { dt hour => 24 }, 'DateTime rejects hour 24';
lives_ok { dt minute => 0 }, 'DateTime accepts minute 0';
dies_ok  { dt minute => -1 }, 'DateTime rejects minute -1';
lives_ok { dt minute => 59 }, 'DateTime accepts minute 59';
lives_ok { ds '1999-01-01T00:59:22Z' }, 'DateTime accepts minute 59 (ISO)';
lives_ok { dt date => Date.new(1999, 1, 1), minute => 59 }, 'DateTime accepts minute 59 (with Date)';
dies_ok  { dt minute => 60 }, 'DateTime rejects minute 60';
dies_ok  { ds '1999-01-01T00:60:22Z' }, 'DateTime rejects minute 60 (ISO)';
dies_ok  { dt date => Date.new(1999, 1, 1), minute => 60 }, 'DateTime rejects minute 60 (with Date)';
lives_ok { dt second => 0 }, 'DateTime accepts second 0';
lives_ok { dt second => 1/2 }, 'DateTime accepts second 1/2';
dies_ok  { dt second => -1 }, 'DateTime rejects second -1';
dies_ok  { dt second => -1/2 }, 'DateTime rejects second -1/2';
lives_ok { dt second => 60 }, 'DateTime accepts second 60';
lives_ok { dt second => 61 }, 'DateTime accepts second 61';
lives_ok { ds '1999-01-01T12:10:61Z' }, 'DateTime accepts second 61 (ISO)';
lives_ok { dt second => 61.5 }, 'DateTime accepts second 61.5';
lives_ok { dt second => 61.99 }, 'DateTime accepts second 61.99';
lives_ok { dt date => Date.new(1999, 1, 1), second => 61.99 }, 'DateTime accepts second 61.99 (with Date)';
dies_ok  { dt second => 62 }, 'DateTime rejects second 62';
dies_ok  { ds '1999-01-01T12:10:62Z' }, 'DateTime rejects second 62 (ISO)';
dies_ok  { dt date => Date.new(1999, 1, 1), second => 62 }, 'DateTime rejects second 62 (with Date)';

# L<S32::Temporal/'"Set" methods'/'Just as with the C<new> method, validation'>

{
    my $dt = dt year => 2007;
    lives_ok { $dt.set(year => 2000, month => 2, day => 29) }, 'DateTime accepts 29 Feb 2000 (.set)';
    dies_ok  { $dt.set(year => 1900, month => 2, day => 29) }, 'DateTime rejects 29 Feb 1900 (.set)';
    lives_ok { $dt.set(minute => 59) }, 'DateTime accepts minute 59 (.set)';
    dies_ok  { $dt.set(minute => 60) }, 'DateTime rejects minute 60 (.set)';
    lives_ok { $dt.set(second => 61.5) }, 'DateTime accepts second 61.5 (.set)';
    dies_ok  { $dt.set(second => 62) }, 'DateTime rejects second 62 (.set)';
}

# TODO: DateTime.new(Instant $i, …)

# --------------------------------------------------------------------
# L<S32::Temporal/'C<DateTime>'/DateTime.new(time)>
# --------------------------------------------------------------------

is show-dt(DateTime.new(0)), '0 0 0 1 1 1970 4', 'DateTime at beginning of Unix epoch';
is show-dt(DateTime.new(946684799)), '59 59 23 31 12 1999 5', 'from POSIX at 1999-12-31T23:59:59Z';
  # last second of previous millennium, FSVO 'millennium'.
is show-dt(DateTime.new(946684800)), '0 0 0 1 1 2000 6', 'from POSIX at 2000-01-01T00:00:00Z';
  # one second later, sing Auld Lang Syne.

# compare dates for a series of times earlier and later than "now", so
# that every test run will use different values
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
        $t2 += $offset;
        $dt = DateTime.new($t2);
        is show-dt($dt), join(' ', test-gmtime $t2), "crosscheck $dt";
    }
}

{
    my $dt = DateTime.new(946684799,
        timezone => -(5*60*60 + 55*60),
        formatter => { .day ~ '/' ~ .month ~ '/' ~ .year ~ ' ' ~
                       .second ~ 's' ~ .minute ~ 'm' ~ .hour ~ 'h' });
    is ~$dt, '31/12/1999 59s4m18h', 'DateTime.new(Numeric) with time zone and formatter';
}

# --------------------------------------------------------------------
# L<S32::Temporal/'C<DateTime>'/A shorter way to send in date>
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
# L<S32::Temporal/'C<DateTime>'/'one additional constructor: C<now>'>
# --------------------------------------------------------------------

{
    my $t = time;
    1 while time == $t; # loop until the next second
    $t = time;
    my $dt1 = DateTime.new($t);
    my $dt2 = DateTime.now;        # $dt1 and $dt2 might differ very occasionally
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

# TODO: DateTime.Instant

# --------------------------------------------------------------------
# L<S32::Temporal/'"Get" methods'/'the method C<posix>'>
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
# L<S32::Temporal/'"Get" methods'/'The method C<whole-second>'>
# --------------------------------------------------------------------

is dt(second => 22).whole-second, 22, 'DateTime.whole-second (22)';
is dt(second => 22.1).whole-second, 22, 'DateTime.whole-second (22.1)';
is dt(second => 15.9).whole-second, 15, 'DateTime.whole-second (15.9)';
is dt(second => 0).whole-second, 0, 'DateTime.whole-second (0)';
is dt(second => 0.9).whole-second, 0, 'DateTime.whole-second (0.9)';
is dt(second => 60).whole-second, 60, 'DateTime.whole-second (60)';
is dt(second => 60.5).whole-second, 60, 'DateTime.whole-second (60.5)';

# --------------------------------------------------------------------
# L<S32::Temporal/'"Get" methods'/'The C<Date> method'>
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
# L<S32::Temporal/'"Get" methods'/'The method C<offset>'>
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
# L<S32::Temporal/'"Set" methods'/'The C<truncate> method'>
# --------------------------------------------------------------------

{
    my $moon-landing = dt    # Although the seconds part is fictional.
       year => 1969, month => 7, day => 20,
       hour => 8, minute => 17, second => 32.4;

    my $dt = $moon-landing.clone; $dt.truncate(to => 'second');
    is $dt.second, 32, 'DateTime.truncate(to => "second")';
    $dt = $moon-landing.clone; $dt.truncate(to => 'minute');
    is ~$dt, '1969-07-20T08:17:00Z', 'DateTime.truncate(to => "minute")';
    $dt = $moon-landing.clone; $dt.truncate(to => 'hour');
    is ~$dt, '1969-07-20T08:00:00Z', 'DateTime.truncate(to => "hour")';
    $dt = $moon-landing.clone; $dt.truncate(to => 'day');
    is ~$dt, '1969-07-20T00:00:00Z', 'DateTime.truncate(to => "day")';
    $dt = $moon-landing.clone; $dt.truncate(to => 'month');
    is ~$dt, '1969-07-01T00:00:00Z', 'DateTime.truncate(to => "month")';
    $dt = $moon-landing.clone; $dt.truncate(to => 'year');
    is ~$dt, '1969-01-01T00:00:00Z', 'DateTime.truncate(to => "year")';

    $dt = ymd 1999, 1, 18; $dt.truncate(to => 'week');
    is ~$dt, '1999-01-18T00:00:00Z', 'DateTime.truncate(to => "week") (no change in day)';
    $dt = ymd 1999, 1, 19; $dt.truncate(to => 'week');
    is ~$dt, '1999-01-18T00:00:00Z', 'DateTime.truncate(to => "week") (short jump)';
    $dt = ymd 1999, 1, 17; $dt.truncate(to => 'week');
    is ~$dt, '1999-01-11T00:00:00Z', 'DateTime.truncate(to => "week") (long jump)';
    $dt = ymd 1999, 4, 2; $dt.truncate(to => 'week');
    is ~$dt, '1999-03-29T00:00:00Z', 'DateTime.truncate(to => "week") (changing month)';
    $dt = ymd 1999, 1, 3; $dt.truncate(to => 'week');
    is ~$dt, '1998-12-28T00:00:00Z', 'DateTime.truncate(to => "week") (changing year)';
    $dt = ymd 2000, 3, 1; $dt.truncate(to => 'week');
    is ~$dt, '2000-02-28T00:00:00Z', 'DateTime.truncate(to => "week") (skipping over Feb 29)';
    $dt = ymd 1988, 3, 3; $dt.truncate(to => 'week');
    is ~$dt, '1988-02-29T00:00:00Z', 'DateTime.truncate(to => "week") (landing on Feb 29)';
}

# --------------------------------------------------------------------
# L<S32::Temporal/'"Set" methods'/adjust the time zone>
# --------------------------------------------------------------------

# We use $dt.set(timezone => FOO) instead of $dt.timezone = FOO
# because Rakudo hasn't yet implemented the latter.

{
    sub set-tz($dt, $hours, $minutes=0, $seconds=0) {
        $dt.set(timezone => $hours*60*60 + $minutes*60 + $seconds);
    }
    sub hms($dt) {
        $dt.hour ~ ',' ~ $dt.minute ~ ',' ~ $dt.second
    }

    my $dt = tz '+0200'; set-tz($dt, 4);
    is ~$dt, '2005-02-04T17:25:00+0400', 'Changing time zones (adding hours)';
    $dt = tz '+0000'; set-tz($dt, -1);
    is ~$dt, '2005-02-04T14:25:00-0100', 'Changing time zones (subtracting hours)';
    $dt = tz '-0100'; set-tz($dt, 0);
    is ~$dt, '2005-02-04T16:25:00Z', 'Changing time zones (-0100 to UTC)';
    $dt = tz '+0100'; set-tz($dt, -1);
    is ~$dt, '2005-02-04T13:25:00-0100', 'Changing time zones (+ hours to - hours)';
    $dt = tz '-0200'; set-tz($dt, -5);
    is ~$dt, '2005-02-04T12:25:00-0500', 'Changing time zones (decreasing negative hours)';
    $dt = tz '+0000'; set-tz($dt, 0, -13);
    is ~$dt, '2005-02-04T15:12:00-0013', 'Changing time zones (negative minutes)';
    $dt = tz '+0000'; set-tz($dt, 0, 0, -5);
    is hms($dt), '15,24,55', 'Changing time zones (negative seconds)';
    $dt = tz '+0000'; set-tz($dt, 0, -27);
    is ~$dt, '2005-02-04T14:58:00-0027', 'Changing time zones (hour rollover 1)';
    $dt = tz '+0000'; set-tz($dt, 0, 44);
    is ~$dt, '2005-02-04T16:09:00+0044', 'Changing time zones (hour rollover 2)';
    $dt = tz '+0311'; set-tz($dt, -2, -27);
    is ~$dt, '2005-02-04T09:47:00-0227', 'Changing time zones (hours and minutes)';
    $dt = tz '+0311'; set-tz($dt, -2, -27, -19);
    is hms($dt), '9,46,41', 'Changing time zones (hours, minutes, and seconds)';
    $dt = tz '+0000'; set-tz($dt, -18, -55);
    is ~$dt, '2005-02-03T20:30:00-1855', 'Changing time zones (one-day rollover)';
    $dt = tz '-1611'; set-tz($dt, 16, 55);
    is ~$dt, '2005-02-06T00:31:00+1655', 'Changing time zones (two-day rollover)';
    $dt = ds '2005-01-01T02:22:00+0300'; set-tz($dt, 0, 35);
    is ~$dt, '2004-12-31T23:57:00+0035', 'Changing time zones (year rollover)';

    $dt = dt second => 15.5; set-tz($dt, 0, 0, 5);
    is $dt.second, 20.5, 'Changing time zones (fractional seconds)';

    $dt = dt year => 2005, month => 1, day => 3,
             hour => 2, minute => 22, second => 4,
             timezone => 13;
    $dt.set(timezone => -529402);
      # A difference from UTC of 6 days, 3 hours, 3 minutes, and
      # 22 seconds.
    is show-dt($dt), '29 18 23 27 12 2004 1', 'Changing time zones (big rollover)';    

    # DateTime doesn't implement DST, but it ought to make
    # implementing DST possible. We test that here.

    sub nyc-tz($dt, $to-utc) { # America/New_York
        3600 * (us2007dst($dt, $to-utc ?? 2 !! 7) ?? -4 !! -5)
    }

    sub lax-tz($dt, $to-utc) { # America/Los_Angeles
        3600 * (us2007dst($dt, $to-utc ?? 2 !! 10) ?? -7 !! -8)
    }

    sub us2007dst($dt, $critical-hour) {
        $dt.month >  3
            || $dt.month ==  3
                && ($dt.day > 11
                    || $dt.day == 11 && $dt.hour >= $critical-hour)
        and $dt.month < 11
            || $dt.month == 11
                && ($dt.day < 4
                    || $dt.day == 4 && $dt.hour < $critical-hour)
    }

    sub nyc-dt($year, $month, $day, $hour, $minute) {
        dt :$year, :$month, :$day, :$hour, :$minute,
            timezone => &nyc-tz
    }

    $dt = ds '2007-01-02T02:22:00Z'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-01-01T21:22:00-0500', 'Changing time zones (UTC to NYC, outside of DST)';
    $dt = ds '2007-08-01T02:22:00Z'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-07-31T22:22:00-0400', 'Changing time zones (UTC to NYC, during DST)';
    $dt = ds '2007-03-11T06:55:00Z'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-03-11T01:55:00-0500', 'Changing time zones (UTC to NYC, just before DST)';
    $dt = ds '2007-03-11T07:02:00Z'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-03-11T03:02:00-0400', 'Changing time zones (UTC to NYC, just after DST)';
    $dt = ds '2007-03-11T09:58:00+0303'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-03-11T01:55:00-0500', 'Changing time zones (+0303 to NYC, just before DST)';
    $dt = ds '2007-03-10T14:50:00-1612'; $dt.set(timezone => &nyc-tz);
    is ~$dt, '2007-03-11T03:02:00-0400', 'Changing time zones (-1612 to NYC, just after DST)';
    $dt = nyc-dt 2007,  1,  1,   21, 22; $dt.set(timezone => 0);
    is ~$dt, '2007-01-02T02:22:00Z', 'Changing time zones (NYC to UTC, outside of DST)';
    $dt = nyc-dt 2007,  7, 31,   22, 22; $dt.set(timezone => 0);
    is ~$dt, '2007-08-01T02:22:00Z', 'Changing time zones (NYC to UTC, during DST)';
    $dt = nyc-dt 2007,  3, 11,    1, 55; $dt.set(timezone => 0);
    is ~$dt, '2007-03-11T06:55:00Z', 'Changing time zones (NYC to UTC, just before DST)';
    $dt = nyc-dt 2007,  3, 11,    3,  2; set-tz($dt, -16, -12);
    is ~$dt, '2007-03-10T14:50:00-1612', 'Changing time zones (NYC to -1612, just after DST)';
    $dt = nyc-dt 2007,  3, 11,    1, 55; $dt.set(timezone => &lax-tz);
    is ~$dt, '2007-03-10T22:55:00-0800', 'Changing time zones (NYC to LAX, just before NYC DST)';
    $dt = nyc-dt 2007,  3, 11,    3,  2; $dt.set(timezone => &lax-tz);
    is ~$dt, '2007-03-10T23:02:00-0800', 'Changing time zones (NYC to LAX, just after NYC DST)';
    $dt = nyc-dt 2007,  3, 11,    6,  2; $dt.set(timezone => &lax-tz);
    is ~$dt, '2007-03-11T03:02:00-0700', 'Changing time zones (NYC to LAX, just after LAX DST)';
}

# --------------------------------------------------------------------
# L<S32::Temporal/'"Set" methods'/'C<set> and C<truncate> return'>
# ...the calling object
# --------------------------------------------------------------------

{
    my $dt = ymd 1998, 4, 2;
    my $same-dt = $dt.set(year => 1997);
    $same-dt.set(month => 3);
    is ~$dt, '1997-03-02T00:00:00Z', 'DateTime.set returns the calling object';

    $dt = ymd 1998, 1, 30;
    $same-dt = $dt.truncate(to => 'month');
    $same-dt.truncate(to => 'week');
    is $dt.year, 1997, 'DateTime.truncate returns the calling object';
}

done_testing;

# vim: ft=perl6
