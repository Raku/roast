use Test;

plan 128;

my %jpl =
    # using test data from the JPL website:
    #     https://ssd.jpl.nasa.gov/tc.cgi

    '+2000-01-01T11:59:59.99Z' => [2451544.9999999, 'Saturday', 6, 0.4999999, 1 ],
    '+2000-01-01T12:00:00.00Z' => [2451545, 'Saturday', 6, 0.5, 1 ],
    '+2000-01-01T13:00:00.01Z' => [2451545.0416668, 'Saturday', 6, 0.5416668, 1 ],
    '+2000-01-01T23:59:59.99Z' => [2451545.4999999, 'Saturday', 6, 0.9999999, 1 ],
    '+2000-01-02T00:00:00.00Z' => [2451545.5, 'Sunday', 7, 0, 2 ],
    '+2000-01-01T00:00:00.01Z' => [2451544.5000001, 'Saturday', 6, 0.0000001, 1 ],
    '+3000-01-01T11:59:59.99Z' => [2816787.9999999, 'Wednesday', 3, 0.4999999, 1 ],
    '+3000-01-01T12:00:00.00Z' => [2816788, 'Wednesday', 3, 0.5, 1 ],
    '+3000-01-01T13:00:00.01Z' => [2816788.0416668, 'Wednesday', 3, 0.5416668, 1 ],
    '+3000-01-01T23:59:59.99Z' => [2816788.4999999, 'Wednesday', 3, 0.9999999, 1 ],
    '+3000-01-02T00:00:00.00Z' => [2816788.5, 'Thursday', 4, 0, 2 ],
    '+3000-01-01T00:00:00.01Z' => [2816787.5000001, 'Wednesday', 3, 0.0000001, 1 ],
    '+4000-01-01T11:59:59.99Z' => [3182029.9999999, 'Saturday', 6, 0.4999999, 1 ],
    '+4000-01-01T12:00:00.00Z' => [3182030, 'Saturday', 6, 0.5, 1 ],
    '+4000-01-01T13:00:00.01Z' => [3182030.0416668, 'Saturday', 6, 0.5416668, 1 ],
    '+4000-01-01T23:59:59.99Z' => [3182030.4999999, 'Saturday', 6, 0.9999999, 1 ],
    '+4000-01-02T00:00:00.00Z' => [3182030.5, 'Sunday', 7, 0, 2 ],
    '+4000-01-01T00:00:00.01Z' => [3182029.5000001, 'Saturday', 6, 0.0000001, 1 ],
;


# the difference between MJD and JD
constant MJD-offset = 2_400_000.5;

for %jpl.kv -> $JPL-utc, $JPL-out {
    # get all the data of interest in desired formats
    my $JPL-jd      = $JPL-out[0];
    my $JPL-jdday   = $JPL-jd.truncate;
    my $JPL-mjd     = $JPL-jd - MJD-offset;
    my $JPL-mjdday  = $JPL-mjd.truncate;
    my $JPL-dow     = $JPL-out[2];
    my $JPL-mjdfrac = frac $JPL-mjd;
    my $JPL-dayfrac = $JPL-out[3];
    my $JPL-doy     = $JPL-out[4];

    # get our data from the input utc as a DateTime object
    my $dt       = DateTime.new: $JPL-utc;
    my $mjd      = $dt.modified-julian-date;
    my $jd       = $dt.julian-date;
    my $day-frac = $dt.day-fraction;
    my $mjdday   = $dt.daycount;
    my $dow      = $dt.day-of-week;
    my $doy      = $dt.day-of-year;

    # check integral values
    is $mjdday, $JPL-mjdday, "cmp MJD.Int: got ($mjdday) vs exp ($JPL-mjdday)";
    is $dow, $JPL-dow, "cmp day-of-week: got ($dow) vs exp ($JPL-dow)";
    is $doy, $JPL-doy, "cmp day-of-year: got ($doy) vs exp ($JPL-doy)";

    # check decimal values for MJD and JD
    my $np-JPL-mjd     = ndp $JPL-mjd;
    my $np-JPL-jd      = ndp $JPL-jd;
    my $np-JPL-mjdfrac = ndp $JPL-mjdfrac;
    my $np-JPL-dayfrac = ndp $JPL-dayfrac;

    $mjd      = sprintf '%.*f', $np-JPL-mjd, $mjd;
    $jd       = sprintf '%.*f', $np-JPL-jd, $jd;
    $day-frac = sprintf '%.*f', $np-JPL-mjdfrac, $day-frac;

    is $mjd, $JPL-mjd, "cmp MJD: got ($mjd) vs exp ($JPL-mjd)";
    is $jd, $JPL-jd, "cmp JD: got ($jd) vs exp ($JPL-jd)";
    is $day-frac, $JPL-mjdfrac, "cmp day-fraction: got ($day-frac) vs exp ($JPL-mjdfrac)";
    is $day-frac, $JPL-dayfrac, "cmp day-fraction: got ($day-frac) vs exp2 ($JPL-dayfrac)";
}

# Two subs needed for stand-alone testing with no external dependencies
# (both are from Math::FractionalPart):
sub frac($x) {
    $x - floor($x)
}
sub ndp($x) {
    my $f = frac $x;
    $f == 0 ?? 0
            !! ($f.chars-2)
}

is-deeply DateTime.new(1972,6,29,12,0,0).day-fraction, .5,
  "noon on a date without a leap second";
is-deeply DateTime.new(1972,6,30,12,0,0).day-fraction, 43200/86401,
  "noon on a date with a leap second";

# vim: expandtab shiftwidth=4
