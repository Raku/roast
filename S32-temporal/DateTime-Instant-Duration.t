use v6;
use Test;

plan 33;

=begin pod

DateTime is the only means of constructing arbitrary Instants,
so we test some of the properties of Instants and Durations here
rather than in S02/instants-and-duration.t.

=end pod

sub dtp($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second)
}

sub dtpi($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second).Instant
}

sub dti(*%args) { DateTime.new(|{year => 1984, %args}).Instant }

sub dsi($s) { DateTime.new($s).Instant }

sub diff(%early = (), *%late) { + do dti(|%late) - dti(|%early) }

sub days($n) { $n * 24 * 60 * 60 }


# L<S32::Temporal/Accessors/'the method Instant'>

isa_ok dti, Instant, 'DateTime.Instant returns an Instant';
is dti, dti, 'Equal DateTimes yield equal Instants';
is diff, 0, 'The difference of equal Instants is 0';

ok dsi('2005-12-31T23:59:60') < dsi('2006-01-01T00:00:00'), 'DateTime.Instant counts leap seconds';
  # These seconds have equal POSIX times.

is diff(second => 5), 5, 'Instant subtraction (seconds)';
is diff(second => 2/7), 2/7, 'Instant subtraction (non-integral seconds)';
#?rakudo skip 'high-precision Instants NYI (need FatRats)'
is diff(second => 3.14159), 3.14159, 'Instant subtraction (needing high precision)';
is diff(minute => 15), 15 * 60, 'Instant subtraction (minutes)';
is diff(:hour(3), :minute(15), :second(33)),
    3*60*60 + 15*60 + 33, 'Instant subtraction (HMS)';
is diff(day => 4), days(3), 'Instant subtraction (days)';
is diff(month => 2), days(31), 'Instant subtraction (a month)';
is diff(month => 3), days(31 + 29), 'Instant subtraction (Jan and Feb, leap year)';
is diff({year => 1985}, year => 1985, month => 3), days(31 + 28), 'Instant subtraction (Jan and Feb, common year)';
is diff(:year(1985), :month(3), :day(14)),
    days(366 + 31 + 28 + 13), 'Instant subtraction (YMD)';
is +(DateTime.new('1985-03-14T13:28:22').Instant - dti),
    days(366 + 31 + 28 + 13) + 13*60*60 + 28*60 + 22, 'Instant subtraction (YMDHMS)';

{
    my $a = dtp(2004, 12, 31,   23, 57,  8.5);
    my $b = dtp(2005,  1,  1,    2, 22, 13.4);
    my $expected-diff = 60 - 8.5 + 2*60 + 2*60*60 + 22*60 + 13.4;
    is +($b.Instant() - $a.Instant), $expected-diff, 'Instant subtraction (ugly case)';
    
    $a .= clone(timezone => 35*60 - 5);
    $b .= clone(timezone => 3*60*60);
    is +($a.Instant() - $b.Instant), 0.1, 'Instant subtraction (time zones)';

    diff({:year(1997), :month(6), :day(30)},
            :year(1997), :month(7), :day(1)),
        days(1) + 1, 'Instant subtraction (June 30 leap second)';
    $a .= clone(year => 2005, timezone => 0);
    $b .= clone(year => 2006, timezone => 0);
    is +($b.Instant() - $a.Instant), $expected-diff + 1, 'Instant subtraction (December 31 leap second)';

    $a = DateTime.new('2006-01-01T12:33:58+1234');
      # In UTC, $a is 2005-12-31T23:59:58.
    $b = DateTime.new('2006-01-01T12:44:03+1244');
      # In UTC, $b is 2006-01-01T00:00:03.
    is +($b.Instant() - $a.Instant), 6, 'Instant subtraction (leap second and time zones)';

    $a .= clone(year => 1973);
    $b .= clone(year => 2008);
    is +($b.Instant() - $a.Instant), 1_104_451_227, 'Instant subtraction (thirty-year span)';
      # I got this figure by adding 22 (the number of leap seconds 
      # between the two moments) to the difference of POSIX
      # times.
}

# L<S32::Temporal/C<DateTime>/DateTime.new(now)>

is ~DateTime.new(dsi('2004-03-05T12:43:22')), '2004-03-05T12:43:22Z', 'Round-tripping DateTime.Instant (2004-03-05T12:43:22Z)';
is ~DateTime.new(dsi('2005-12-31T23:59:59')), '2005-12-31T23:59:59Z', 'Round-tripping DateTime.Instant (2005-12-31T23:59:59Z)';
is ~DateTime.new(dsi('2005-12-31T23:59:60')), '2005-12-31T23:59:60Z', 'Round-tripping DateTime.Instant (2005-12-31T23:59:60Z)';
is ~DateTime.new(dsi('2006-01-01T00:00:00')), '2006-01-01T00:00:00Z', 'Round-tripping DateTime.Instant (2006-01-01T00:00:00Z)';

is DateTime.new(dtpi 2005, 12, 31,   23, 59, 59.5).second, 59.5, 'Round-tripping DateTime.Instant (2005-12-31T23:59:59.5Z)';
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 60.5).second, 60.5, 'Round-tripping DateTime.Instant (2005-12-31T23:59:60.5Z)';
is DateTime.new(dtpi 2006,  1,  1,    0,  0,  0.5).second,  0.5, 'Round-tripping DateTime.Instant (2006-01-01T00:00:00.5Z)';

#?rakudo 3 skip 'high-precision Instants NYI (need FatRats)'
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 59.2).second, 59.2, 'Round-tripping DateTime.Instant (2005-12-31T23:59:59.2Z)';
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 60.2).second, 60.2, 'Round-tripping DateTime.Instant (2005-12-31T23:59:60.2Z)';
is DateTime.new(dtpi 2006,  1,  1,    0,  0,  0.2).second,  0.2, 'Round-tripping DateTime.Instant (2006-01-01T00:00:00.2Z)';


{
    my $last-t = time;
    my $t;
    loop { # Loop until we reach the beginning of the next second.
        $t = time;
        last if $t > $last-t;
        $last-t = $t;
    }
    my $i = now;    # $t and $i are supposed to be within the
                    # same UTC second, but if we're unlucky they
                    # might not be.
    is ~DateTime.new($i), ~DateTime.new($t), 'DateTime.new(now)';
}

{
    my $dt = DateTime.new(dsi('1999-12-31T23:59:59'),
        timezone => -(5*60*60 + 55*60),
        formatter => { .day ~ '/' ~ .month ~ '/' ~ .year ~ ' ' ~
                       .second ~ 's' ~ .minute ~ 'm' ~ .hour ~ 'h' });
    is ~$dt, '31/12/1999 59s4m18h', 'DateTime.new(Instant) with time zone and formatter';
}

#?rakudo todo 'nom regression'
{
    my $i = dtpi 1988, 11, 22,   18, 42, 15.9;
    is $i.perl.eval, $i, 'Round-tripping Instant.perl';
}

# vim: ft=perl6
