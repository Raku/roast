use v6;

use Test;

plan 27;

=begin pod

These are misc. sub argument errors.

=end pod

sub bar (*@x) { 1 }   #OK not used
lives_ok { bar(reverse(1,2)) }, 'slurpy args are not bounded (2)';  

eval_dies_ok 'sub quuux ($?VERSION) { ... }',
             'parser rejects magicals as args (1)';
eval_lives_ok 'sub quuuux ($!) { ... }', 'but $! is OK';

# RT #64344
{
    sub empty_sig() { return };
    dies_ok { EVAL('empty_sig("RT #64344")') },
            'argument passed to sub with empty signature';
}

# RT #71478
{
    dies_ok { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' },
        "Passing two arguments to a function expecting one hash is an error";

    try { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' };
    my $error   = "$!";
    ok $error ~~ / '(%h)' /,   '... error message mentions signature';
    ok $error ~~ / :i call /, '... error message mentions "call"';
    ok $error ~~ /'foo(Int, Int)' /, '... error message mentions call profile';
}

# RT #109064
eval_dies_ok 'my class A { submethod BUILD(:$!notthere = 10) }; A.new',
    'named parameter of undeclared attribute dies';

# RT #72082
#?niecza todo
{
    try { EVAL 'sub rt72082(@a, $b) {}; rt72082(5)' }
    my $error = ~$!;
    ok $error ~~ /:i 'rt72082(Int)' .*? /, "too few args reports call profile";
    ok $error ~~ /:i '(@a, Any $b)' /, "too few args reports declared signature";
    ok $error ~~ /signature/, "too few args mentions signature";
    ok $error ~~ / :i call /, '... error message mentions "call"';
}

# RT #76368
{
    try { EVAL 'sub foo(Str) {}; foo 42' }
    my $error = ~$!;
    ok $error ~~ /:i 'foo(Int)' /, "simple Str vs Int reports call profile";
    ok $error ~~ /:i '(Str)' /, "simple Str vs Int reports signature";
    ok $error ~~ /signature/, "simple Str vs Int mentions signature";
    ok $error ~~ / :i call /, '... error message mentions "call"';
}

#?rakudo.jvm todo "unival NYI"
{
    try { EVAL 'unival(42.2)' }
    my $error = ~$!;
    ok $error ~~ /:i 'unival(Rat)' /, "fails multi sigs reports call profile";
    ok $error ~~ /multi/, "mentions multi";
    ok $error ~~ /signatures/, "mentions signatures";
    ok $error ~~ /^^ \h* '(Str'/, "Error mentions Str";
    ok $error ~~ /^^ \h* '(Int'/, "Error mentions Int";
    ok $error ~~ / :i call /, '... error message mentions "call"';
}

# RT #78670
{
    try { EVAL 'multi rt78670(Int) {}; my $str = "foo"; rt78670 $str' }
    my $error = ~$!;
    ok $error ~~ /:i 'rt78670(Str)' /, "fails multi sigs reports call profile";
    ok $error ~~ /signature/, "mentions signature";
    ok $error ~~ /^^ \h* '(Int'/, "Error mentions Int";
    ok $error ~~ / :i call /, '... error message mentions "call"';
}
# vim: ft=perl6
