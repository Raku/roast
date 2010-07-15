use v6;
use Test;

plan 2;

use DateTime::strftime;

# Try currently implemented strftime() formats
my $g1 = DateTime.new(:year(1582), :month(10), :day(4),
                   :hour(13),   :minute(2), :second(3.654321) );

my $format = '%Y/%m/%d %H:%M:%S %C%e %I=%k%l%t%3N%p %a,%F%%.%n';
my $need = "1582/10/04 13:02:03 15 4 01=13 1\t654pm Mon,1582-10-04%.\n";
is strftime($format, $g1), $need, 'first strftime'; # test 1

$g1 = DateTime.new(:year(1), :month(2),  :day(3),
                   :hour(4), :minute(5), :second(6.987654) );

$format = '%I %6N %A %b=%B';
$need = "04 987654 Saturday Feb=February";
is strftime($format, $g1), $need, 'second strftime'; # test 2

