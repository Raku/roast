use v6;
use Test;

# From S03
my @same = (
    < 1.2.1alpha1.0
      1.2.1alpha1
      1.2.1.alpha1
      1.2.1alpha.1
      1.2.1.alpha.1
      1.2-1+alpha/1
    >,
    < 1.2.1_01
      1.2.1_1
      1.2.1._1
      1.2.1_1
      1.2.1._.1
      001.0002.0000000001._.00000000001
      1.2.1._.1.0.0.0.0.0
    >,
);

# Still more from S03
my @sorted = <
    1.2.0.999
    1.2.1_01
    1.2.1_2
    1.2.1_003
    1.2.1a1
    1.2.1.alpha1
    1.2.1b1
    1.2.1.beta1
    1.2.1.gamma
    1.2.1α1
    1.2.1β1
    1.2.1γ
    1.2.1 >;

my $shuffle = 3;

plan $shuffle                       # sorted shuffled lists
   + 8 * @same».elems»².sum         # self-equality for @same
   + 8 * @sorted                    # self-equality for @sorted
   + 8 * @sorted * ( @sorted - 1 ); # compare with all successors
;

my sub test_same(@versions) {
    for ( @versions X @versions ) -> @v {
        my $v1 = Version.new(@v[0]);
        my $v2 = Version.new(@v[1]);
        ok( not $v1 < $v2, "not $v1 < $v2" );
        ok( not $v1 > $v2, "not $v1 > $v2" );
        ok( $v1 <= $v2, "$v1 <= $v2" );
        ok( $v1 >= $v2, "$v1 >= $v2" );
        ok( $v1 == $v2, "$v1 == $v2" );
        ok( not $v1 != $v2, "not $v1 != $v2" );
        is( $v1 <=> $v2, Order::Same, "$v1 <=> $v2" );
        is( $v1 cmp $v2, Order::Same, "$v1 cmp $v2" );
    }
}

is-deeply(
    @sorted.map({Version.new($_)}).pick(*).sort,
    @sorted.map({Version.new($_)}),
    "sort() a list of Version"
) for ^$shuffle;

test_same($_) for @same;

while @sorted {
    my $v1 = Version.new( shift @sorted );
    test_same( [$v1] );

    for @sorted.map({Version.new($_)}) -> $v2 {

        ok( $v1 < $v2, "$v1 < $v2" );
        ok( not $v1 > $v2, "not $v1 > $v2" );
        ok( $v1 <= $v2, "$v1 <= $v2" );
        ok( not $v1 >= $v2, "not $v1 >= $v2" );
        ok( not $v1 == $v2, "not $v1 == $v2" );
        ok( $v1 != $v2, "$v1 != $v2" );
        is( $v1 <=> $v2, Order::Less, "$v1 <=> $v2" );
        is( $v1 cmp $v2, Order::Less, "$v1 cmp $v2" );

        # reverse
        ok( not $v2 < $v1, "not $v2 < $v1" );
        ok( $v2 > $v1, "$v2 > $v1" );
        ok( not $v2 <= $v1, "not $v2 <= $v1" );
        ok( $v2 >= $v1, "$v2 >= $v1" );
        ok( not $v2 == $v1, "not $v2 == $v1" );
        ok( $v2 != $v1, "$v2 != $v1" );
        is( $v2 <=> $v1, Order::More, "$v2 <=> $v1" );
        is( $v2 cmp $v1, Order::More, "$v2 cmp $v1" );
    }
}
