use v6;
use Test;

plan 36;

my sub vtest($cmp, *@v) {
    my $x = shift @v;
    while (@v) {
        my $y = shift @v;
        is Version.new($x) cmp Version.new($y), $cmp, "$x cmp $y is $cmp";
        $x = $y;
    }
}

# From S03
vtest Order::Same, 
    < 1.2.1alpha1.0
      1.2.1alpha1
      1.2.1.alpha1
      1.2.1alpha.1
      1.2.1.alpha.1
      1.2-1+alpha/1 >;

# More from S03
vtest Order::Same,
    < 1.2.1_01
      1.2.1_1
      1.2.1._1
      1.2.1_1
      1.2.1._.1
      001.0002.0000000001._.00000000001
      1.2.1._.1.0.0.0.0.0 >;

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

vtest Order::Less, @sorted;
vtest Order::More, @sorted.reverse;

# RT #116016
is v12.3.4 cmp Version.new("12.3.4"), Order::Same, 'can parse literal versions where major version is more than one digit';

done;

