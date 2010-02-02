use v6;
use Test;

plan *;

{
    my $r = RangeIter.new(1..5);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, 1, '$r.get == 1';
    is $r.get, 2, '$r.get == 2';
    is $r.get, 3, '$r.get == 3';
    is $r.get, 4, '$r.get == 4';
    is $r.get, 5, '$r.get == 5';
    is $r.get, EMPTY, '$r.get is done';
    is $r.get, EMPTY, '$r.get is still done';
}

{
    my $r = RangeIter.new(-1.5.Num..^3);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -1.5, '$r.get == -1.5';
    is $r.get, -.5, '$r.get == -0.5';
    is $r.get, .5, '$r.get == .5';
    is $r.get, 1.5, '$r.get == 1.5';
    is $r.get, 2.5, '$r.get == 2.5';
    is $r.get, EMPTY, '$r.get is done';
    is $r.get, EMPTY, '$r.get is still done';
}

# Heh.  skip doesn't work for ng1 yet?
# #?rakudo skip 'cmp doesn't work for Rat yet'
# {
#     my $r = RangeIter.new(-1.5..^3);
#     isa_ok $r, RangeIter, '$r is a RangeIter';
#     is $r.get, -1.5, '$r.get == -1.5';
#     is $r.get, -.5, '$r.get == -0.5';
#     is $r.get, .5, '$r.get == .5';
#     is $r.get, 1.5, '$r.get == 1.5';
#     is $r.get, 2.5, '$r.get == 2.5';
#     is $r.get, EMPTY, '$r.get is done';
#     is $r.get, EMPTY, '$r.get is still done';
# }

{
    my $r = RangeIter.new(-1.5.Num^..3);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -.5, '$r.get == -0.5';
    is $r.get, .5, '$r.get == .5';
    is $r.get, 1.5, '$r.get == 1.5';
    is $r.get, 2.5, '$r.get == 2.5';
    is $r.get, EMPTY, '$r.get is done';
    is $r.get, EMPTY, '$r.get is still done';
}

done_testing;
