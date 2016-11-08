use v6;

use Test;

plan 5;

=begin description

This test tests C<duckmap>.

=end description

{
    my $list = (1, (2,3), "a");
    is-deeply duckmap(-> Int $x { $x ~~ Int ?? $x !! Any }, $list), (1, (2, 3), 'a'), "duckmap doesn't hang"; # RT #129321
    is-deeply duckmap(-> Int $x { $x ~~ Int ?? $x + 1 !! Any }, $list), (2, (3, 4), 'a'), "duckmap works";
    is-deeply $list.duckmap({$_ ~~ Str ?? $_ ~ "b" !! Any}), (Any, Any, "ab"), "duckmap leaves Any alone";

    my $roles = ((1 but role {method foo {"a"}}), 2, ((3 but role {method foo {"b"}})));
    is-deeply $roles.duckmap({.foo}), ("a", 2, ("b")), "duckmap works with roles";

    is-deeply my_duckmap({ .elems }, ["a", ["bb", "cc", "d"], []]), [1, 3, 0], "duckmap doesn't consume iterables for defined ops";

    #RT #129363 duckmap doesn't preserve structure types"
    is-deeply my_duckmap(-> Int $x { $x ~~ Int ?? $x !! Any }, [1, [2,3], 4]), [1, [2,3], 4], 'duckmap preserves structure types';
    is-deeply my_duckmap(-> Int $x { $x ~~ Int ?? $x + 1 !! Any }, [1, [2,3], 4]), [2, [3,4], 5], 'duckmap preserves structure types';
} #2

# vim: ft=perl6
