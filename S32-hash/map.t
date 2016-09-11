use v6;
use Test;
plan 3;

{
    my %hash = :foo, :42bar;
    is-deeply %hash.Map, Map.new( (:foo, :42bar) ),
        '.Map on defined Hash produces correct Map';
    is-deeply Hash.Map, Map, '.Map on undefined Hash produces Map type object';
    throws-like(
        { %hash.map(Hash) },
        Exception,
        message => /"Cannot map a {%hash.WHAT.perl} to a Hash."/,
        '<object|type>.map(Hash) should die'
    );
}

# vim: ft=perl6
