use v6;

use Test;

plan 2;

=begin description

This test tests C<duckmap>.

=end description

{
    my $list = (1, (2,3), "a");
    is-deeply duckmap(-> Int $x { $x ~~ Int ?? $x !! Any }, $list), (1, (2, 3), 'a'), "duckmap doesn't hang"; # RT #129321
    #?rakudo todo "RT #129363 duckmap doesn't preserve structure types"
    is-deeply duckmap(-> Int $x { $x ~~ Int ?? $x !! Any }, [1, [2,3], 4]), [1, [2,3], 4]
} #2

# vim: ft=perl6
