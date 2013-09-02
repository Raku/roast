use v6;
use Test;

plan 20;

# L<S06/Unpacking tree node parameters>

# hash left/right
{
    #?DOES 2
    my sub traverse_hash (%top (:$left, :$right, *%), $desc?) {
        is($left,  %top<left>,  "left value is correct: $desc");
        is($right, %top<right>, "right value is correct: $desc");
    }

    my %hash = {left => 'abc', right => 'def'};
    traverse_hash(%hash, 'basic hash');
    traverse_hash({%hash, a => 0, b => 1, c => 2}, 'hash with extra values');

    %hash<left>  = {left => 'foo', right => 'bar'};
    %hash<right> = {left => 'baz', right => 'qux'};
    traverse_hash(%hash, 'hash with values that are hashes');
}

{
    #?DOES 2
    my sub traverse_hash (%top (:$east, :$west, *%), $desc?) {
        is($east, %top<east>, "east value is correct: $desc");
        is($west, %top<west>, "west value is correct: $desc");
    }

    my %hash = {east => 'abc', west => 'def'};
    traverse_hash(%hash, 'custom hash values work');
    traverse_hash({%hash, a => 0, b => 1}, 'custom hash, extra values');

    %hash<east> = {east => 'foo', west => 'bar'};
    %hash<west> = {east => 'baz', west => 'qux'};
    traverse_hash(%hash, 'custom hash with values that are hashes');
}

# object left/right
{
    class BinTree {
        has $.left is rw;
        has $.right is rw;
        method Str() { $.left.WHICH ~ ',' ~ $.right.WHICH }
    }

    #?DOES 2
    my sub traverse_obj (BinTree $top (:$left, :$right), $desc?) {
        is($left,  $top.left,  "left object value is correct: $desc");
        is($right, $top.right, "right object value is correct: $desc");
    }

    my $tree = BinTree.new(left => 'abc', right => 'def');
    traverse_obj($tree, 'simple object');

    $tree.left = $tree;
    $tree.right = $tree;
    traverse_obj($tree, 'nested object tree');
}

# L<S06/Unpacking tree node parameters/You may omit the top variable if you prefix the parentheses>
#?DOES 4
#?rakudo skip 'signature binding of return values NYI'
{
    class Point {has $.x is rw; has $.y is rw}
    class TwoPoints {has Point $.a is rw; has Point $.b is rw}

    my $point_a = Point.new(x => 0, y => 1);
    my $point_b = Point.new(x => 4, y => 2);
    sub getpoints {
        my $points = TwoPoints.new;
        $points.a = $point_a;
        $points.b = $point_b;
        return $points;
    }

   my (Point $ ($a, $b)) := getpoints();
   is($a, $point_a, 'unpacked TwoPoint object (1)');
   is($b, $point_b, 'unpacked TwoPoint object (2)');

   my (Point $ ($c, $d)) := getpoints();
   is($c, $point_a, 'unpacked TwoPoint object (3)');
   is($d, $point_a, 'unpacked TwoPoint object (4)');
}

# vim: ft=perl6
