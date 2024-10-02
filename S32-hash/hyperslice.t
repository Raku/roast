use v6.e.PREVIEW;
use Test;

plan 10;

my %hash := {
    A => {
        B => 1,
        C => 2,
        D => {
            E => 3,
            F => 4,
        },
        G => 5,
        H => 6,
    },
    J => 7,
    K => 8,
};

{ # 1
    my $seen;
    for %hash{**}:kv -> $k, $v { $seen += $v }
    is $seen, sum(1..8), 'all leafs visited in {**}:kv';
}

{ # 2
    is %hash{**}:k.sort.join, 'BCEFGHJK', 'all leaf keys visited in {**}:k';
}

{ # 3
    my $seen;
    for %hash{**}:v -> $v { $seen += $v }
    is $seen, sum(1..8), 'all leafs visited in {**}:v';
}

{ # 4,5
    my $seen-E;
    my $seen-D;
    for %hash{**}:tree -> $k, $v { 
        $seen-D++ if $k eq 'D' && $v<F> == 4;
        $seen-E++ if $k eq 'E';
    }
    is $seen-E, 1, 'seen deep leaf in {**}:tree';
    is $seen-D, 1, 'seen subtree in {**}:tree';
}
{ # 6, 7
    my $seen-E;
    my $seen-K;
    for %hash{**}:deepk -> @k { 
        $seen-E++ if @k ~~ <A D E>;
        $seen-K++ if @k ~~ <K>;
    }
    is $seen-E, 1, 'seen deep key in {**}:deepk';
    is $seen-K, 1, 'seen shallow key in {**}:deepk';
}
{ # 8, 9
    my $seen-J;
    my $seen-E;
    for %hash{**}:deepkv -> @deepkey, $value {
        $seen-J++ if @deepkey ~~ <J> && $value == 7;
        $seen-E++ if @deepkey ~~ <A D E> && $value == 3;
    }
    is $seen-J, 1, 'seen leaf in {**}:deepkv';
    is $seen-E, 1, 'seen deep leaf in {**}:deepkv';
}
{ # 10 requires 6.e
    my $seen-roundtrips;
    for %hash{**}:deepkv -> $deepkey, $value {
        $seen-roundtrips++ if $value == %hash{||$deepkey};
    }
    is $seen-roundtrips, 8, 'roundtrips with {**}:deepkv and {||@keys}'
}
# vim: expandtab shiftwidth=4
