use v6;
use Test;

plan 4;

my @promises = do for ^4 -> $t {
    start (Uni.new((800..850).pick(5)) xx 2000)>>.Str;
}
await @promises;

is @promises[0].result.elems, 2000, 'Thread 1 made strings successfully';
is @promises[1].result.elems, 2000, 'Thread 2 made strings successfully';
is @promises[2].result.elems, 2000, 'Thread 3 made strings successfully';
is @promises[3].result.elems, 2000, 'Thread 4 made strings successfully';
