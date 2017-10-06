use v6;
use Test;
plan 11;

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

{ # coverage; 2016-10-11
    constant $map = Map.new: (:42a, :72b, "42" => "foo");

    cmp-ok $map.Map, '===', $map, 'Map.Map returns self';
    is-deeply Map.Hash,     Hash, 'Map:U.Hash gives Hash type object';
    is-deeply Map.new.Hash, Hash.new, '.Hash on empty Map gives empty Hash';
    is-deeply $map.Hash,    %(:42a, :72b, "42" => "foo"),
        'Map:D.Hash gives right hash';

    is-deeply $map.Int, 3, 'Map.Int gives number of pairs';
    is-deeply $map{42e0}, 'foo', 'Map{} with non-Str key gives right results';

    is-deeply $map.clone, $map, 'Map.clone is identity';
}

subtest 'Map.gist shows only first 100 els' => {
    plan 4;
    sub make-gist ($map, $extras = []) {
        'Map.new((' ~ (
            |Map.new(|$map).sort.head(100).map(*.gist), |$extras
        ).join(', ') ~ '))'
    }

    is-deeply Map.new($_).gist, make-gist($_), '100 els'
        with (1..200).list;
    is-deeply Map.new($_).gist, make-gist($_, '...'), '101 els'
        with (1..202).list;
    is-deeply Map.new($_).gist, make-gist($_, '...'), '102 els'
        with (1..204).list;
    is-deeply Map.new($_).gist, make-gist($_, '...'), '1000 els'
        with (1..2000).list;
}

# vim: ft=perl6
