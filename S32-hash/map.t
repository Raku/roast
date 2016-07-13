use v6;
use Test;
plan 2;

{
    my %hash = :foo, :42bar;
    is-deeply %hash.Map, Map.new( (:foo, :42bar) ),
        '.Map on defined Hash produces correct Map';
    is-deeply Hash.Map, Map, '.Map on undefined Hash produces Map type object';
}

# vim: ft=perl6
