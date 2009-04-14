use v6;
use Test;
plan 3;

# L<S06/Unpacking array parameters>

sub foo($x, [$y, *@z]) {
    return "$x|$y|" ~ @z.join(';');
}

my @a = 2, 3, 4, 5;
is foo(1, @a), '2|3|4;5',  'array unpacking';

sub bar([$x, $y, $z]) {
    return [*] $x, $y, $z;
}

ok bar(@a[0..2]) == 24, 'fixed length array unpacking';
dies_ok { bar [1,2] }, 'fixed length array unpacking with wrong length';

# vim: ft=perl6
