use RT83354_A;

class RT83354_B {
    has $.b;

    multi sub infix:<+>(RT83354_B $x, RT83354_B $y) is export {
        RT83354_B.new(:b($x.b + $y.b));
    }
}
