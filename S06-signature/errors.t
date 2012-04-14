    use v6;

use Test;

plan 9;

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
    dies_ok { eval('empty_sig("RT #64344")') },
            'argument passed to sub with empty signature';
}

# RT #71478
{
    dies_ok { eval 'sub foo(%h) { %h }; foo(1, 2); 1' },
        "Passing two arguments to a function expecting one hash is an error";

    try { eval 'sub foo(%h) { %h }; foo(1, 2); 1' };
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

# vim: ft=perl6
