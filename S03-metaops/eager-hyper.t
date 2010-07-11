use v6;

use Test;

plan 8;

# L<S02/Lists/To force non-lazy list processing, use the eager list operator>

# Laziness test
{
    my $counter = 0;
    my @test = gather { for 1 .. 5 { $counter++; take $_ } };
    is(@test[0], 1, 'iterator works as expected');
    #?rakudo todo "Array assignment is not lazy -- is this test wrong?"
    is($counter, 1, 'iterator was lazy and only ran the block once');
}

# "Counting the elements in the array will also force eager completion."
{
    my $counter = 0;
    my @test = gather { for 1 .. 5 { $counter++; take $_ } };
    is(@test.elems, 5, 'iterator has expected length');
    is($counter, 5, 'iterator was lazy and only ran the block once');
}

# Eager
{
    my $counter = 0;
    my @test = eager gather { for 1 .. 5 { $counter++; take $_ } };
    is(@test[0], 1, 'iterator works as expected');
    is($counter, 5, 'iterator was eager and calculated all the values');
}

# L<S02/Lists/A variant of eager is the hyper list operator>
# Hyper
#?rakudo skip 'hyper prefix NYI'
{
    my $counter = 0;
    my @test = hyper gather { for 1 .. 5 { $counter++; take $_; } };
    is(sort @test, <1 2 3 4 5>, 'hyper returned all the values in some order');
    is($counter, 5, 'iterator was hyper and calculated all the values');
}

# vim: ft=perl6
