use v6;
use Test;
plan 3;

# L<S06/Unpacking array parameters>

sub foo($x, [$y, *@z] --> Num) {
    return [+] $x, $y, @z;
}

my @a = 2, 3, 4;
ok foo(1, @a) == 10, 'array unpacking';

sub bar([$x, $y, $z], :$a --> Num) {
    return [*] $x, $y, $z;
}

ok bar(@a) == 24, 'fixed length array unpacking';
dies_ok { bar [1,2] }, 'fixed length array unpacking with wrong length';
