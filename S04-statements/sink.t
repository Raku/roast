use v6.c;
use Test;

plan 2;

# RT #117235
{
    my $c = [[1], [2], [3]].map( { $_ } ).Array;
    $c.unshift(7);
    is $c.elems, 4, ".unshift in sink context doesn't empty Array";
}

# RT #117923
{
    eval-lives-ok "List.sink", "can sink a List";
}
