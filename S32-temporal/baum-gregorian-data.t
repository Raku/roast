use Test;

plan 209;

# New Julian Date reference, from an online site:
#     https://researchgate.net/publication/316558298
# 
# Author: Peter Baum, Aesir Research
# 
# Article: Date Algorithms
#          Version: 5
#          Last modified: October 21, 2020
# 
# The article Provides lots of test data as well as the best 
# description of Julian Date versus calendars I've found.  
# The test data in Table 2 have been checked against the NASA 
# JPL Time Conversion Tool and the Gregorian data are tested 
# here against Raku. 
#
# Important note: No test data herein have fractional seconds.
my @baum-test-data = [
    # Table 2 Gregorian data
    # 19 data points
    # Gregorian date   Julian date
    #    Y   M  D        JD        number of decimal places in JD
    [-4713, 11, 24.0, -0.5, 1],
    [-4713, 11, 24.5, 0.0, 0],
    [-4713, 11, 25.0, 0.5, 1],
    [-4712, 1, 1.0, 37.5, 1],
    [-4712, 1, 1.5, 38.0, 0],
    [-4712, 1, 2.0, 38.5, 1],
    [0, 1, 1.0, 1721059.5, 1],
    [0, 2, 29.0, 1721118.5, 1],
    [0, 3, 1.0, 1721119.5, 1],
    [0, 12, 31.0, 1721424.5, 1],
    [1, 1, 1.0, 1721425.5, 1],
    [1582, 10, 4.0, 2299149.5, 1],
    [1582, 10, 15.0, 2299160.5, 1],
    [1840, 12, 31.0, 2393470.5, 1],
    [1858, 11, 17.0, 2400000.5, 1],
    [1900, 1, 1.0, 2415020.5, 1],
    [1901, 1, 1.0, 2415385.5, 1],
    [1970, 1, 1.0, 2440587.5, 1],
    [1980, 1, 1.0, 2444239.5, 1],
];

my $tnum = 0;

# The official start date for the Gregorian calendar
# was October 15, 1582.
constant GC = DateTime.new: :1582year, :10month, :15day;
constant POS0 = 2440587.5; # JD in Gregorian calendar (1970-01-01T00:00:00Z)
constant MJD0 = 2400000.5; # JD in Gregorian calendar (1858-11-17T00:00:00Z)
constant sec-per-day = 86400;

for @baum-test-data -> $arr {
    ++$tnum;
    my $ye  = $arr[0];
    my $mo  = $arr[1];
    my $da  = $arr[2]; # a real number
    my $JD  = $arr[3];
    my $ndp = $arr[4]; # number of decimal places in $JD

    my ($day-frac, $day) = modf $da;
    my ($ho, $mi, $se) = day-frac2hms $day-frac;
 
    # check the Raku implementations

    # Given the Julian Date (JD) of an instant, determine its Gregorian UTC
    # use the input Baum test value $JD
    my $days = $JD - POS0;          # days from the POSIX epoch to the desired JD
    my $psec = $days * sec-per-day; # days x seconds-per-day
    my $date = DateTime.new($psec); # the desired UTC

    # 6 tests:
    is $date.hour, $ho, "cmp JD to DateTime hour";
    is $date.minute, $mi, "cmp JD to DateTime minute";
    is $date.second, $se, "cmp JD to DateTime second";
    is $date.year, $ye, "cmp JD to DateTime year";
    is $date.month, $mo, "cmp JD to DateTime month";
    is $date.day, $day, "cmp JD to DateTime day";

    # Given a Gregorian instant (UTC), determine its Julian Date (JD)
    my $d = DateTime.new: :year($ye), :month($mo), :day($day), :hour($ho), :minute($mi), :second($se);
    # 5 tests:
    {
        my $psec  = $d.posix;
        my $pdays = $psec/sec-per-day;
        my $jd    = sprintf '%-0.*f', $ndp, $pdays + POS0;
        is $jd, $JD, "cmp JD from DateTime.posix";
    }

    {
        my $mjd = $d.daycount;
        $mjd   += day-frac $d;
        my $jd  = sprintf '%-0.*f', $ndp, $mjd + MJD0; # from the relationship: MJD = JD - 240000.5
        is $jd, $JD, "cmp JD from DateTime.daycount + day-frac";
    }

    {
        my $mjd = $d.daycount;
        $mjd   += $d.day-fraction;
        my $jd  = sprintf '%-0.*f', $ndp, $mjd + MJD0; # from the relationship: MJD = JD - 240000.5
        is $jd, $JD, "cmp JD from DateTime.daycount + day-fraction";
    }

    {
        my $jd  = sprintf '%-0.*f', $ndp, $d.julian-date;
        is $jd, $JD, "cmp JD from DateTime.julian-date";
    }

    {
        my $mjd = $d.modified-julian-date;
        my $jd  = sprintf '%-0.*f', $ndp, $mjd + MJD0; # from the relationship: MJD = JD - 240000.5
        is $jd, $JD, "cmp JD from DateTime.modified-julian-date";
    }
}

sub modf($x) {
    # splits $x into integer and fractional parts
    # note the sign of $x is applied to BOTH parts
    my $int-part  = $x.Int;
    my $frac-part = $x - $int-part;
    $frac-part, $int-part;
}

sub day-frac2hms(Real $x, :$debug --> List) {
    my $hours   = $x * 24;
    my $hour    = $hours.Int;
    my $minutes = ($hours - $hour) * 60;
    my $minute  = $minutes.Int;
    my $second  = ($minutes - $minute) * 60;
    $hour, $minute, $second
}

sub day-frac(DateTime:D $dt, :$debug --> Real) {
    constant sec-per-day = 24 * 60 * 60;
    # get seconds in this day
    my $frac = $dt.hour * 60 * 60;
    $frac += $dt.minute * 60;
    $frac += $dt.second;
    # the day fraction
    $frac /= sec-per-day;
}

