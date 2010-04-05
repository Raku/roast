use v6;
use Test;

plan 17;

my ( DateTime $g1, DateTime $g2, Num $t, Int $d );

$g1 = DateTime.from_epoch(0);
ok  $g1.year==1970 && $g1.month == 1 && $g1.day   == 1 &&
    $g1.hour==0    && $g1.minute== 0 && $g1.second== 0 ,
    'DateTime at beginning of Unix epoch'; # test 1

ok  $g1.day-of-week==5 && $g1.month-name eq 'January' &&
    $g1.iso8601 eq '1970-01-01T00:00:00+00',
    '1970-01-01 was a Thursday in January'; # test 2

$t = 946684799; # last second of previous Millennium, FSVO 'Millennium'.
$g1 = DateTime.from_epoch($t);
ok  $g1.year==1999 && $g1.month ==12 && $g1.day   ==31 &&
    $g1.hour==23   && $g1.minute==59 && $g1.second==59 ,
    'from_epoch at 1999-12-31 23:59:59'; # test 3
ok  $g1.day-name=='Friday' && $g1.month-name eq 'December' &&
    $g1.iso8601 eq '1999-12-31T23:59:59+00',
    '1999-12-31 23:59:59 was on a Friday in December'; # test 4

$g1 = DateTime.from_epoch(++$t); # one second later, sing Auld Lang Syne.
ok  $g1.year==2000 && $g1.month == 1 && $g1.day   == 1 &&
    $g1.hour==0    && $g1.minute== 0 && $g1.second== 0 ,
    'gmtime at 2000-01-01 00:00:00'; # test 5
ok  $g1.day-of-week==7 && $g1.month-name eq 'January' &&
    $g1.iso8601 eq '2000-01-01T00:00:00+00',
    '2000-01-01 00:00:00 was on a Saturday in January'; # test 6

$t  = floor(time());
while floor(time) == $t { ; } # empty loop until the next second begins
$t  = time;
$d  = (floor($t) div 86400 + 4) % 7 + 1;
$g1 = DateTime.from_epoch($t);
$g2 = DateTime.new;            # $g1 and $g2 might differ very occasionally
ok  $g1.year  ==$g2.year   && $g1.month ==$g2.month &&
    $g1.day   ==$g2.day    && $g1.hour  ==$g2.hour  &&
    $g1.minute==$g2.minute && $g1.second==$g2.second,
    'from_epoch defaults to current time'; # test 7
ok  $g2.day-of-week==$d,
    "today, {$g2.date} {$g2.time}," ~
    " is a {$g2.date.day-name} in {$g2.date.month-name}"; # test 8
exit;
# compare dates for a series of times earlier and later than "now", so
# that every test run will use different values
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
# the offset changes all time components and causes overflow/underflow
my ($t1 = $t, $t2 = $t, $offset = ((((7*31+1)*24+10)*60+21)*60+21) );
for 1..3 -> $test {
    $t1 -= $offset;
    $g1 = Time.gmtime( $t1 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t1);
    ok $g1.date.day==$mday && $g1.date.month==$mon+1 && $g1.date.year==$year+1900 &&
       $g1.time.hour==$hour && $g1.time.minute==$min && $g1.time.second==$sec &&
       $g1.date.day-of-week==$wday+1,
    "crosscheck {$g1.date} {$g1.time}";
    $t2 += $offset;
    $g2 = Time.gmtime( $t2 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t2);
    ok $g2.date.day==$mday && $g2.date.month==$mon+1 && $g2.date.year==$year+1900 &&
       $g2.time.hour==$hour && $g2.time.minute==$min && $g2.time.second==$sec &&
       $g2.date.day-of-week==$wday+1,
    "crosscheck {$g2.date} {$g2.time}";
} # tests 9-14

$g1 = Temporal::DateTime.new(
          date => Temporal::Date.new( :year(1970), :month(1),  :day(1) ),
          time => Temporal::Time.new( :hour(1),    :minute(1), :second(1) ),
          timezone => Temporal::TimeZone::Observance.new(
              offset=>3600, isdst=>Bool::False, abbreviation=>'CET' ) );
ok $g1.epoch==3661, "epoch at 1970-01-01 01:01:01"; # test 15
ok ~$g1 eq '1970-01-01T01:01:01+0100', "as Str 1970-01-01T01:01:01+0100"; # test 16

# round trip test for current number of seconds in the Unix epoch
$t = floor(time);
my @t = test_gmtime( $t );
$g1 = Temporal::DateTime.new(
          date => Temporal::Date.new( :year(@t[5]+1900), :month(@t[4]+1), :day(@t[3]) ),
          time => Temporal::Time.new( :hour(@t[2]),      :minute(@t[1]),  :second(@t[0]) ),
          timezone => Temporal::TimeZone::Observance.new(
              offset=>-8*3600, isdst=>Bool::False, abbreviation=>'PDT' ) );
ok $g1.epoch == $t, "at $g1, epoch is {$g1.epoch}"; # test 17

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
