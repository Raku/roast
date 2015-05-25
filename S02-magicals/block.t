use v6;

use Test;

=begin description

This tests the &?BLOCK magical from Synopsis 6

=end description

# L<S06/The C<&?BLOCK> object>

plan 1;

#?rakudo skip '&?BLOCK NYI RT #125131'
{
# L<S02/Names/Which block am I in?>
# L<S06/The C<&?BLOCK> object/tail-recursion on an anonymous block:>
my $anonfactorial = -> Int $n { $n < 2 ?? 1 !! $n * &?BLOCK($n-1) };

my $result = $anonfactorial(3);
is($result, 6, 'the &?BLOCK magical worked');
}
# vim: ft=perl6
