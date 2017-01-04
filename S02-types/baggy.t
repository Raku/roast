use v6;
use Test;

plan 5;

# Tests of the Baggy role

{ # coverage; 2016-09-23
    my class Foo does Baggy {}
    my $b = Foo.new: <a a b>;
    is $b.WHICH, "Foo|Str|a(2) Str|b(1)", '.WHICH';
    is-deeply $b.invert,  (2 => "a", 1 => "b"), '.invert';
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
