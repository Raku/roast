use v6.c;
use Test;
use lib 't/spec/packages';
use Test::Idempotence;

plan 7;

# simple array
{
    my $a = 1;
    is $a.perl, '1',
      'can we serialize a simple scalar';
    my $ra = EVAL($a.perl);
    is-deeply $ra, $a, 'can we roundtrip simple scalar';
    ok $ra.VAR.of =:= Mu, 'make sure any value can be stored';
} #3

#?niecza skip "cannot roundtrip scalars with constrained values"
# array with constrained values
{
    my Int $a = 1;
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    is $a.perl, 'Int(1)',
      'can we serialize a scalar with constrained values';
    my $ra = EVAL($a.perl);
    is-deeply $ra, $a, 'can we roundtrip scalar constrained values';
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    ok $ra.VAR.of =:= Int, 'make sure roundtripped values are Int';
} #3

# RT#123741
is-perl-idempotent 2/6, :eqv, 'Rat.perl is idempotent';

#vim: ft=perl6
