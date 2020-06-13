use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Idempotence;

plan 55;

# simple hash
{
    my %h = a => 1, b => 2;
    is %h.raku,'{:a(1), :b(2)}',
      'can we serialize a simple hash';
    my $rh = EVAL(%h.raku);
    is-deeply $rh, $%h, 'can we roundtrip simple hash';
    is $rh.of,    Mu,       'make sure any value can be stored';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is $rh.keyof, Str(Any), 'make sure keys are Str(Any)';
} #4

# hash with constrained values
{
    my Int %h = a => 1, b => 2;
    is %h.raku, '(my Int % = :a(1), :b(2))',
      'can we serialize a hash with constrained values';
    my $rh = EVAL(%h.raku);
    is-deeply $rh, %h, 'can we roundtrip hash constrained values';
    is $rh.of,    Int,      'make sure roundtripped values are Int';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is $rh.keyof, Str(Any), 'make sure roundtripped keys are Str(Any)';
} #4

# hash with constrained keys & values
{
    my Int %h{Str} = a => 1, b => 2;
    is %h.raku, '(my Int %{Str} = :a(1), :b(2))',
      'can we serialize a hash with constrained keys & values';
    my $rh = EVAL(%h.raku);
    is-deeply $rh, %h, 'can we roundtrip hash constrained keys & values';
    is $rh.of,    Int, 'make sure roundtripped values are Int';
    is $rh.keyof, Str, 'make sure roundtripped keys are Str';
} #4

{
    my %h{Int};
    is-deeply %h.raku.EVAL, %h,
        'can roundtrip .raku.EVAL for parametarized hash with no keys in it';
}

{
    my %h;
    %h = :42a, :b(%h);
    is-deeply %h.raku.EVAL<b><b><b><a>, 42,
        'can .raku.EVAL roundtrip a circular hash';
}

# https://github.com/Raku/old-issue-tracker/issues/3286
{
    my %b = ^512;
    my %c = EVAL(%b.raku);
    is %c.elems, 256, 'Can create large hash with "=>", RT #120656'
}

# https://github.com/Raku/old-issue-tracker/issues/6535

{
    for Hash.new, Hash.new(k => "v"),
        Hash[Any].new, Hash[Any].new(k => "v"),
        Hash[Int].new, Hash[Any].new(k => 1),
        Hash[Any,Any].new, Hash[Any,Any].new(k => "v"),
	      Hash[Int,Int].new, Hash[Int,Int].new(1 => 2),
	      :{ }, :{k => "v"}
    -> \h {
        my $a = h;
        is-perl-idempotent $a, "{$a.raku}.raku is idempotent";

      	my $scalarperl = $a.raku;
      	$a := h;
      	isnt $scalarperl, $a.raku,
          "Hash in Scalar and deconted Hash perlify differently ({$a.keyof.raku},{$a.of.raku})";

        is-perl-idempotent $a, "{$a.raku}.raku is idempotent";
    }
}

is (($ = Map.new: (:42a, :70b, :20c)).raku.EVAL,).flat.elems, 1,
    "Map.raku preserves Map's scalar containeration";

# R#2348
{
    dies-ok { Hash[Int].new("a","b") }, 'typecheck on initialization';
    my %h := Hash[Int].new;
    dies-ok { %h<a> = "b" }, 'typecheck on assignment';
    dies-ok { %h<a> := "b" }, 'typecheck on binding';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
