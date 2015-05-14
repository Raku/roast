class RT83354_A {
    has $.a;

    multi sub infix:<+>(RT83354_A $x, RT83354_A $y) is export {
        RT83354_A.new(:a($x.a + $y.a));
    }
}
