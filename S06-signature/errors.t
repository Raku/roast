    use v6;

use Test;

    plan 9;

=begin pod

These are misc. sub argument errors.

=end pod

sub foo (*$x) { 1 }
#?rakudo todo 'RT #61094'
dies_ok  { foo(reverse(1,2)) }, 'slurpy args are now bounded (1)';

sub bar (*@x) { 1 }
lives_ok { bar(reverse(1,2)) }, 'slurpy args are not bounded (2)';  

eval_dies_ok 'sub quuux ($?VERSION) { ... }',
             'parser rejects magicals as args (1)';
#?rakudo skip 'STD.pm actually parses this - is this test valid?'
eval_dies_ok('sub quuuux ($!) { ... }',
    'parser rejects magicals as args (2)');

# RT #64344
{
    sub empty_sig() { return }
    dies_ok { empty_sig( 'RT #64344' ) },
            'argument passed to sub with empty signature';
}

# RT #71478
{
    my $success = eval 'sub foo(%h) { }; foo(1, 2); 1';
    my $error   = "$!";
    nok $success,
        "Passing two arguments to a function expecting one hash is an error";
    ok $error ~~ / '%h' /,   '... error message mentions parameter';
    ok $error ~~ /:i 'type' /, '... error message mentions "type"';
    ok $error ~~ / Associative /, '... error message mentions "Associative"';
}

# vim: ft=perl6
