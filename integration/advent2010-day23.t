# http://perl6advent.wordpress.com/2010/12/23/day-23-its-some-sort-of-wonderful/
use v6;
use Test;
plan 8;

my @unsorted = <2 d1 Can by 0 d2 210 An 33rd Bit 3rd car 100 and ARE AND d10 21 144th 11 1>;

{
    my @sorted = @unsorted.sort: { .lc };
    is_deeply @sorted, [<0 1 100 11 144th 2 21 210 33rd 3rd
			An and AND ARE Bit by Can car d1 d10 d2>], 'sort case insensitively';
}

{
    my @sorted = @unsorted.sort: { .chars };
    is_deeply @sorted, [<2 0 1 d1 by d2 An 21 11 Can 210 Bit
			3rd car 100 and ARE AND d10 33rd 144th>], 'sort by word length, shortest to longest';
}

{
    my @sorted = @unsorted.sort: { -.chars };
     is_deeply @sorted, [<144th 33rd Can 210 Bit 3rd car 100
			 and ARE AND d10 d1 by d2 An 21 11 2 0 1>], 'sort by word length, longest to shortest';
}

{
    my @sorted = @unsorted.sort: { $^a.chars, $^a };
    is_deeply @sorted, [<0 1 2 11 21 An by d1 d2 100 210
			3rd AND ARE Bit Can and car d10 33rd 144th>], 'sort by word length, then default';

    my @sorted2 = @unsorted.sort.sort: { $^a.chars };
    is_deeply @sorted2, @sorted, 'double sort by default, then length';

    my @sorted3 = @unsorted.sort: { $^a.chars <=> $^b.chars || $^a leg $^b };
    is_deeply @sorted3, @sorted, 'double sort rewritten';
}

sub naturally ($a) {
    $a.lc.subst(/(\d+)/, -> $/ { 0 ~ $0.chars.chr ~ $0 }, :g) ~ "\x0" ~ $a
}

{
    my @sorted = @unsorted.sort: { $^a.&naturally };
    is_deeply @sorted, [<0 1 2 3rd 11 21 33rd 100 144th 210 An AND and ARE Bit by Can car d1 d2 d10>], 'natural sort';
}

{
    my @ips = <
	18.107.115.140  158.9.49.115  215.137.224.49  105.153.237.220
	168.247.162.96 227.151.192.185  144.93.99.39  39.251.30.20 
	32.226.142.3  172.135.164.3  131.166.239.179
	>;

    my @sorted = @ips.sort: { .&naturally };

    is_deeply @sorted, [
	<18.107.115.140  32.226.142.3  39.251.30.20  105.153.237.220
	131.166.239.179  144.93.99.39  158.9.49.115  168.247.162.96
	172.135.164.3  215.137.224.49  227.151.192.185>], "natural sort of ip's";
}
