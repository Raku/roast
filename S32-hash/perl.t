use v6.c;
use Test;

plan 12;

#?niecza todo "cannot roundtrip hashes"
# simple hash
{
    my %h = a => 1, b => 2;
    is %h.perl,'{:a(1), :b(2)}',
      'can we serialize a simple hash';
    my $rh = EVAL(%h.perl);
    is-deeply $rh, $%h, 'can we roundtrip simple hash';
    is $rh.of.^name, 'Mu',  'make sure any value can be stored';
    is $rh.keyof.^name, 'Str(Any)', 'make sure keys are Str(Any)';
} #4

#?niecza skip "cannot roundtrip hashes with constrained values"
# hash with constrained values
{
    my Int %h = a => 1, b => 2;
    is %h.perl, '(my Int % = :a(1), :b(2))',
      'can we serialize a hash with constrained values';
    my $rh = EVAL(%h.perl);
    is-deeply $rh, %h, 'can we roundtrip hash constrained values';
    is $rh.of, Int, 'make sure roundtripped values are Int';
    is $rh.keyof.^name, 'Str(Any)', 'make sure roundtripped keys are Str(Any)';
} #4

#?niecza skip "cannot roundtrip hashes with constrained keys & values"
# hash with constrained keys & values
{
    my Int %h{Str} = a => 1, b => 2;
    is %h.perl, '(my Int %{Str} = :a(1), :b(2))',
      'can we serialize a hash with constrained keys & values';
    my $rh = EVAL(%h.perl);
    is-deeply $rh, %h, 'can we roundtrip hash constrained keys & values';
    is $rh.of, Int, 'make sure roundtripped values are Int';
    is $rh.keyof, Str, 'make sure roundtripped keys are Str';
} #4

#vim: ft=perl6
