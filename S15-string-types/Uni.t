use v6.c;
use Test;

plan 15;

my $uni = Uni.new(0x0044, 0x0307, 0x0323);

is $uni.codes, 3, '.codes works on a Uni';
is $uni.elems, 3, '.elems works on a Uni';
is +$uni, 3, 'numifying a Uni gives number of elems';
is $uni.Int, 3, 'Int-ifying a Uni gives number of elems';
is $uni.list, (0x0044, 0x0307, 0x0323), '.list works on a Uni';

is $uni[0], 0x0044, 'array indexing works on a Uni (1)';
is $uni[1], 0x0307, 'array indexing works on a Uni (2)';
is $uni[2], 0x0323, 'array indexing works on a Uni (3)';

ok $uni[0]:exists, 'exists works on Uni (1)';
ok $uni[2]:exists, 'exists works on Uni (2)';
nok $uni[3]:exists, 'exists works on Uni (3)';

is $uni.perl, 'Uni.new(0x0044, 0x0307, 0x0323)', '.perl works on Uni';
is $uni.gist, 'Uni:0x<0044 0307 0323>', '.gist works on Uni';

ok $uni, 'A non-empty Uni boolifies to true';
nok Uni.new, 'An empty Uni boolifies to false';
