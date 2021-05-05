use Test;

plan 90;

# Testing fractional instants to hundredths of a second

my @t = [
    # Data derived from the NASA JPL Time Conversion Tool
    # Gregorian date | Julian date | number of decimal places in JD
    ['2021-04-28T02:39:50.40Z', 2_459_332.611, 3],
    ['2021-05-02T11:56:46.12Z', 2_459_336.997756, 6],
    ['2023-02-24T14:57:46.6Z', 2_460_000.123456, 6],
    ['2026-06-07T07:57:46.08Z', 2_461_198.8317833, 7],
    ['2034-05-11T21:31:14.22Z', 2_464_094.3966924, 7],
    ['2044-05-11T21:31:14.22Z', 2_467_747.3966924, 7],
    ['2054-05-11T21:31:14.22Z', 2_471_399.3966924, 7],
    ['3026-06-07T07:57:46.08Z', 2_826_440.8317833, 7],
    ['4026-12-31T01:43:43.31Z', 3_191_890.5720291, 7],
];

my $tnum = 0;

# The official start date for the Gregorian calendar
# was October 15, 1582.
constant GC = DateTime.new: :1582year, :10month, :15day;
constant POS0 = 2_440_587.5; # JD in Gregorian calendar (1970-01-01T00:00:00Z)
constant MJD0 = 2_400_000.5; # JD in Gregorian calendar (1858-11-17T00:00:00Z)
constant sec-per-day = 86_400;

for @t -> $arr {
    ++$tnum;
    my $DT  = DateTime.new: $arr[0];
    my $JD  = $arr[1];
    my $ndp = $arr[2]; # number of decimal places in $JD

    # check the Raku implementations

    # Given the Julian Date (JD) of an instant, determine its Gregorian UTC
    # use the input test value $JD
    my $days = $JD - POS0;          # days from the POSIX epoch to the desired JD
    my $psec = $days * sec-per-day; # days x seconds-per-day
    my $date = DateTime.new($psec); # the desired UTC

    # 6 tests:
    is $date.hour, $DT.hour, "=== data point $tnum: cmp JD to DateTime hour";
    is $date.minute, $DT.minute, "cmp JD to DateTime minute";

    my $dsec = sprintf '%-0.*f', 2, $date.second;
    my $Dsec = sprintf '%-0.*f', 2, $DT.second;
    is $dsec, $Dsec, "cmp JD to DateTime second (hundredths)";

    is $date.year, $DT.year, "cmp JD to DateTime year";
    is $date.month, $DT.month, "cmp JD to DateTime month";
    is $date.day, $DT.day, "cmp JD to DateTime day";

    # Given a Gregorian instant (UTC), determine its Julian Date (JD)
    # 4 tests:
    {
        # We need the fractional seconds to add to the integral posix value
        my $frac-sec = $DT.second - $DT.second.Int;
        my $psec  = $DT.posix + $frac-sec;
        my $pdays = $psec/sec-per-day;
        my $jd    = sprintf '%-0.*f', $ndp, $pdays + POS0;
        is $jd, $JD, "cmp JD from DateTime.posix + frac-sec";
    }

    {
        my $mjd = $DT.daycount;
        $mjd   += $DT.day-fraction;
        my $jd  = sprintf '%-0.*f', $ndp, $mjd + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $jd, $JD, "cmp JD from DateTime.daycount + day-fraction";
    }

    {
        my $jd  = sprintf '%-0.*f', $ndp, $DT.julian-date;
        is $jd, $JD, "cmp JD from DateTime.julian-date";
    }

    {
        my $mjd = $DT.modified-julian-date;
        my $jd  = sprintf '%-0.*f', $ndp, $mjd + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $jd, $JD, "cmp JD from DateTime.modified-julian-date";
    }
}
