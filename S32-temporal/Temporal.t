use v6;
use Test;

plan 17;

my ( DateTime $g1, DateTime $g2, Num $t, Int $d );

$g1 = DateTime.from_epoch(0);
ok  $g1.year==1970 && $g1.month == 1 && $g1.day   == 1 &&
    $g1.hour==0    && $g1.minute== 0 && $g1.second== 0 ,
    'DateTime at beginning of Unix epoch'; # test 1

ok  $g1.day-of-week==5 && $g1.month-name eq 'January' &&
    $g1.iso8601 eq '1970-01-01T00:00:00+0000',
    '1970-01-01 was a Thursday in January'; # test 2

$t = 946684799; # last second of previous Millennium, FSVO 'Millennium'.
$g1 = DateTime.from_epoch($t);
ok  $g1.year==1999 && $g1.month ==12 && $g1.day   ==31 &&
    $g1.hour==23   && $g1.minute==59 && $g1.second==59 ,
    'from_epoch at 1999-12-31 23:59:59'; # test 3
ok  $g1.day-name=='Friday' && $g1.month-name eq 'December' &&
    $g1.iso8601 eq '1999-12-31T23:59:59+0000',
    '1999-12-31 23:59:59 was on a Friday in December'; # test 4

$g1 = DateTime.from_epoch(++$t); # one second later, sing Auld Lang Syne.
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
$g1 = DateTime.from_epoch($t);
$g2 = DateTime.now;         # $g1 and $g2 might differ very occasionally
ok  $g1.year  ==$g2.year   && $g1.month ==$g2.month &&
    $g1.day   ==$g2.day    && $g1.hour  ==$g2.hour  &&
    $g1.minute==$g2.minute && floor($g1.second)==floor($g2.second),
    'from_epoch defaults to current time'; # test 7
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
    $g1 = DateTime.from_epoch( $t1 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t1);
    ok $g1.day==$mday  && $g1.month==$mon+1 && $g1.year==$year+1900 &&
       $g1.hour==$hour && $g1.minute==$min  && $g1.second==$sec &&
       $g1.day-of-week==$wday+1,
    "crosscheck {$g1.ymd} {$g1.hms}";
    $t2 += $offset;
    $g2 = DateTime.from_epoch( $t2 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t2);
    ok $g2.day==$mday && $g2.month==$mon+1 && $g2.year==$year+1900 &&
       $g2.hour==$hour && $g2.minute==$min && $g2.second==$sec &&
       $g2.day-of-week==$wday+1,
    "crosscheck {$g2.ymd} {$g2.hms}";
} # tests 9-14

$g1 = DateTime.new(
          year=>1970, month=>1,  day=>1,
          hour=>1,    minute=>1, second=>1,
          time_zone=>'+0100' );
ok $g1.to_epoch==3661, "epoch at 1970-01-01 01:01:01"; # test 15
ok ~$g1 eq '1970-01-01T01:01:01+0100', "as Str 1970-01-01T01:01:01+0100"; # test 16

# round trip test for current number of seconds in the Unix epoch
$t = floor(time);
my @t = test_gmtime( $t );
$g1 = DateTime.new(
          year=>@t[5]+1900, month=>@t[4]+1, day=>@t[3],
          hour=>@t[2],      minute=>@t[1],  second=>@t[0],
          timezone => '+0000' );
ok $g1.to_epoch == $t, "at $g1, epoch is {$g1.to_epoch}"; # test 17

# An independent calculation to cross check the Temporal algorithms.
sub test_gmtime( Num $t is copy ) {
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

# vim: ft=perl6
