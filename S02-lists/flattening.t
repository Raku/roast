# based on http://pmthium.com/2014/10/apw2014/

use v6;

use Test;

plan 5;

is ((1, 2), (3, 4), (5, 6))[1].join('|'), '3|4', 'indexing does not flatten';
isa_ok (1, 2), List, 'Comma-separated list is of type List';

is ((1, 2), (3, 4)).map(*.join('|')).join(' '), '1|2 3|4', '.map does not flatten';
is ((1, 2), (3, 4)).for(*.join('|')).join(' '), '1 2 3 4', '.for flattens';
{
    my $cnt = 0;
    my @sink = map { ++$cnt; $_ }, 1, (2, 3), (4, 5);
    is $cnt, 5, 'sub form of map flattens';
}
{
    my @a = 1, 2;
    my @b = 3, 4;
    isa_ok (@a, @b).pick, Array, '.pick does not flatten';
    isa_ok pick(1, @a, @b), Int, '&pick flattens';
}

done;
