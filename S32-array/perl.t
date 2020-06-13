use v6;
use Test;

plan 8;

# simple array
{
    my @a = 1,2;
    is @a.raku, '[1, 2]',
      'can we serialize a simple array';
    my $ra = EVAL(@a.raku);
    is-deeply $ra, @a, 'can we roundtrip simple array';
    ok $ra.of =:= Mu, 'make sure any value can be stored';
} #3

# array with constrained values
{
    my Int @a = 1,2;
    is @a.raku, 'Array[Int].new(1, 2)',
      'can we serialize a array with constrained values';
    my $ra = EVAL(@a.raku);
    is-deeply $ra, @a, 'can we roundtrip array constrained values';
    ok $ra.of =:= Int, 'make sure roundtripped values are Int';
} #3

{
    my @a;
    @a = 42, @a;
    is-deeply @a.raku.EVAL[1][1][1][0], 42,
        'can .raku.EVAL roundtrip a circular array';

    my %h; my @b;
    %h = :b(%h), :c(@b);
    @b = %h, @b, 42;
    is-deeply @b.raku.EVAL[1][1][0]<b><b><c>[2], 42,
        'can .raku.EVAL roundtrip a circular array within a circular hash';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
