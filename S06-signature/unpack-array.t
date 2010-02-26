use v6;
use Test;
plan 11;

# L<S06/Unpacking array parameters>

sub foo($x, [$y, *@z]) {
    return "$x|$y|" ~ @z.join(';');
}

my @a = 2, 3, 4, 5;
is foo(1, @a), '1|2|3;4;5',  'array unpacking';

sub bar([$x, $y, $z]) {
    return $x * $y * $z;
}

ok bar(@a[0..2]) == 24, 'fixed length array unpacking';
dies_ok { bar [1,2] }, 'fixed length array unpacking too short';
dies_ok { bar [1,2,3,4] }, 'fixed length array unpacking too long';

sub baz([$x, $y?, $z?]) {
    return "$x|$y|$z";
}

dies_ok { baz( [] ) } , 'unpack optional scalars; required scalar missing';
is baz( [2] ), "2|Any()|Any()", 'unpack optional scalars; one required';
is baz( [2,3] ), "2|3|Any()", 'unpack optional scalars; one required + one optional';
is baz( [2,3,4] ), "2|3|4", 'unpack optional scalars; one required + two optional';
dies_ok { baz( [2,3,4,5] ) }, 'unpack optional scalars; one required + too many optional';

sub blat ($x, @a [$a, *@b]) {
    return $x == 1 ?? @a.join("|") !! "$a-" ~ @b.join('-');
}

is blat( 1, [2,3,4] ), "2|3|4", 'unpack named array';
is blat( 2, [2,3,4] ), "2-3-4", 'unpack named array with named pieces';

# vim: ft=perl6
