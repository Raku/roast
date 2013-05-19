use v6;
use Test;

plan 2;

# RT #117235
#?rakudo todo "RT #117235"
{
    my $c = [[1], [2], [3]].map( { $_ } );
    $c.unshift(7);
    is $c.elems, 4, ".unshift in sink context doesn't empty Array";
}

# RT #117923
#?pugs skip 'no such method'
{
    eval_lives_ok "List.sink", "can sink a List";
}
