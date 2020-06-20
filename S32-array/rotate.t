use v6.d;
use Test;

plan 29;

# L<S32::Containers/Array/rotate>

{
    my @a = <a b c d e>;
    is ~@a.rotate, 'b c d e a', 'Array.rotate defaults to +1';
    is ~@a, 'a b c d e', 'original array unmodified';

    is ~@a.rotate(2), 'c d e a b', '.rotate(2)';
    is ~@a, 'a b c d e', 'original array still unmodified';

    is ~@a.rotate(-2), 'd e a b c', '.rotate(-2)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';

    is ~@a.rotate(0), 'a b c d e', '.rotate(0)';
    is ~@a.rotate(5), 'a b c d e', '.rotate(5)';
    is ~@a.rotate(15), 'a b c d e', '.rotate(15)';

    is ~@a.rotate(7), 'c d e a b', '.rotate(7)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';

    is ~@a.rotate(-8), 'c d e a b', '.rotate(-8)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';
} #14

# all the same but rotate() sub
{
    my @a = <a b c d e>;
    is ~rotate(@a), 'b c d e a', 'rotate(@a)';
    is ~@a, 'a b c d e', 'original array unmodified';

    is ~rotate(@a, 2), 'c d e a b', 'rotate(@a, 2)';
    is ~@a, 'a b c d e', 'original array still unmodified';

    is ~rotate(@a, -2), 'd e a b c', 'rotate(@a, -2)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate(@a, 0), 'a b c d e', 'rotate(@a, 0)';
    is ~rotate(@a, 5), 'a b c d e', 'rotate(@a, 5)';
    is ~rotate(@a, 15), 'a b c d e', 'rotate(@a, 15)';

    is ~rotate(@a, 7), 'c d e a b', 'rotate(@a, 7)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate(@a, -8), 'c d e a b', 'rotate(@a, -8)';
    is ~@a, 'a b c d e', 'original still unmodified (negative)';
} #13

# RT125677 Make sure rotate is Cool with stuff
{
    my @a = <a b c d e>;
    is ~@a.rotate('2'), 'c d e a b', '.rotate("2")';
    is ~@a.rotate(2.5), 'c d e a b', '.rotate(2.5)';
}

# https://github.com/rakudo/rakudo/commit/f4cbdb64bc
subtest '.rotate can be used on empty List' => {
    plan 8;
    is-deeply ()          .rotate,     (),           'List (1)';
    is-deeply ()          .rotate(-1), (),           'List (-1)';
    is-deeply []          .rotate,     (),           'Array (1)';
    is-deeply []          .rotate(-1), (),           'Array (-1)';
    is-deeply ().Slip     .rotate,     (),           'Slip (1)';
    is-deeply ().Slip     .rotate(-1), (),           'Slip (-1)';
    is-deeply ().Seq.cache.rotate,     ().Seq.cache, ‘Seq's cache (1)’;
    is-deeply ().Seq.cache.rotate(-1), ().Seq.cache, ‘Seq's cache (-1)’;
}

# vim: ft=perl6
