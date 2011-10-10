    use v6;

use Test;

plan 8;

=begin pod

These are misc. sub argument errors.

=end pod

sub bar (*@x) { 1 }   #OK not used
lives_ok { bar(reverse(1,2)) }, 'slurpy args are not bounded (2)';  

eval_dies_ok 'sub quuux ($?VERSION) { ... }',
             'parser rejects magicals as args (1)';
eval_lives_ok 'sub quuuux ($!) { ... }', 'but $! is OK';

# RT #64344
#?niecza skip 'Excess arguments to MAIN empty_sig, used 0 of 1 positionals'
{
    sub empty_sig() { return };
    dies_ok { eval('empty_sig("RT #64344")') },
            'argument passed to sub with empty signature';
}

# RT #71478
#?niecza skip 'Excess arguments to MAIN_3 foo, used 1 of 2 positionals'
{
    my $success = try { eval 'sub foo(%h) { %h }; foo(1, 2); 1' };
    my $error   = "$!";
    nok $success,
        "Passing two arguments to a function expecting one hash is an error";
    ok $error ~~ / '%h' /,   '... error message mentions parameter';
    ok $error ~~ /:i 'type' /, '... error message mentions "type"';
    ok $error ~~ / Associative /, '... error message mentions "Associative"';
}

# vim: ft=perl6
