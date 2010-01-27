use v6;
use Test;

plan *;

{
    my $r = RangeIterator.new(1..5);
    isa_ok $r, RangeIterator, '$r is a RangeIterator';
    is $r.get, 1, '$r.get == 1';
    is $r.get, 2, '$r.get == 2';
    is $r.get, 3, '$r.get == 3';
    is $r.get, 4, '$r.get == 4';
    is $r.get, 5, '$r.get == 5';
    is $r.get, IterDone, '$r.get is done';
    is $r.get, IterDone, '$r.get is still done';
}

done_testing;
