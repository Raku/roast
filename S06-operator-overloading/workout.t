use v6;

use Test;

plan 84;

=begin pod

Testing operator overloading subroutines

=end pod

class Vector {
    has @.coords;
    multi method new (*@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method new (@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method abs() is export { sqrt([+](self.coords »*« self.coords)); }
    multi method Num() { die "Can't get Num from Vector"; }
}

# operators prefixed by T used the Texas version of their internal operators

multi sub infix:<+>(Vector $a, Vector $b) { Vector.new($a.coords »+« $b.coords); }
multi sub infix:<T+>(Vector $a, Vector $b) { Vector.new($a.coords >>+<< $b.coords); }
multi sub infix:<->(Vector $a, Vector $b) { Vector.new($a.coords »-« $b.coords); }
multi sub infix:<T->(Vector $a, Vector $b) { Vector.new($a.coords >>-<< $b.coords); }
multi sub prefix:<->(Vector $a) { Vector.new(0 «-« $a.coords); }
multi sub prefix:<T->(Vector $a) { Vector.new(0 <<-<< $a.coords); }
multi sub infix:<*>(Vector $a, $b) { Vector.new($a.coords »*» $b); }
multi sub infix:<T*>(Vector $a, $b) { Vector.new($a.coords >>*>> $b); }
multi sub infix:<*>($a, Vector $b) { Vector.new($a «*« $b.coords); }
multi sub infix:<T*>($a, Vector $b) { Vector.new($a <<*<< $b.coords); }
multi sub infix:</>(Vector $a, $b) { Vector.new($a.coords »/» $b); }
multi sub infix:<T/>(Vector $a, $b) { Vector.new($a.coords >>/>> $b); }
multi sub infix:<**>(Vector $a, $b) { Vector.new($a.coords »**» $b); }
multi sub infix:<T**>(Vector $a, $b) { Vector.new($a.coords >>**>> $b); }
multi sub infix:<⋅>(Vector $a, Vector $b) { [+]($a.coords »*« $b.coords); }
multi sub infix:<dot>(Vector $a, Vector $b) { [+]($a.coords >>*<< $b.coords); }

### note the is_approx from Test.pm doesn't lift infix:<-> and abs,
# so we can't expect it work with class Vector. Thus we re-make one that does
# the custom ops

sub ia($got, $expected, $descr =  "$got is approximately $expected") {
    my $tol = $expected.abs < 1e-6 ?? 1e-5 !! $expected.abs * 1e-6;
    my $test = ($got - $expected).abs <= $tol;
    ok(?$test, $descr);
    unless $test {
        diag("got:      $got");
        diag("expected: $expected");
    }
    ?$test;
}

# a few Vector sanity tests, verifying we can use is_approx for Vectors
# Note that this assumes that is_approx (1) lifts its operators (See S04)
# and (2) uses the method form of abs(), or lifts abs() too.
# Needs more discussion and spec coverage.
{
    isa_ok(Vector.new(1, 2, 3), Vector, "Vector.new produces a Vector object");
    my @a1 = (3, -3/2, 5.4);
    isa_ok(Vector.new(@a1), Vector, "Vector.new produces a Vector object");
    dies_ok({ Vector.new(1, 2, 3, 4) }, "Vector.new requires 3 parameters");
    my @a2 = (-3/2, 5.4);
    dies_ok({ Vector.new(@a2) }, "Vector.new requires an array with 3 members");

    my Vector $v1 = Vector.new(@a1);
    is($v1.coords[0], @a1[0], 'Constructor correctly assigns @coords[0]');
    is($v1.coords[1], @a1[1], 'Constructor correctly assigns @coords[1]');
    is($v1.coords[2], @a1[2], 'Constructor correctly assigns @coords[2]');
    my Vector $v2 = Vector.new(0.1, 1/5, 0.3);
    my Vector $v3 = $v1 - $v2;
    is($v3.coords[0], $v1.coords[0] - $v2.coords[0], 'Subtraction correct for @coords[0]');
    is($v3.coords[1], $v1.coords[1] - $v2.coords[1], 'Subtraction correct for @coords[1]');
    is($v3.coords[2], $v1.coords[2] - $v2.coords[2], 'Subtraction correct for @coords[2]');
    ok($v1.abs > 5, "$v1.abs is of appropriate size");
    ia($v1.abs, sqrt([+] (@a1 <<*>> @a1)), "v1.abs returns correct value");

    ia($v1, $v1, "v1 is approximately equal to itself");
    ia(Vector.new(0, 1, 0), Vector.new(0, .99999999, 0), "Different but very close Vectors");
    ok((Vector.new(1, 0, 0) - Vector.new(0, 1, 0)).abs > 1e-5,
       "Vectors of same size but different direction are not approximately equal");
}

my Vector $v1 = Vector.new(-1/2, 2, 34);
my Vector $v2 = Vector.new(1.0, 1/5, 0.3);

# basic operations
ia($v1 + $v2, Vector.new(0.5, 2.2, 34.3), "Addition correct");
ia(-$v1, Vector.new(1/2, -2, -34), "Negation correct");
ia((3/2) * $v1, Vector.new(-3/4, 3, 17*3), "Scalar multiply correct");
ia($v1 * (3/2), Vector.new(-3/4, 3, 17*3), "Scalar multiply correct");
ia($v1 / (2/3), Vector.new(-3/4, 3, 17*3), "Scalar division correct");
ia($v1 ** 2, Vector.new(1/4, 4, 34*34), "Scalar power correct");
ia($v1 ⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "⋅ product correct");

# Texas versions of basic operations
ia($v1 T+ $v2, $v1 + $v2, "T Addition correct");
ia($v1 T- $v2, $v1 - $v2, "T Subtraction correct");
ia(T-$v1, Vector.new(1/2, -2, -34), "T Negation correct");
ia((3/2) T* $v1, Vector.new(-3/4, 3, 17*3), "T Scalar multiply correct");
ia($v1 T* (3/2), Vector.new(-3/4, 3, 17*3), "T Scalar multiply correct");
ia($v1 T/ (2/3), Vector.new(-3/4, 3, 17*3), "T Scalar division correct");
ia($v1 T** 2, Vector.new(1/4, 4, 34*34), "T Scalar power correct");
ia($v1 dot $v2, -1/2 + 2/5 + 34 * 0.3, "dot product correct");

# equals versions
{
    my $v = $v1;
    $v += $v2;
    ia($v, $v1 + $v2, "+= works");
}

{
    my $v = $v1;
    $v -= $v2;
    ia($v, $v1 - $v2, "-= works");
}

{
    my $v = 3/2;
    $v *= $v1;
    ia($v, (3/2) * $v1, "*= works starting with scalar");
}

{
    my $v = $v1;
    $v /= (2/3);
    ia($v, (3/2) * $v1, "/= works");
}

{
    my $v = $v1;
    $v **= 3;
    ia($v, $v1 ** 3, "**= works");
}

{
    my $v = $v1;
    $v ⋅= $v2;
    ia($v, $v1 ⋅ $v2, "⋅= works");
}

{
    my $v = $v1;
    $v T+= $v2;
    ia($v, $v1 T+ $v2, "T+= works");
}

{
    my $v = $v1;
    $v T-= $v2;
    ia($v, $v1 - $v2, "T-= works");
}

{
    my $v = 3/2;
    $v T*= $v1;
    ia($v, (3/2) T* $v1, "T*= works starting with scalar");
}

{
    my $v = $v1;
    $v T/= (2/3);
    ia($v, (3/2) T* $v1, "T/= works");
}

{
    my $v = $v1;
    $v T**= 3;
    ia($v, $v1 T** 3, "T**= works");
}

{
    my $v = $v1;
    $v dot= $v2;
    ia($v, $v1 dot $v2, "dot= works");
}


# reversed versions
ia($v1 R+ $v2, Vector.new(0.5, 2.2, 34.3), "R Addition correct");
ia($v2 R- $v1, $v1 - $v2, "R Subtraction correct");
ia((3/2) R* $v1, Vector.new(-3/4, 3, 17*3), "R Scalar multiply correct");
ia($v1 R* (3/2), Vector.new(-3/4, 3, 17*3), "R Scalar multiply correct");
ia((2/3) R/ $v1, Vector.new(-3/4, 3, 17*3), "R Scalar division correct");
ia(2 R** $v1, Vector.new(1/4, 4, 34*34), "R Scalar power correct");
ia($v1 R⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "R Dot product correct");

ia($v1 RT+ $v2, $v1 + $v2, "R T Addition correct");
ia($v2 RT- $v1, $v1 - $v2, "R T Subtraction correct");
ia((3/2) RT* $v1, Vector.new(-3/4, 3, 17*3), "R T Scalar multiply correct");
ia($v1 RT* (3/2), Vector.new(-3/4, 3, 17*3), "R T Scalar multiply correct");
ia((2/3) RT/ $v1, Vector.new(-3/4, 3, 17*3), "R T Scalar division correct");
ia(2 RT** $v1, Vector.new(1/4, 4, 34*34), "R T Scalar power correct");
ia($v1 Rdot $v2, -1/2 + 2/5 + 34 * 0.3, "R Dot product correct");

#?DOES 1
multi sub is_approx_array(@got, @expected, $desc) {
    my $test = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(?$test, $desc);
}

#?DOES 1
multi sub isnt_approx_array(@got, @expected, $desc) {
    my $test = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(!$test, $desc);
}

my @vectors = ($v1, $v2, $v1 + $v2, $v1 - $v2, $v2 - $v1);

# Bad news error: the next four tests can all be made to work, just not at the same time.
# If you delete the skip line, the [T+] test works but the [-] test returns the "Can't get 
# Num from Vector" error.  If you include skip line, the [-] test works.  Help?

ia(([+] @vectors), (2 T* $v1) + (2 T* $v2), "[+] of vectors == 2 * (v1 + v2)");
ia(([T+] @vectors), (2 T* $v1) + (2 T* $v2), "[T+] of vectors == 2 * (v1 + v2)");
ia(([-] @vectors), -2 T* $v2, "[-] of vectors == -2 * v2");
ia(([T-] @vectors), -2 T* $v2, "[T-] of vectors == -2 * v2");

is_approx_array(@vectors >>*>> 2, @vectors >>+<< @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(@vectors >>*>> 2, @vectors, "Hyper: doubling does not equal self");
is_approx_array((@vectors >>*>> 2) >>*>> 2, (@vectors >>+<< @vectors) >>+<< (@vectors >>+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< @vectors, @vectors >>+<< @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(2 <<*<< @vectors, @vectors, "Hyper: doubling does not equal self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), @vectors >>+<< @vectors >>+<< @vectors >>+<< @vectors,
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>+<< @vectors) >>T+<< (@vectors >>+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>T+<< @vectors) >>T+<< (@vectors >>T+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>T+<< @vectors) >>+<< (@vectors >>T+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array(@vectors »*» 2, @vectors »+« @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(@vectors »*» 2, @vectors, "Hyper: doubling does not equal self");
is_approx_array((@vectors »*» 2) »*» 2, (@vectors »+« @vectors) »+« (@vectors »+« @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 «*« @vectors, @vectors »+« @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(2 «*« @vectors, @vectors, "Hyper: doubling does not equal self");
is_approx_array(2 «*« (2 «*« @vectors), @vectors »+« @vectors »+« @vectors »+« @vectors,
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array((@vectors »⋅« @vectors)».sqrt, @vectors».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@vectors >>⋅<< @vectors)».sqrt, @vectors».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@vectors >>⋅<< @vectors)>>.sqrt, @vectors>>.abs, "Hyper sqrt of hyper dot equals hyper length");

is_approx_array((@vectors »dot« @vectors)».sqrt, @vectors».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@vectors >>dot<< @vectors)>>.sqrt, @vectors>>.abs, "Hyper sqrt of hyper dot equals hyper length");

is_approx_array(((3/2) <<*<< @vectors) >>-<< @vectors , @vectors >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
is_approx_array(((3/2) <<*<< @vectors) »-« @vectors , @vectors >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
is_approx_array(((3/2) <<*<< @vectors) >>T-<< @vectors , @vectors >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
is_approx_array(((3/2) <<*<< @vectors) »T-« @vectors , @vectors >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");

# vim: ft=perl6
