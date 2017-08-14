use v6;
use Test;

plan 5;

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

# RT #127879
{
    my @results = gather for 1..1 { ^10 .map: *.take }

    is @results, "0 1 2 3 4 5 6 7 8 9", "map inside sunk 'for' runs as sunk";
}

{
    my $sunk = False;
    my sub wrap_in_scalar() is rw {
        my $var = class { method sink { $sunk = True } }.new;
        $var;
    }

    wrap_in_scalar();

    is $sunk, False, "we don't sink things that are wrapped in a container";
}
