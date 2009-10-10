use v6;

use Test;

plan *;

=begin pod

Testing operator overloading subroutines

=end pod

class Vector {
    has @.coords;
    multi method new (*@x where { @x.elems == 3 }) { self.bless(*, coords => @x); }
    multi method new (@x where { @x.elems == 3 }) { self.bless(*, coords => @x); }
    multi method abs() { sqrt([+](self.coords »*« self.coords)); }
}

multi sub infix:<⋅>(Vector $a, Vector $b) { [+]($a.coords »*« $b.coords); }
multi sub infix:<dot>(Vector $a, Vector $b) { $a ⋅ $b; }
multi sub infix:<+>(Vector $a, Vector $b) { Vector.new($a.coords »+« $b.coords); }
multi sub infix:<->(Vector $a, Vector $b) { Vector.new($a.coords »-« $b.coords); }
multi sub prefix:<->(Vector $a) { Vector.new(0 <<-<< $a.coords); }
multi sub infix:<*>(Vector $a, $b) { Vector.new($a.coords >>*>> $b); }
multi sub infix:<*>($a, Vector $b) { Vector.new($a <<*<< $b.coords); }
multi sub infix:</>(Vector $a, $b) { Vector.new($a.coords >>/>> $b); }

# a few Vector sanity tests, verifying we can use is_approx for Vectors
{
    isa_ok(Vector.new(1, 2, 3), Vector, "Vector.new produces a Vector object");
    my @a1 = (3, -3/2, 5.4);
    isa_ok(Vector.new(@a1), Vector, "Vector.new produces a Vector object");
    dies_ok({ Vector.new(1, 2, 3, 4) }, "Vector.new requires 3 parameters");
    my @a2 = (-3/2, 5.4);
    dies_ok({ Vector.new(@a2) }, "Vector.new requires an array with 3 members");
    
    my Vector $v1 = Vector.new(@a1);
    is($v1.coords[0], @a1[0], "Constructor correctly assigns @coords[0]");
    is($v1.coords[1], @a1[1], "Constructor correctly assigns @coords[1]");
    is($v1.coords[2], @a1[2], "Constructor correctly assigns @coords[2]");
    my Vector $v2 = Vector.new(0.1, 1/5, 0.3);
    my Vector $v3 = $v1 - $v2;
    is($v3.coords[0], $v1.coords[0] - $v2.coords[0], "Subtraction correct for @coords[0]");
    is($v3.coords[1], $v1.coords[1] - $v2.coords[1], "Subtraction correct for @coords[1]");
    is($v3.coords[2], $v1.coords[2] - $v2.coords[2], "Subtraction correct for @coords[2]");
    ok($v1.abs > 5, "$v1.abs is of appropriate size");
    is_approx($v1.abs, sqrt([+] (@a1 <<*>> @a1)), "v1.abs returns correct value");
    
    is_approx($v1, $v1, "v1 is approximately equal to itself");
    is_approx(Vector.new(0, 1, 0), Vector.new(0, .99999999, 0), "Different but very close Vectors");
    ok((Vector.new(1, 0, 0) - Vector.new(0, 1, 0)).abs > 1e-5, 
       "Vectors of same size but different direction are not approximately equal");
}





done_testing;

# vim: ft=perl6
