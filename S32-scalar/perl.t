use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Idempotence;

plan 7;

# simple array
{
    my $a = 1;
    is $a.raku, '1',
      'can we serialize a simple scalar';
    my $ra = EVAL($a.raku);
    is-deeply $ra, $a, 'can we roundtrip simple scalar';
    ok $ra.VAR.of =:= Mu, 'make sure any value can be stored';
} #3

# array with constrained values
{
    my Int $a = 1;
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    is $a.raku, 'Int(1)',
      'can we serialize a scalar with constrained values';
    my $ra = EVAL($a.raku);
    is-deeply $ra, $a, 'can we roundtrip scalar constrained values';
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    ok $ra.VAR.of =:= Int, 'make sure roundtripped values are Int';
} #3

# https://github.com/Raku/old-issue-tracker/issues/3669

is-perl-idempotent 2/6, :eqv, 'Rat.raku is idempotent';

#vim: ft=perl6

# vim: expandtab shiftwidth=4
