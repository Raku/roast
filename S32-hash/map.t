use v6;
use Test;
plan 23;

{
    my %hash = :foo, :42bar;
    is-deeply %hash.Map, Map.new( (:foo, :42bar) ),
        '.Map on defined Hash produces correct Map';
    is-deeply Hash.Map, Map, '.Map on undefined Hash produces Map type object';
    throws-like { %hash.map(Hash) }, Exception,
        '<object|type>.map(Hash) should die';
}

{ # coverage; 2016-10-11
    constant $map = Map.new: (:42a, :72b, "42" => "foo");

    cmp-ok $map.Map, '===', $map, 'Map.Map returns self';
    is-deeply Map.Hash,     Hash, 'Map:U.Hash gives Hash type object';
    is-deeply Map.new.Hash, Hash.new, '.Hash on empty Map gives empty Hash';
    is-deeply $map.Hash,    %(:42a, :72b, "42" => "foo"),
        'Map:D.Hash gives right hash';

    is-deeply $map.Int, 3, 'Map.Int gives number of pairs';
    is-deeply $map{42.0}, 'foo',
        'Map{} with non-Str value in lookup stringifies it';

    is-deeply $map.clone, $map, 'Map.clone is identity';
}

subtest 'Map.gist shows only the first sorted 100 els' => {
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

# [Github Issue 1261](https://github.com/rakudo/rakudo/issues/1261)
{
    my $s  = 21;
    my $m := Map.new: (foo => 42, bar => $s);

    throws-like { $m<foo> := 10 }, X::Bind, 'Cannot bind at key of immutable Map';
    throws-like { $m<bar> := 10 }, X::Bind, 'Cannot bind at key of immutable Map, Scalar value';
}

# R#2055
{
    my %h is Map = a => 42;
    dies-ok { %h = b => 666 }, 'cannot initialize a Map for the second time';
}

# R#2062
{
    my %h{Any} = ^6;
    my %m is Map = %h, a => 42;
    is-deeply
      ["0" => 1, "2" => 3, "4" => 5, "a" => 42],
      [%m.sort: *.key],
      'did we get the pairs handled ok'
    ;
}

{
    my class C {
        has Int @.a;
        has Int @.b;
    }
    lives-ok { C.new(|(a => (1, 2, 3), b => (4, 5, 6)).Map) },
        'Map does not introduce bogus Scalar containers';
}

# R#2447
{
    my %m is Map = a => { b => 42 };
    my $WHICH = %m.WHICH;
    %m<a><b> = 666;
    is %m<a><b>, 666, 'did we change the hash inside the map';
    is %m.WHICH, $WHICH, 'did the .WHICH stay unchanged';
}

# perl6/problem-solving#99
{
    my %h = :1a, :2b;
    isa-ok %h<a>.VAR, Scalar, "a hash value is containerized";
    my %m := %h.Map;
    isa-ok %m<a>.VAR, Int, "Map coercion deconts hash value";
}

# rakudo/rakudo#3168
{
    my class Foo {
        has @.a;
    }
    my %args = a => [1, 2, 3];
    my $foo = Foo.new(|%args.Map);
    is-deeply $foo.a, [1, 2, 3], "array attribute initializer from Hash coerced to Map";
}

# https://github.com/rakudo/rakudo/issues/3617
{
    my %m is Map = a => 42, b => 666;
    dies-ok { %m<a> = 666 }, 'cannot assign to existing key';
    dies-ok { %m<c> = 666 }, 'cannot assign to non-existing key';
}

# vim: expandtab shiftwidth=4
