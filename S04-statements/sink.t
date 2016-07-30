use v6;
use Test;

plan 3;

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

# RT #127491
{
    my $sunk = False;
    my ($a) = class { method sink { $sunk = True } }.new;
    is $sunk, False, 'my ($a) = ... does not trigger sinking';
}
