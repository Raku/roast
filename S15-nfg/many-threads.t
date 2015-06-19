use Test;

plan 4;

my @unis = eager [eager Uni.new((800..850).pick(5)) xx 1000] xx 4;
my @promises = do for ^4 -> $t {
    start .Str for @unis[$t];
}
await @promises;

is @promises[0].result.elems, 1000, 'Thread 1 made strings successfully';
is @promises[1].result.elems, 1000, 'Thread 2 made strings successfully';
is @promises[2].result.elems, 1000, 'Thread 3 made strings successfully';
is @promises[3].result.elems, 1000, 'Thread 4 made strings successfully';
