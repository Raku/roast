use v6;
use Test;

=begin pod

DateTime is the only means of constructing arbitrary Instants,
so we test some of the properties of Instants and Durations here
rather than in S02/instants-and-duration.t.

=end pod

sub dti(*%args) { DateTime.new(year => 1984, |%args).Instant }

sub diff(%early = (), *%late) { + do dti(|%late) - dti(|%early) }

sub days($n) { $n * 24 * 60 * 60 }

plan *;

# L<S32::Temporal/Accessors/'the method Instant'>

isa_ok dti, Instant, 'DateTime.Instant returns an Instant';
is dti, dti, 'Equal DateTimes yield equal Instants';
is diff, 0, 'The difference of equal Instants is 0';

is diff(second => 5), 5, 'Instant subtraction (seconds)';
is diff(second => 3.14159), 3.14159, 'Instant subtraction (non-integral seconds)';
is diff(minute => 15), 15 * 60, 'Instant subtraction (minutes)';
is diff(:hour(3), :minute(15), :second(33)),
    3*60*60 + 15*60 + 33, 'Instant subtraction (HMS)';
is diff(day => 3), days(3), 'Instant subtraction (days)';
is diff(month => 2), days(31), 'Instant subtraction (a month)';
is diff(month => 3), days(31 + 29), 'Instant subtraction (Jan and Feb, leap year)';
is diff({year => 1985}, month => 3), days(31 + 28), 'Instant subtraction (Jan and Feb, common year)';
is diff(:year(1985), :month(3), :day(14)),
    days(366 + 31 + 28 + 14), 'Instant subtraction (YMD)';
is +(dti() - DateTime.new('1985-03-14T13:28:22').Instant),
    days(366 + 31 + 28 + 14) + 13*60*60 + 28*60 + 22, 'Instant subtraction (YMDHMS)';

{
    my $a = DateTime.new(:year(2005), :month(1), :day(1),
        :hour(2), :minute(22), :second(13.4));
    my $b = DateTime.new(:year(2004), :month(12), :day(31),
        :hour(23), :minute(57), :second(8.5));
    my $expected-diff = 60 - 8.5 + 2*60 + 2*60*60 + 22*60 + 13.4;
    is +($b.Instant - $a.Instant), $expected-diff, 'Instant subtraction (ugly case)';
    
    $a .= clone(timezone => 3*60*60);
    $b .= clone(timezone => 35*60 - 5);
    is +($b.Instant - $a.Instant), 0.1, 'Instant subtraction (time zones)';

    diff({:year(1997), :month(6), :day(30)},
            :year(1997), :month(7), :day(1)),
        days(1) + 1, 'Instant subtraction (June 30 leap second)';
    $a .= clone(year => 2005, timezone => 0);
    $b .= clone(year => 2006, timezone => 0);
    is +($b.Instant - $a.Instant), $expected-diff + 1, 'Instant subtraction (December 31 leap second)';

    $a = DateTime.new('2006-01-01T12:33:58+1234')
      # In UTC, $a is 2005-12-31T23:59:58.
    $b = DateTime.new('2006-01-01T12:44:03+1244');
      # In UTC, $b is 2006-01-01T00:00:03.
    is +($b.Instant - $a.Instant), 6, 'Instant subtraction (leap second and time zones)';

    $a .= clone(year => 1973);
    $b .= clone(year => 2008);
    is +($b.Instant - $a.Instant), 1_104_451_227, 'Instant subtraction (thirty-year span)';
      # I got this figure by adding 22 (the number of leap seconds 
      # between the two moments) to the difference of POSIX
      # times.
}

# L<S32::Temporal/C<DateTime>/DateTime.new(now)>

# TODO

done_testing;

# vim: ft=perl6
