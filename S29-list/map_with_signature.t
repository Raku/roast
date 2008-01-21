use v6-alpha;
use Test;
plan 4;

# L<S29/"List"/"=item map">

my @a=(1,4,2,5,3,6);
my @ret=map -> $a,$b {$a+$b}, @a;
# should be (5,7,9), rigt now it is (1,4,2,5,3,6): map doesn't look at the signature

is(@ret.elems,3,'map took 2 elements at a time');
is(@ret[0],5,'first element ok');
is(@ret[1],7,'second element ok');
is(@ret[2],9,'third element ok');

