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

{
    my $r = RangeIter.new(-1.5..^3);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -1.5, '$r.get == -1.5';
    is $r.get, -.5, '$r.get == -0.5';
    is $r.get, .5, '$r.get == .5';
    is $r.get, 1.5, '$r.get == 1.5';
    is $r.get, 2.5, '$r.get == 2.5';
    is $r.get, EMPTY, '$r.get is done';
    is $r.get, EMPTY, '$r.get is still done';
}

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

{
    my $r = RangeIter.new(-1..*);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -1, '$r.get == -1';
    is $r.get, 0, '$r.get == 0';
    is $r.get, 1, '$r.get == 1';
    is $r.get, 2, '$r.get == 2';
    is $r.get, 3, '$r.get == 3';
    is $r.get, 4, '$r.get == 4';
    is $r.get, 5, '$r.get == 5';
    loop (my $i = 0; $i < 100; $i++) {
        $r.get;  # 6 through 105
    }
    is $r.get, 106, '$r.get == 106';
}

{
    my $r = RangeIter.new(-1.5.Num..*);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -1.5, '$r.get == -1.5';
    is $r.get, -.5, '$r.get == -0.5';
    is $r.get, .5, '$r.get == .5';
    is $r.get, 1.5, '$r.get == 1.5';
    is $r.get, 2.5, '$r.get == 2.5';
    is $r.get, 3.5, '$r.get == 3.5';
    is $r.get, 4.5, '$r.get == 4.5';
}

{
    my $r = RangeIter.new(-1.5..*);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, -1.5, '$r.get == -1.5';
    is $r.get, -.5, '$r.get == -0.5';
    is $r.get, .5, '$r.get == .5';
    is $r.get, 1.5, '$r.get == 1.5';
    is $r.get, 2.5, '$r.get == 2.5';
    is $r.get, 3.5, '$r.get == 3.5';
    is $r.get, 4.5, '$r.get == 4.5';
}

{
    # Make sure we can read two different RangeIters at the same time.
    # (May sound like an odd test, but as I type this, if Range iteration
    #  were implemented with gather/take, this test would fail.)
    my $r1 = RangeIter.new(-1..*);
    my $r2 = RangeIter.new(42..*);
    isa_ok $r1, RangeIter, '$r1 is a RangeIter';
    isa_ok $r2, RangeIter, '$r2 is a RangeIter';
    is $r1.get, -1, '$r1.get == -1';
    is $r2.get, 42, '$r2.get == 42';
    is $r1.get, 0, '$r1.get == 0';
    is $r2.get, 43, '$r2.get == 43';
    is $r1.get, 1, '$r1.get == 1';
    is $r2.get, 44, '$r2.get == 44';
    is $r1.get, 2, '$r1.get == 2';
    is $r2.get, 45, '$r2.get == 45';
    is $r1.get, 3, '$r1.get == 3';
    is $r2.get, 46, '$r2.get == 46';
    is $r1.get, 4, '$r1.get == 4';
    is $r2.get, 47, '$r2.get == 47';
    is $r1.get, 5, '$r1.get == 5';
    is $r2.get, 48, '$r2.get == 48';
}

{
    my $r = RangeIter.new('d'..'g');
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, 'd', '$r.get == d';
    is $r.get, 'e', '$r.get == e';
    is $r.get, 'f', '$r.get == f';
    is $r.get, 'g', '$r.get == g';
    is $r.get, EMPTY, '$r.get is done';
    is $r.get, EMPTY, '$r.get is still done';
}

{
    my $r = RangeIter.new('d'..*);
    isa_ok $r, RangeIter, '$r is a RangeIter';
    is $r.get, 'd', '$r.get == d';
    is $r.get, 'e', '$r.get == e';
    is $r.get, 'f', '$r.get == f';
    is $r.get, 'g', '$r.get == g';
    is $r.get, 'h', '$r.get == h';
    is $r.get, 'i', '$r.get == i';
}

done_testing;
