# [BUG] This test, and the module embedded here, work in the full Rakudo but
# [BUG] cause the stage 1 compiler (perl6_s1.pbc) to crash or hang, see:
# [BUG] http://irclog.perlgeek.de/perl6/2009-05-15#i_1147416 etc
# I prefer to shelve this until the stage 1 compiler is debugged, but if anyone
# would like to see further development of this, let me know. Martin Berends.

use v6;
use Test;

# before Temporal is included in Rakudo Setting, include it here.
use src::setting::Temporal;
#----------------------------------------------------------------------
# Temporal.pm
my subset Month     of Int where { 1 <= $^a <= 12 };
my subset Day       of Int where { 1 <= $^a <= 31 };
my subset DayOfWeek of Int where { 1 <= $^a <=  7 };
my subset Hour      of Int where { 0 <= $^a <= 23 };
my subset Minute    of Int where { 0 <= $^a <= 59 };
my subset Second    of Num where { 0 <= $^a <= 60 };

role Temporal::Date {
    has Int    $.year;
    has Month  $.month = 1;
    has Day    $.day = 1;

    method day-of-week( ) {  # returns DayOfWeek {
        my ( $a, $y, $m, $jd );         # algorithm from Claus T\x{00f8}ndering
        $a = int((14 - $.month) / 12 );
        $y = $.year + 4800 - $a;
        $m = $.month + 12 * $a - 3;
        $jd = $.day + int((153 * $m + 2) / 5) + 365 * $y + int( $y / 4 )
              - int( $y / 100 ) + int( $y / 400 ) - 32045;
        return ($jd + 1) % 7 + 1;
    }

    our Str method month-name( ) {
        return <January February March April May June July August
            September October November December>[$.month-1];
    }

    our Str method day-name( ) {
        return <Sunday Monday Tuesday Wednesday Thursday Friday
                Saturday>[self.day-of-week-1];
    }

    our Str method iso8601() {
        [ self.year.fmt('%04d'), self.month.fmt('%02d'),
          self.day.fmt('%02d') ].join('-');
    }

    method Str { self.iso8601 };

    sub infix:«<=>»( Temporal::Date $left, Temporal::Date $right )
        is export
    {
        $left.year <=> $right.year
        ||
        $left.month <=> $right.month
        ||
        $left.day <=> $right.day;
    }

}

role Temporal::Time {
    has Hour   $.hour = 0;
    has Minute $.minute = 0;
    has Second $.second = 0;

    our Str method iso8601() {
        [ self.hour.fmt('%02d'), self.minute.fmt('%02d'),
          self.second.fmt('%02d') ].join(':');
# masak golf: given self { return sprintf '%02d:%02d:%02d', .hour, .minute, .second; }
    }

    method Str { self.iso8601(); }

    sub infix:«<=>»( Temporal::Time $left, Temporal::Time $right )
        is export
    {
        $left.hour <=> $right.hour
        ||
        $left.minute <=> $right.minute
        ||
        $left.second <=> $right.second;
    }

}

role Temporal::DateTime {
    has Temporal::Date $.date;
    has Temporal::Time $.time;
#   has Temporal::Date $!date handles <year month day day-of-week>;
#   has Temporal::Time $!time handles <hour minute second fractional-second>;
#   has Temporal::TimeZone::Observance $!timezone handles <offset isdst>;

    our Str method iso8601 () {
        self.date.iso8601 ~ 'T' ~ self.time.iso8601 ~ self.timezone.iso8601;
    }

    method Str { self.iso8601 }

    # This involves a whole bunch of code - see Perl 5's
    # Time::Local
#   our Num method epoch { ... }

#   method Int { self.epoch.truncate }

#   method Num { self.epoch }
}

class Time {

    our method gmtime( Num $epoch = time ) {
        my ( $time, $sec, $min, $hour, $mday, $mon, $year );
        $time = int( $epoch );
        $sec  = $time % 60; $time = int($time/60);
        $min  = $time % 60; $time = int($time/60);
        $hour = $time % 24; $time = int($time/24);
        # Day month and leap year arithmetic, based on Gregorian day #.
        # 2000-01-01 noon UTC == 2451558.0 Julian == 2451545.0 Gregorian
        $time += 2440588;   # because 2000-01-01 == Unix epoch day 10957
        my $a = $time + 32044;     # date algorithm from Claus T\x{00f8}ndering
        my $b = int((4 * $a + 3) / 146097); # 146097 = days in 400 years
        my $c = $a - int(( 146097 * $b ) / 4);
        my $d = int((4 * $c + 3) / 1461);       # 1461 = days in 4 years
        my $e = $c - int(($d * 1461) / 4);
        my $m = int((5 * $e + 2) / 153); # 153 = days in Mar-Jul Aug-Dec
        $mday = $e - int((153 * $m + 2) / 5 ) + 1;
        $mon  = $m + 3 - 12 * int( $m / 10 );
        $year = $b * 100 + $d - 4800 + int( $m / 10 );
        Temporal::DateTime.new(
            date => Temporal::Date.new(
                year => $year, month  => $mon, day    => $mday ),
            time => Temporal::Time.new(
                hour => $hour, minute => $min, second => $sec  )
        );
    }
#   Not clear what spec S32-Temporal really means here...
#   multi sub localtime( :$time = time(), :$tz=<GMT> ) is export { ... } # NYI
#   multi sub localtime( Num $epoch = time() ) returns Temporal::DateTime { ... } # NYI
#   our Num sub time() {  ...  } # NYI
}

=begin pod

# Not Yet Implemented

 enum dayOfWeek <Sunday Monday Tuesday Wednesday Thursday Friday Saturday>;
#enum DayOfWeek <Sunday Monday Tuesday Wednesday Thursday Friday Saturday>;


# Example:

#$date = Date.new( :year(2008), :month(1), :day(25) ); $date.month(); # 1
#Temporal::Time

role Temporal::TimeZone::Observance {
    my subset Offset of Int where { -86400 < $^a < 86400 };
    has Offset $.offset;
    has Bool   $.isdst;
    has Str    $.abbreviation; # CST, AST

    # The ISO8601 standard does not allow for offsets with
    # sub-minute resolutions. In real-world practice, this is not
    # an issue.
    our Str method iso8601 {
        my $hours = self.offset.abs / 3600;
        my $minutes = self.offset.abs % 3600;

        return self.offset < 0 ?? '-' :: '+'
                ~ $hours.fmt('%02d')
                ~ $minutes.truncate.fmt('%02d');
    }

    method Str { self.iso8601 }
}

=end pod

=begin pod

=head1 SEE ALSO
The best yet seen explanation of calendars, by Claus T\x{00f8}ndering
L<Calendar FAQ|http://www.tondering.dk/claus/calendar.html>.
Similar algorithms at L<http://www.hermetic.ch/cal_stud/jdn.htm>
and L<http://www.merlyn.demon.co.uk/daycount.htm>.
Perl 5 perldoc L<doc:Time::Local>.
L<S32-Temporal|http://perlcabal.org/syn/S32/Temporal.html>

=end pod
#----------------------------------------------------------------------

plan 18;

my ( Temporal::DateTime $g1, Temporal::DateTime $g2, Num $t, Int $d );

$g1 = Time.gmtime(0);
ok  $g1.date.year==1970 && $g1.date.month == 1 && $g1.date.day   == 1 &&
    $g1.time.hour==0    && $g1.time.minute== 0 && $g1.time.second== 0 ,
    'gmtime at beginning of Unix epoch';
ok  $g1.date.day-of-week==5 && $g1.date.month-name eq 'January' &&
    $g1.date.iso8601 eq '1970-01-01',
    '1970-01-01 was a Thursday in January';

$t = 946684799; # last second of previous Millennium, FSVO 'Millennium'.
$g1 = Time.gmtime($t);
ok  $g1.date.year==1999 && $g1.date.month ==12 && $g1.date.day   ==31 &&
    $g1.time.hour==23   && $g1.time.minute==59 && $g1.time.second==59 ,
    'gmtime at 1999-12-31 23:59:59';
ok  $g1.date.day-name=='Friday' && $g1.date.month-name eq 'December' &&
    $g1.date.iso8601 eq '1999-12-31' && $g1.time.iso8601 eq '23:59:59',
    '1999-12-31 23:59:59 was on a Friday in December';

$g1 = Time.gmtime(++$t); # one second later, sing Auld Lang Syne.
ok  $g1.date.year==2000 && $g1.date.month == 1 && $g1.date.day   == 1 &&
    $g1.time.hour==0    && $g1.time.minute== 0 && $g1.time.second== 0 ,
    'gmtime at 2000-01-01 00:00:00';
ok  $g1.date.day-of-week==7 && $g1.date.month-name eq 'January' &&
    $g1.date.iso8601 eq '2000-01-01' && $g1.time.iso8601 eq '00:00:00',
    '2000-01-01 00:00:00 was on a Saturday in January';

$t  = time;
$d  = (int($t/86400) + 4) % 7 + 1;
$g1 = Time.gmtime($t);
$g2 = Time.gmtime;            # $g1 and $g2 might differ very occasionally
ok  $g1.date.year  ==$g2.date.year   && $g1.date.month ==$g2.date.month &&
    $g1.date.day   ==$g2.date.day    && $g1.time.hour  ==$g2.time.hour  &&
    $g1.time.minute==$g2.time.minute && $g1.time.second==$g2.time.second,
    'gmtime defaults to current time';
ok  $g2.date.day-of-week==$d,
    "today, {$g2.date} {$g2.time}," ~
    " is a {$g2.date.day-name} in {$g2.date.month-name}";

# compare dates for a series of times earlier and later than "now"
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
my ($t1, $t2, $offset = 8765); # 
for 1..5 -> $test {
    $t1 = $t - $offset;
    $g1 = Time.gmtime( $t1 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t1);
    ok $g1.date.day==$mday && $g1.date.month==$mon+1 && $g1.date.year==$year+1900 &&
       $g1.time.hour==$hour && $g1.time.minute==$min && $g1.time.second==$sec &&
       $g1.date.day-of-week==$wday+1,
    "crosscheck {$g1.date} {$g1.time}";
    $t2 = $t + $offset;
    $g2 = Time.gmtime( $t2 );
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = test_gmtime($t2);
    ok $g2.date.day==$mday && $g2.date.month==$mon+1 && $g2.date.year==$year+1900 &&
       $g2.time.hour==$hour && $g2.time.minute==$min && $g2.time.second==$sec &&
       $g2.date.day-of-week==$wday+1,
    "crosscheck {$g2.date} {$g2.time}";
    $offset *= 19;
}


# An independent calculation to cross check the Temporal algorithms.
sub test_gmtime( Num $t is copy ) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
    $sec  = int($t) % 60; $t = int($t/60); # $t is now epoch minutes
    $min  = $t % 60;      $t = int($t/60); # $t is now epoch hours
    $hour = $t % 24;      $t = int($t/24); # $t is now epoch days
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
