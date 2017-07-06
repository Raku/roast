use v6;
use Test;

plan 8;

# Tests of the Baggy role

{ # coverage; 2016-09-23
    my class Foo does Baggy {}
    my $b = Foo.new: <a a b>;
    ok $b.WHICH.Str.starts-with("Foo|"), '.WHICH';
    is-deeply $b.invert.sort(*.key).list, (1 => "b", 2 => "a"), '.invert';
    is-deeply $b.SetHash, SetHash.new(<a b>),   '.SetHash';
}

{ # RT#127863
    subtest 'cloned BagHash gets its own elements storage' => {
        plan 2;
        my $a = BagHash.new: <a b c>;
        my $b = $a.clone;
        $a<a>--; $a<b>++; $a<z> = 42;
        is-deeply $a, BagHash.new-from-pairs("b" => 2, "c" => 1, "z" => 42),
            'modifying first bag works, even after we created its clone';
        is-deeply $b, BagHash.new(<a b c>),
            'modifying first bag does not affect cloned bag';
    }

    subtest 'cloned MixHash gets its own elements storage' => {
        plan 2;
        my $a = MixHash.new: <a b c>;
        my $b = $a.clone;
        $a<a>--; $a<b>++; $a<z> = 42;
        is-deeply $a, MixHash.new-from-pairs("b" => 2, "c" => 1, "z" => 42),
            'modifying first mix works, even after we created its clone';
        is-deeply $b, MixHash.new(<a b c>),
            'modifying first mix does not affect cloned mix';
    }
}

subtest 'Baggy:U forwards methods to Mu where appropriate' => {
    plan 5;
    given Mix {
        is-deeply .Bool,  False, '.Bool';
        is-deeply .so,    False, '.so';
        is-deeply .not,   True,  '.not';
        is-deeply .hash,  {},    '.hash';
        is-deeply .elems, 1,     '.elems';
    }
}

# https://rt.perl.org/Ticket/Display.html?id=131270
subtest '.pick/.roll/.grab reject NaN count' => {
    plan 3;
    throws-like { ^5 .BagHash.pick: NaN }, Exception, '.pick';
    throws-like { ^5 .BagHash.roll: NaN }, Exception, '.roll';
    throws-like { ^5 .BagHash.grab: NaN }, Exception, '.grab';
}

# RT 131386
subtest 'can access key of empty list coerced to type' => {
    my @tests = <Set SetHash  Bag BagHash  Mix MixHash  Map Hash>;
    plan +@tests;
    for @tests {
        lives-ok { my %x := ()."$_"(); %x<a> }, $_
    }
}

# vim: ft=perl6
