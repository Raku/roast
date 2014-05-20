# http://perl6advent.wordpress.com/2010/12/16/day-16-time-in-perl6/
use v6;
use Test;
plan 13;

isa_ok time, Int, 'time';
isa_ok now, Instant, 'now';

my $moment = DateTime.new(now);
isa_ok $moment, DateTime, 'DateTime from now';

my $moment2 = DateTime.new(time);
isa_ok $moment2, DateTime, 'DateTime from time';

my $date-str = '1963-11-23T17:15:00Z';

my $dw = DateTime.new(:year(1963), :month(11), :day(23), :hour(17), :minute(15));
is $dw.offset, 0, 'default timezone (utc, zero offset)';
is $dw.gist, $date-str, 'date display';

$dw = DateTime.new($date-str);
is $dw.gist, $date-str, 'date from string';

# ... "only :year is required, the rest defaults to midnight on
# January 1 of the year"

$dw = DateTime.new(:year(1963));
is $dw.gist, '1963-01-01T00:00:00Z', 'DateTime defaults';

# ... "The Z denotes UTC. To change that, replace Z with +hhmm
# or -hhmm, where ‘hh’ is the number of hours offset and ‘mm’
# the number of minutes.

$dw = DateTime.new('1963-11-23T17:15:00+0130');
is $dw.offset-in-minutes, 90, 'date offset';
is $dw.gist,'1963-11-23T17:15:00+0130', 'date offset';

$dw = DateTime.new('1963-11-23T17:15:00-0145');
is $dw.offset-in-minutes, -105, 'date negative offset';
is $dw.gist,'1963-11-23T17:15:00-0145', 'date negative offset';

my $jfk = Date.new("1963-11-22");
$jfk++;
is $jfk.gist, '1963-11-23', 'date increment';
