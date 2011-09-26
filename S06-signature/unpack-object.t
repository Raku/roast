use v6;
use Test;
plan 2;

{
    my $tracker = '';
    for a => 1, b => 2 -> Pair $p (:$key, :$value) {
        $tracker ~= "|$key,$value";
    }
    is $tracker, '|a,1|b,2', 'unpacking a Pair';
}

{
    class A { has $.x };

    my $tracker = '';
    for A.new(x => 4), A.new(x => 2) -> $ (:$x) {
        $tracker ~= $x;
    }
    is $tracker, '42', 'unpacking attribute of custom class';
}
