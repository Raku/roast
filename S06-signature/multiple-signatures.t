use v6;
use Test;

# this tests signatures, so the file lives in S06-signature/, although
# the features are (mostly?) described in S13

plan 11;

# L<S13/Syntax/"Perl allows you to declare multiple signatures for a
# given body">

# normal subs
{
    multi sub si  (Str $s, Int $i)
                | (Int $i, Str $s) {
        die "dispatch went wrong" unless $s ~~ Str && $i ~~ Int;
        "s:$s i:$i";
    }
    is si("a", 3), "s:a i:3", 'sub with two sigs dispatches correctly (1)';
    is si(3, "b"), "s:b i:3", 'sub with two sigs dispatches correctly (2)';
}

# try it with three sigs as well, and mixed named/positionals
{
    multi sub three  (Str $s, Int $i, Num :$n)
                   | (Int $i, Str :$s, Num :$n)
                   | (Num :$s, Int :$i, Str :$n) {
        "$s $i $n";
    }
    is three('abc', 3, :n(2.3)), 'abc 3 2.3', 'multi dispatch on three() (1)';
    is three(4, :s<x>, :n(2.3)), 'x 4 2.3',   'multi dispatch on three() (2)';
    is three(:i(4), :s(0.2), :n('f')), '0.2 4 f', 'multi dispatch on three() (3)';
}

# L<S13/Syntax/"except that there really is only one body">

{
    multi sub count  (Str $s, Int $i)   #OK not used
                | (Int $i, Str $s) {   #OK not used
        state $x = 0;
        ++$x;
    }
    is count("a", 3), 1, 'initialization of state var in multi with two sigs';
    is count("a", 2), 2, 'state var works';
    is count(2, 'a'), 3, '... and there is only one';
}

# L<S13/Syntax/"must all bind the same set of formal variable names">

{
    eval_dies_ok q[ multi sub x ($x, $y) | ($x, $y, $z) { 1 }],
        'multis with multiple sigs must have the same set of formal variables';
    eval_dies_ok q[ multi sub x ($x, $y) | ($x, @y) { 1 }],
        'multis with multiple sigs must have the same set of formal variables';
}

# common sense
eval_dies_ok q[ only sub y (Int $x, Str $y) | (Str $x, Int $y) ],
    'and "only" sub can not have multiple signatures';

# vim: ft=perl6
