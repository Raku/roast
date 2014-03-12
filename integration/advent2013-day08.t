use v6;
use Test;
plan 11;

class Vector is Array {

    method new (*@values is copy, *%named) {
        @values[0] = %named<x> if %named<x> :exists;
        @values[1] = %named<y> if %named<y> :exists;
        @values[2] = %named<z> if %named<z> :exists;

        nextwith(|@values);
    }

    method x () is rw { self[0] }
    method y () is rw { self[1] }
    method z () is rw { self[2] }

    method magnitude () {
        sqrt [+] self »**» 2 
    }

    method subtract (@vec) {
        self.new( self »-« @vec )
    }
}

my @vec := Vector.new(1, 2, 3);
is @vec.WHAT.gist, '(Vector)';

my @vec-wrong = Vector.new(1, 2, 3);
is @vec-wrong.WHAT.gist, '(Array)';

my $vec := Vector.new(1, 2, 3);
is $vec.WHAT.gist, '(Vector)';

my @position := Vector.new(1, 2);
my @destination = 4, 6;
my $distance = @position.subtract(@destination).magnitude;
is $distance, 5;

{
    my $vec = Vector.new(0, 1);
    is $vec.magnitude, 1;
};

{
    my $vec = Vector.new(1, 2);
    $vec.z = 3;
    is $vec.WHAT.gist, '(Vector)';
    is $vec.gist, '1 2 3';
};

{
    my $vec = Vector.new(:x(1), :y(2));
    $vec.z = 3;
    is $vec.gist, '1 2 3';
}

{
    my $vec = Vector.new(:y(3), 0);
    $vec.x++;
    $vec[1]--;
    $vec.z = 3;

    my $n = 1;
    is($_, $n++)  for @$vec;
}
