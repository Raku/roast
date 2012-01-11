# http://perl6advent.wordpress.com/2009/12/05/day-5-metaoperator/

use v6;
use Test;

plan 17;

my $a = 4;
my $b = 2;
my @a = 2, 4, 6, 8;
my @b = 16, 14, 12, 10;

my @a_copy;
my $a1;
my $a2;

is ([+]  1, $a, 5, $b), (1 + $a + 5 + $b), 'Reduce metaop becomes an infix list op';
is ([+] @a), 20, 'Sum all elements in a list';
is ([*] @a), 384, 'Multiply all elements in a list';
ok ([<=] @a), 'All elements of list are numerically sorted';
nok ([<=] @b), 'Not all elements of list are numerically sorted';
is ([min] @a, @b), 2, 'Find the smallest element of two lists';
is (@a »+« @b), [18, 18, 18, 18], 'Hyper operator - pairwise addition';
is (@a_copy = @a; @a_copy»++; @a_copy), [3, 5, 7, 9], 'Hyper operator - increment all elements in a list';
#?niecza skip "Strange internal crash"
is (@a »min« @b), [2, 4, 6, 8], 'Hyper operator - finding minimum elements';
is (@a »*» 3.5), [7, 14, 21, 28], 'Hyper operator - multiply each element by 3.5';
is (@a »*» $a »+» $b), [10, 18, 26, 34], 'Hyper operator - multiple each element by $a and add $b';
is (1 «/« @a;), [1/2, 1/4, 1/6, 1/8], 'Hyper operator - invert all elements';
#?niecza skip "Strange internal crash"
is ((@a »~» ', ') »~« @b), ["2, 16", "4, 14", "6, 12", "8, 10"], 'Hyper operator - concat @a and @b';
is ([+] ( @b »**» 2)), 696, 'Hyper operator - sum of squares';
is ($a1 = $a; $a1 += 5;), ($a2 = $a; $a2 = $a2 + 5), 'In-place += operator is a meta form of + with = suffix';
is ($a1 = $a; $a1 //= 7;), ($a2 = $a; $a2 = $a2 // 7), 'In-place //= operator is a meta form of // with = suffix';
is ($a1 = $a; $a1 min= $b;), ($a2 = $a; $a2 = $a2 min $b), 'In-place min= operator is a meta form of min with = suffix';

done;
