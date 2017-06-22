use v6;
use Test;

plan 8;

# simple array
{
    my @a = 1,2;
    is @a.perl, '[1, 2]',
      'can we serialize a simple array';
    my $ra = EVAL(@a.perl);
    is-deeply $ra, @a, 'can we roundtrip simple array';
    ok $ra.of =:= Mu, 'make sure any value can be stored';
} #3

# array with constrained values
{
    my Int @a = 1,2;
    is @a.perl, 'Array[Int].new(1, 2)',
      'can we serialize a array with constrained values';
    my $ra = EVAL(@a.perl);
    is-deeply $ra, @a, 'can we roundtrip array constrained values';
    ok $ra.of =:= Int, 'make sure roundtripped values are Int';
} #3

{
    my @a;
    @a = 42, @a;
    is-deeply @a.perl.EVAL[1][1][1][0], 42,
        'can .perl.EVAL roundtrip a circular array';

    my %h; my @b;
    %h = :b(%h), :c(@b);
    @b = %h, @b, 42;
    is-deeply @b.perl.EVAL[1][1][0]<b><b><c>[2], 42,
        'can .perl.EVAL roundtrip a circular array within a circular hash';
}

#vim: ft=perl6
