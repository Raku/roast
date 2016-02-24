use v6.c;

use Test;

=begin description

This tests the &?BLOCK magical from Synopsis 6

=end description

# L<S06/The C<&?BLOCK> object>

plan 3;

{
# L<S02/Names/Which block am I in?>
# L<S06/The C<&?BLOCK> object/tail-recursion on an anonymous block:>
my $anonfactorial = -> Int $n { $n < 2 ?? 1 !! $n * &?BLOCK($n-1) };

my $result = $anonfactorial(3);
is($result, 6, 'the &?BLOCK magical worked');
}

{
    my @collected;
    sub foo($a) {
        -> $n {
            @collected.push($a);
            $n == 1 ?? 1 !! $n * &?BLOCK($n - 1)
        }
    }
    my $b1 = foo('a');
    my $b2 = foo('b');
    is $b1(4), 24, 'Correct result from function generator returning function using &?BLOCK';
    is @collected.join(''), 'aaaa', 'Correct closure semantics with &?BLOCK';
}

# vim: ft=perl6
