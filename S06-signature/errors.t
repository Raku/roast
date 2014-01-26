use v6;

use Test;

plan 11;

=begin pod

These are misc. sub argument errors.

=end pod

sub bar (*@x) { 1 }   #OK not used
lives_ok { bar(reverse(1,2)) }, 'slurpy args are not bounded (2)';  

#?pugs todo
eval_dies_ok 'sub quuux ($?VERSION) { ... }',
             'parser rejects magicals as args (1)';
eval_lives_ok 'sub quuuux ($!) { ... }', 'but $! is OK';

# RT #64344
#?pugs todo
{
    sub empty_sig() { return };
    dies_ok { EVAL('empty_sig("RT #64344")') },
            'argument passed to sub with empty signature';
}

# RT #71478
{
    #?pugs todo
    dies_ok { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' },
        "Passing two arguments to a function expecting one hash is an error";

    try { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' };
    my $error   = "$!";
    #?pugs todo
    ok $error ~~ / '%h' /,   '... error message mentions parameter';
    #?pugs todo
    ok $error ~~ /:i 'type' /, '... error message mentions "type"';
    #?pugs todo
    ok $error ~~ / Associative | \% /, '... error message mentions "Associative" or the % sigil';
}

# RT #109064
eval_dies_ok 'my class A { submethod BUILD(:$!notthere = 10) }; A.new',
    'named parameter of undeclared attribute dies';

# RT #72082
#?niecza todo
#?pugs todo
{
    try { EVAL 'sub rt72082(@a, $b) {}; rt72082(5)' };
    my $error = ~$!;
    ok $error ~~ / 'will never work' .* 'Expected' .* '(@a, Any $b)' /
}

# RT #76368
{
    try { EVAL 'sub foo(Str) {}; foo 42' };
    my $error = ~$!;
    ok $error ~~ / 'will never work' .* 'Expected' .* 'Str' /
}

# vim: ft=perl6
