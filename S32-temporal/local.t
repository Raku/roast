use v6;
use Test;

# L<S32::Temporal/C<DateTime>/'local time zone'>

plan 25;

sub ds(Str $s) { DateTime.new: $s }

ok $*TZ.defined, '$*TZ is defined';
is DateTime.now.timezone, $*TZ, 'DateTime.now uses $*TZ';
is DateTime.new(year => 1995).local.timezone, $*TZ, 'DateTime.local uses $*TZ';

my $dt = ds('2003-08-01T02:22:00Z').local.utc;
#?rakudo todo 'nom regression'
is ~$dt, '2003-08-01T02:22:00Z', 'UTC -> local -> UTC (2003-08-01T02:22:00Z)';
$dt = ds('1984-02-29T05:55:22Z').local.utc;
#?rakudo todo 'nom regression'
is ~$dt, '1984-02-29T05:55:22Z', 'UTC -> local -> UTC (1984-02-29T05:55:22Z)';
$dt = ds('1998-12-31T23:59:60Z').local.utc;
#?rakudo todo 'nom regression'
is ~$dt, '1998-12-31T23:59:60Z', 'UTC -> local -> UTC (1998-12-31T23:59:60Z)';

unless '/etc/timezone'.IO ~~ :e and
       slurp('/etc/timezone') eq "America/New_York\n" {
    skip_rest "The local time zone may not be America/New_York.";
    exit;
}

# So that we can test .local and $*TZ more thoroughly, the
# following tests assume a specific local time zone. I picked
# America/New_York because it's sufficiently complex (it observes
# DST according to rules that have changed since the year 2000)
# and it happens to be my own time zone at the moment. —Kodi
#
# A useful reference:
# http://en.wikipedia.org/wiki/History_of_time_in_the_United_States#Start_and_end_dates_of_United_States_Daylight_Time

sub nyc-dt($year, $month, $day, $hour, $minute, $second = 0) {
    DateTime.new: :$year, :$month, :$day, :$hour, :$minute, :$second,
        timezone => $*TZ;
}

# UTC → local

$dt = ds('2007-01-02T02:22:00Z').in-timezone($*TZ);
is ~$dt, '2007-01-01T21:22:00-0500', 'DateTime.in-timezone($*TZ) (from UTC, outside of DST)';

$dt = ds('2007-01-02T02:22:00Z').local;
is ~$dt, '2007-01-01T21:22:00-0500', 'DateTime.local (from UTC, outside of DST)';
$dt = ds('2003-08-01T02:22:00Z').local;
is ~$dt, '2003-07-31T22:22:00-0400', 'DateTime.local (from UTC, during DST)';
$dt = ds('1984-04-29T06:55:00Z').local;
is ~$dt, '1984-04-29T01:55:00-0500', 'DateTime.local (from UTC, just before DST begins)';
$dt = ds('1984-04-29T07:02:00Z').local;
is ~$dt, '1984-04-29T03:02:00-0400', 'DateTime.local (from UTC, just after DST begins)';
$dt = ds('2008-11-02T05:55:00Z').local;
is ~$dt, '2008-11-02T01:55:00-0400', 'DateTime.local (from UTC, just before DST ends)';
is ~eval($dt.perl), '2008-11-02T01:55:00-0400', 'DateTime.local (from UTC, just before DST ends, .perl)';
$dt = ds('2008-11-02T06:55:00Z').local;
is ~$dt, '2008-11-02T01:55:00-0500', 'DateTime.local (from UTC, just after DST ends)';
is ~eval($dt.perl), '2008-11-02T01:55:00-0500', 'DateTime.local (from UTC, just after DST ends, .perl)';
$dt = ds('2008-11-02T08:58:00+0303').local;
is ~$dt, '2008-11-02T01:55:00-0400', 'DateTime.local (from +0303, just before DST ends)';
$dt = ds('2008-11-01T14:43:00-1612').local;
is ~$dt, '2008-11-02T01:55:00-0500', 'DateTime.local (from -1612, just after DST ends)';

# Local → UTC

$dt = nyc-dt(1995,  1, 1, 21, 22).utc;
is ~$dt, '1995-01-02T02:22:00Z', 'DateTime.utc (from local, outside of DST)';
$dt = nyc-dt(1998,  7, 31, 22, 22).utc;
is ~$dt, '1998-08-01T02:22:00Z', 'DateTime.utc (from local, during DST)';
$dt = nyc-dt(2007,  3, 11, 1, 55).utc;
is ~$dt, '2007-03-11T06:55:00Z', 'DateTime.utc (from local, just before DST starts)';
$dt = nyc-dt(2007,  3, 11, 3, 2).in-timezone: 60 * (60 * -16 - 12);
is ~$dt, '2007-03-10T14:50:00-1612', 'DateTime.in-timezone (local to -1612, just after DST starts)';
$dt = nyc-dt(1989, 10, 29, 1, 55).utc;
ok $dt eq '1989-10-29T05:55:00Z'|'1989-10-29T06:55:00Z', 'DateTime.utc (from local, ambiguous)';

# Throw leap seconds into the mix

$dt = nyc-dt(1997, 6, 30,   19, 59, 60).utc;
ok $dt eq '1997-06-30T23:59:60Z', 'DateTime.utc (from local, with leap second)';
dies_ok { nyc-dt 1997, 6, 30,   23, 59, 60 }, 'Local time zone rejects bogus leap second';
$dt = ds('1998-12-31T23:59:60Z').local;
is ~$dt, '1998-12-31T18:59:60-0500', 'DateTime.local (from UTC, with leap second)';

done;

# vim: ft=perl6
