use v6;
use Test;

plan 12;

# L<S32::Containers/Array/rotate>

{
    my @a = <a b c d e>;
    is ~@a.rotate, 'b c d e a', 'Array.rotate defaults to +1';
    is ~@a, 'a b c d e', 'original array unmodified';
    ok @a.rotate ~~ Positional, 'Array.rotate returns a Positional';

    is ~@a.rotate(2), 'c d e a b', '.rotate(2)';
    is ~@a, 'a b c d e', 'original array still unmodified';

    is @a.rotate(-2), 'd e a b c', '.rotate(-2)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';
}

{
    my @a = <a b c d e>;
    is ~rotate(@a), 'b c d e a', 'rotate() sub';
    is ~@a, 'a b c d e', 'original array unmodified (sub form)';

    is ~rotate(@a, 0), 'a b c d e', 'rotate(@a, 0)';
    is ~rotate(@a, 6), 'b c d e a', 'rotate(@a, 1+@a)';
}

# List.rotate should also work

{
    is ~<a b c d e>.rotate, 'b c d e a', 'List.rotate';
}

# vim: ft=perl6
