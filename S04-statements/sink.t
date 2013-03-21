use v6;
use Test;

plan 1;

# RT #117235
{
    my $c = [[1], [2], [3]].map( { $_ } );
    $c.unshift(7);
    is $c.elems, 4, ".unshift in sink context doesn't empty Array";
}
