use v6;

use lib 't/spec/packages';

use Test;
use Test::Idempotence;

plan 52;

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

is-deeply (my %h{Int}).perl.EVAL.perl, '(my Any %{Int})',
    'can roundtrip .perl.EVAL for parametarized hash with no keys in it';

{
    my %h;
    %h = :42a, :b(%h);
    is-deeply %h.perl.EVAL<b><b><b><a>, 42,
        'can .perl.EVAL roundtrip a circular hash';
}

# RT #120656
{
    my %b = ^512;
    my %c = EVAL(%b.perl);
    is %c.elems, 256, 'Can create large hash with "=>", RT #120656'
}

# RT#132119
{
    for Hash.new, Hash.new(k => "v"),
        Hash[Any].new, Hash[Any].new(k => "v"),
        Hash[Int].new, Hash[Any].new(k => 1),
        Hash[Any,Any].new, Hash[Any,Any].new(k => "v"),
	Hash[Int,Int].new, Hash[Int,Int].new(1 => 2),
	:{ }, :{k => "v"} -> \h {
        my $a = h;
        is-perl-idempotent $a, "{$a.perl}.perl is idempotent";
	my $scalarperl = $a.perl;
	$a := h;
	nok $scalarperl eq $a.perl, "Hash in Scalar and deconted Hash perlify differently ({$a.keyof.perl},{$a.of.perl})";
	is-perl-idempotent $a, "{$a.perl}.perl is idempotent";
    }
}

is (($ = Map.new: (:42a, :70b, :20c)).perl.EVAL,).flat.elems, 1,
    "Map.perl preserves Map's scalar containeration";

#vim: ft=perl6
