use v6;
use Test;

plan *;

my ( DateTime $g1, DateTime $g2, Num $t, Int $d );

$g1 = DateTime.from-epoch(0);
ok  $g1.year==1970 && $g1.month == 1 && $g1.day   == 1 &&
    $g1.hour==0    && $g1.minute== 0 && $g1.second== 0 ,
    'DateTime at beginning of Unix epoch'; # test 1

ok  $g1.day-of-week==5 && $g1.month-name eq 'January' &&
    $g1.iso8601 eq '1970-01-01T00:00:00+0000',
    '1970-01-01 was a Thursday in January'; # test 2

$t = 946684799; # last second of previous Millennium, FSVO 'Millennium'.
$g1 = DateTime.from-epoch($t);
ok  $g1.year==1999 && $g1.month ==12 && $g1.day   ==31 &&
    $g1.hour==23   && $g1.minute==59 && $g1.second==59 ,
    'from-epoch at 1999-12-31 23:59:59'; # test 3
ok  $g1.day-name=='Friday' && $g1.month-name eq 'December' &&
    $g1.iso8601 eq '1999-12-31T23:59:59+0000',
    '1999-12-31 23:59:59 was on a Friday in December'; # test 4

$g1 = DateTime.from-epoch(++$t); # one second later, sing Auld Lang Syne.
ok  $g1.year==2000 && $g1.month == 1 && $g1.day   == 1 &&
    $g1.hour==0    && $g1.minute== 0 && $g1.second== 0 ,
    'gmtime at 2000-01-01 00:00:00'; # test 5
ok  $g1.day-of-week==7 && $g1.month-name eq 'January' &&
    $g1.iso8601 eq '2000-01-01T00:00:00+0000',
    '2000-01-01 00:00:00 was on a Saturday in January'; # test 6

$t  = floor(time);
while floor(time) == $t { ; } # empty loop until the next second begins
$t  = time;
$d  = (floor($t) div 86400 + 4) % 7 + 1;
$g1 = DateTime.from-epoch($t);
$g2 = DateTime.now;         # $g1 and $g2 might differ very occasionally
ok  $g1.year  ==$g2.year   && $g1.month ==$g2.month &&
    $g1.day   ==$g2.day    && $g1.hour  ==$g2.hour  &&
    $g1.minute==$g2.minute && floor($g1.second)==floor($g2.second),
    'now() uses current time'; # test 7
ok  $g2.day-of-week==$d,
    "today, {$g2.ymd} {$g2.hms}," ~
    " is a {$g2.day-name} in {$g2.month-name}"; # test 8

# compare dates for a series of times earlier and later than "now", so
# that every test run will use different values
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
# the offset changes all time components and causes overflow/underflow
$t = floor(time);
my $t1 = $t;
my $t2 = $t;
my $offset = ((((7*31+1)*24+10)*60+21)*60+21);
for 1..3 {
    $t1 -= $offset;
    $g1 = DateTime.from-epoch( $t1 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test-gmtime($t1);
    ok $g1.day==$mday  && $g1.month==$mon+1 && $g1.year==$year+1900 &&
       $g1.hour==$hour && $g1.minute==$min  && $g1.second==$sec &&
       $g1.day-of-week==$wday+1,
    "crosscheck {$g1.ymd} {$g1.hms}";
    $t2 += $offset;
    $g2 = DateTime.from-epoch( $t2 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test-gmtime($t2);
    ok $g2.day==$mday && $g2.month==$mon+1 && $g2.year==$year+1900 &&
       $g2.hour==$hour && $g2.minute==$min && $g2.second==$sec &&
       $g2.day-of-week==$wday+1,
    "crosscheck {$g2.ymd} {$g2.hms}";
} # tests 9-14

$g1 = DateTime.new(
          year=>1970, month=>1,  day=>1,
          hour=>1,    minute=>1, second=>1,
          timezone=>'+0100' );
ok $g1.to-epoch==61, "epoch at 1970-01-01 01:01:01"; # test 15
ok ~$g1 eq '1970-01-01T01:01:01+0100',
    "as Str 1970-01-01T01:01:01+0100"; # test 16

# round trip test for current number of seconds in the Unix epoch
$t = floor(time);
my @t = test-gmtime( $t );
$g1 = DateTime.new(
          year=>@t[5]+1900, month=>@t[4]+1, day=>@t[3],
          hour=>@t[2],      minute=>@t[1],  second=>@t[0],
          timezone => '+0000' );
ok $g1.to-epoch == $t, "at $g1, epoch is {$g1.to-epoch}"; # test 17

# Calls to constructors may omit parameters
$g1 = DateTime.new(year=>1969, day=>15, hour=>9, minute=>15);
ok ~$g1 eq '1969-01-15T09:15:00+0000', 'new without some params'; # test 18

# Loopback
$g1 = DateTime.new('2009-12-31T22:33:44+1100');
ok $g1.ymd eq '2009-12-31' && $g1.hms eq '22:33:44', 'parse ISO 8601'; # test 19

# An independent calculation to cross check the Temporal algorithms.
sub test-gmtime( Num $t is copy ) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
    $t = floor($t);
    $sec  = $t % 60; $t div= 60; # $t is now epoch minutes
    $min  = $t % 60; $t div= 60; # $t is now epoch hours
    $hour = $t % 24; $t div= 24; # $t is now epoch days
    # Not a sophisticated or fast algorithm, just an understandable one
    # only valid from 1970-01-01 until 2100-02-28
    $wday = ($t+4) % 7;  # 1970-01-01 was a Thursday
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
    $isdst = 0;
    return ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
}

## Tests for DateTime to Date functionality.

$g1 = DateTime.new(:year(2010), :month(06), :day(04));
my $date;
lives_ok { $date = $g1.Date(); }, 'Calling .Date() method'; # test 20
isa_ok $date, Date, 'Date object is correct class'; # test 21
is $date.year, 2010, 'Date year'; # test 22
is $date.month, 6, 'Date month'; # test 23
is $date.day, 4, 'Date day'; # test 24

# ---------------------------------------------------------------

sub dt { DateTime.new(year => 1984, |%_); }
sub ds (Str $s) { DateTime.new($s) }
sub ymd ($y, $m, $d) { DateTime.new(year => $y, month => $m, day => $d); }

my $now = DateTime.now;

# ---------------------------------------------------------------
# Input validation
# ---------------------------------------------------------------

# L<S32::Temporal/'C<DateTime>'/outside of the ranges specified>

lives_ok { dt month => 1 }, 'DateTime accepts January';
dies_ok { dt month => 0 }, 'DateTime rejects month 0';
dies_ok { dt month => -1 }, 'DateTime rejects month -1';
lives_ok { dt month => 12 }, 'DateTime accepts December';
dies_ok { dt month => 13 }, 'DateTime rejects month 13';
lives_ok { dt month => 1, day => 31 }, 'DateTime accepts January 31';
dies_ok { dt month => 1, day => 32 }, 'DateTime rejects January 32';
lives_ok { dt month => 6, day => 30 }, 'DateTime accepts June 30';
dies_ok { dt month => 6, day => 31 }, 'DateTime rejects June 31';
dies_ok { dt month => 2, day => 30 }, 'DateTime rejects February 30';
lives_ok { ymd 1996, 2, 29 }, 'DateTime accepts 29 Feb 1996';
dies_ok { ymd 1995, 2, 29 }, 'DateTime rejects 29 Feb 1995';
lives_ok { ymd 2000, 2, 29 }, 'DateTime accepts 29 Feb 2000';
lives_ok { ds '2000-02-29T22:33:44+0000' }, 'DateTime accepts 29 Feb 2000 (ISO)';
dies_ok { ymd 1900, 2, 29 }, 'DateTime rejects 29 Feb 1900';
dies_ok { ds '1900-02-29T22:33:44+0000' }, 'DateTime rejects 29 Feb 1900 (ISO)';
lives_ok { dt hour => 0 }, 'DateTime accepts hour 0';
dies_ok { dt hour => -1 }, 'DateTime rejects hour 0';
lives_ok { dt hour => 23 }, 'DateTime accepts hour 23';
dies_ok { dt hour => 24 }, 'DateTime rejects hour 24';
lives_ok { dt minute => 0 }, 'DateTime accepts minute 0';
dies_ok { dt minute => -1 }, 'DateTime rejects minute -1';
lives_ok { dt minute => 59 }, 'DateTime accepts minute 59';
lives_ok { ds '1999-01-01T00:59:22+0000' }, 'DateTime accepts minute 59 (ISO)';
lives_ok { dt date => Date.new(1999, 1, 1), minute => 59 }, 'DateTime accepts minute 59 (with Date)';
dies_ok { dt minute => 60 }, 'DateTime rejects minute 60';
dies_ok { ds '1999-01-01T00:60:22+0000' }, 'DateTime rejects minute 60 (ISO)';
dies_ok { dt date => Date.new(1999, 1, 1), minute => 60 }, 'DateTime rejects minute 60 (with Date)';
lives_ok { dt second => 0 }, 'DateTime accepts second 0';
lives_ok { dt second => 1/2 }, 'DateTime accepts second 1/2';
dies_ok { dt second => -1 }, 'DateTime rejects second -1';
dies_ok { dt second => -1/2 }, 'DateTime rejects second -1/2';
lives_ok { dt second => 60 }, 'DateTime accepts second 60';
lives_ok { dt second => 61 }, 'DateTime accepts second 61';
lives_ok { ds '1999-01-01T12:10:61+0000' }, 'DateTime accepts second 61 (ISO)';
lives_ok { dt second => 61.5 }, 'DateTime accepts second 61.5';
lives_ok { dt second => 61.99 }, 'DateTime accepts second 61.99';
lives_ok { dt date => Date.new(1999, 1, 1), second => 61.99 }, 'DateTime accepts second 61.99 (with Date)';
dies_ok { dt second => 62 }, 'DateTime rejects second 62';
dies_ok { ds '1999-01-01T12:10:62+0000' }, 'DateTime rejects second 62 (ISO)';
dies_ok { dt date => Date.new(1999, 1, 1), second => 62 }, 'DateTime rejects second 62 (with Date)';

# L<S32::Temporal/'"Set" methods'/'Just as with the C<new> method, validation'>

lives_ok { $now.set(year => 2000, month => 2, day => 29) }, 'DateTime accepts 29 Feb 2000 (.set)';
dies_ok { $now.set(year => 1900, month => 2, day => 29) }, 'DateTime rejects 29 Feb 1900 (.set)';
lives_ok { $now.set(minute => 59) }, 'DateTime accepts minute 59 (.set)';
dies_ok { $now.set(minute => 60) }, 'DateTime rejects minute 60 (.set)';
lives_ok { $now.set(second => 61.5) }, 'DateTime accepts second 61.5 (.set)';
dies_ok { $now.set(second => 62) }, 'DateTime rejects second 62 (.set)';

# ---------------------------------------------------------------
# L<S32::Temporal/'"Get" methods'/'The method C<whole-second>'>
# ---------------------------------------------------------------

is dt(second => 22).whole-second, 22, 'DateTime.whole-second (22)';
is dt(second => 22.1).whole-second, 22, 'DateTime.whole-second (22.1)';
is dt(second => 15.9).whole-second, 15, 'DateTime.whole-second (15.9)';
is dt(second => 0).whole-second, 0, 'DateTime.whole-second (0)';
is dt(second => 0.9).whole-second, 0, 'DateTime.whole-second (0.9)';
is dt(second => 60).whole-second, 60, 'DateTime.whole-second (60)';
is dt(second => 60.5).whole-second, 60, 'DateTime.whole-second (60.5)';

# ---------------------------------------------------------------
# L<S32::Temporal/'"Get" methods'/'The method C<week>'>
# ---------------------------------------------------------------

is ymd(1977, 8, 20).week.join(' '), '1977 33', 'DateTime.week (1977-8-20)';
is ymd(1977, 8, 20).week-year, 1977, 'DateTime.week (1977-8-20)';
is ymd(1977, 8, 20).week-number, 33, 'DateTime.week-number (1977-8-20)';
is ymd(1987, 12, 18).week.join(' '), '1987 51', 'DateTime.week (1987-12-18)';
is ymd(2020, 5, 4).week.join(' '), '2020 19', 'DateTime.week (2020-5-4)';

# From http://en.wikipedia.org/w/index.php?title=ISO_week_date&oldid=370553706#Examples

is ymd(2005, 01, 01).week.join(' '), '2004 53', 'DateTime.week (2005-01-01)';
is ymd(2005, 01, 02).week.join(' '), '2004 53', 'DateTime.week (2005-01-02)';
is ymd(2005, 12, 31).week.join(' '), '2005 52', 'DateTime.week (2005-12-31)';
is ymd(2007, 01, 01).week.join(' '), '2007 1',  'DateTime.week (2007-01-01)';
is ymd(2007, 12, 30).week.join(' '), '2007 52', 'DateTime.week (2007-12-30)';
is ymd(2007, 12, 30).week-year, 2007, 'DateTime.week (2007-12-30)';
is ymd(2007, 12, 30).week-number, 52, 'DateTime.week-number (2007-12-30)';
is ymd(2007, 12, 31).week.join(' '), '2008 1',  'DateTime.week (2007-12-31)';
is ymd(2008, 01, 01).week.join(' '), '2008 1',  'DateTime.week (2008-01-01)';
is ymd(2008, 12, 29).week.join(' '), '2009 1',  'DateTime.week (2008-12-29)';
is ymd(2008, 12, 31).week.join(' '), '2009 1',  'DateTime.week (2008-12-31)';
is ymd(2009, 01, 01).week.join(' '), '2009 1',  'DateTime.week (2009-01-01)';
is ymd(2009, 12, 31).week.join(' '), '2009 53', 'DateTime.week (2009-12-31)';
is ymd(2010, 01, 03).week.join(' '), '2009 53', 'DateTime.week (2010-01-03)';
is ymd(2010, 01, 03).week-year, 2009, 'DateTime.week-year (2010-01-03)';
is ymd(2010, 01, 03).week-number, 53, 'DateTime.week-number (2010-01-03)';

# ---------------------------------------------------------------
# L<S32::Temporal/'"Get" methods'/"also $dt.date('-')">
# ---------------------------------------------------------------

is $now.date, $now.ymd, 'DateTime.date can be spelled as DateTime.ymd';
is $now.time, $now.hms, 'DateTime.date can be spelled as DateTime.hms';

# TODO: day-of-month

done_testing;

# vim: ft=perl6
