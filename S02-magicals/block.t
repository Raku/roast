use v6;

use Test;

=begin description

This tests the &?BLOCK magical from Synoposis 6

L<S06/The C<&?BLOCK> object>

=end description

plan 1;

# L<S02/Names/Which block am I in?>
# L<S06/The C<&?BLOCK> object/tail-recursion on an anonymous block:>
my $anonfactorial = -> Int $n { $n < 2 ?? 1 !! $n * &?BLOCK($n-1) };

my $result = $anonfactorial(3);
is($result, 6, 'the $?BLOCK magical worked');
