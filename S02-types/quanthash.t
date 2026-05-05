use Test;


my constant @immutables = Set,     Bag,     Mix;
my constant   @mutables = SetHash, BagHash, MixHash;
my constant      @types = |@immutables, |@mutables;

plan 10 * @types + 8 * @immutables + 15 * @mutables;

# Check basic parameterization functionality
for @types -> \T {

    my $type := T;
    is-deeply $type.new( qw/a b c/ ).keys.sort.List, qw/a b c/,
      "un-parameterized $type.^name()";
    ok $type.keyof =:= Mu, 'does .keyof return the correct type';
    
    # Only accept strings
    $type := T.^parameterize(Str);
    is-deeply $type.new( qw/a b c/ ).keys.sort.List, qw/a b c/,
      'can we parameterize for strings?';
    ok $type.keyof =:= Str, 'does .keyof return the correct type';

    # Only accept anything that can be coerced to an Int
    $type := T.^parameterize(Int());
    is-deeply $type.new(qw/1 2 4/).keys.sort.List, (1,2,4),
      'can we parameterize with a coercive type for integers?';
    ok $type.keyof =:= Int(), 'does .keyof return the correct type';
    throws-like { $type.new( <a b c> ) }, X::Str::Numeric,
      'do wrong values make initialization croak';

    # Only accept anything that can be coerced to a Date
    $type := T.^parameterize(Date());
    is-deeply $type.new('2026-05-05').keys.head, '2026-05-05'.Date,
      'can we parameterize with a coercive type for dates?';
    ok $type.keyof =:= Date(), 'does .keyof return the correct type';
    throws-like { $type.new( <a b c> ) }, X::Temporal::InvalidFormat,
      'do wrong values make initialization croak';
}

for @immutables -> \T {

    # Only accept strings
    my $type := T.^parameterize(Str);
    isa-ok (my %qh := $type.new), $type;
    throws-like { %qh{"a"} = 1 }, X::Assignment::RO,
      "can not assign to $type.^name()";
    nok %qh{"a"}, 'did not find a value at "a"';

    # Only accept anything that can be coerced to an Int
    $type := T.^parameterize(Int());
    isa-ok (%qh := $type.new), $type;
    throws-like { %qh{42} = 1 }, X::Assignment::RO,
      "cannot assign Int to $type.^name()";

    is-deeply %qh.elems, 0, 'where there no keys added';

    throws-like { %qh{"a"} }, X::Str::Numeric,
      'do bad keys make access croak';
    throws-like { %qh{"a"} = 1 }, X::Assignment::RO,
      'do bad keys make assignment croak';
}

for @mutables -> \T {

    # Only accept strings
    my $type := T.^parameterize(Str);
    isa-ok (my %qh := $type.new), $type;
    lives-ok { %qh{"a"} = 1 }, "can assign to mutable $type.^name()";
    ok %qh{"a"}, 'found a value at "a"';
    nok %qh{"b"}, 'did not find a value at "b"';

    # Only accept anything that can be coerced to an Int
    $type := T.^parameterize(Int());
    isa-ok (%qh := $type.new), $type;
    lives-ok { %qh{42} = 1 }, "can assign Int to mutable $type.^name()";
    ok %qh{42}, 'found a value at "a" using Int';
    ok %qh{"42"}, 'found a value at "a" using Str';
    lives-ok { %qh{"666"} = 1 }, "can assign Str to mutable $type.^name()";
    ok %qh{"666"}, 'found a value at "666"';
    ok %qh{666}, 'found a value at 666';

    is-deeply %qh.keys.sort.List, (42,666), 'did we get integer keys';
    %qh.values.map({ $_ = 0 });
    is-deeply %qh.elems, 0, 'did all keys get removed';

    throws-like { %qh{"a"} }, X::Str::Numeric,
      'do bad keys make access croak';
    throws-like { %qh{"a"} = 1 }, X::Str::Numeric,
      'do bad keys make assignment croak';
}

# vim: expandtab shiftwidth=4
