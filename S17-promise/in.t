use v6;
use Test;

plan 2;

{
    my $start = now;
    my $p = Promise.in(1);
    is $p.result, True, "Promise.in result is True";
    ok now - $start >= 1, "Promise.in took long enough";
}
