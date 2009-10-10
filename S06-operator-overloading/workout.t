use v6;

use Test;

plan *;

=begin pod

Testing operator overloading subroutines

=end pod

class Vector {
    has @.coordinates;
    multi method new (*@x where { @x.elems == 3 }) { self.bless(*, coordinates => @x); }
    multi method new (@x where { @x.elems == 3 }) { self.bless(*, coordinates => @x); }
    multi method abs() { sqrt([+](self.coordinates »*« self.coordinates)); }
}

multi sub infix:<⋅>(Vector $a, Vector $b) { [+]($a.coordinates »*« $b.coordinates); }
multi sub infix:<dot>(Vector $a, Vector $b) { $a ⋅ $b; }
multi sub infix:<+>(Vector $a, Vector $b) { Vector.new($a.coordinates »+« $b.coordinates); }
multi sub infix:<->(Vector $a, Vector $b) { Vector.new($a.coordinates »-« $b.coordinates); }
multi sub prefix:<->(Vector $a) { Vector.new(0 <<-<< $a.coordinates); }
multi sub infix:<*>(Vector $a, $b) { Vector.new($a.coordinates >>*>> $b); }
multi sub infix:<*>($a, Vector $b) { Vector.new($a <<*<< $b.coordinates); }
multi sub infix:</>(Vector $a, $b) { Vector.new($a.coordinates >>/>> $b); }

# a few Vector sanity tests
{
    isa_ok(Vector.new(1, 2, 3), Vector, "Vector.new produces a Vector object");
    my @a1 = (3, -3/2, 5.4);
    isa_ok(Vector.new(@a1), Vector, "Vector.new produces a Vector object");
    dies_ok({ Vector.new(1, 2, 3, 4) }, "Vector.new requires 3 parameters");
    my @a2 = (-3/2, 5.4);
    dies_ok({ Vector.new(@a2) }, "Vector.new requires an array with 3 members");
}





done_testing;

# vim: ft=perl6
