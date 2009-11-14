use v6;
use Test;

plan *;

sub empty_sub {}
sub empty_do { do {} }
sub empty_branch_true { if 1 {} else { 1; } }
sub empty_branch_false { if 0 { 1; } else {} }
sub bare_return { return; }

#?rakudo 3 todo 'empty blocks result in Nil'
ok empty_sub()          ~~ Nil, 'empty sub returns Nil';
ok empty_do()           ~~ Nil, 'do {} is Nil';
ok empty_branch_true()  ~~ Nil, 'if 1 {} is Nil';
#?rakudo skip 'Null PMC access in can()'
ok empty_branch_false() ~~ Nil, 'else {} is Nil';
ok bare_return()        ~~ Nil, 'bare return returns Nil';

# RT #63894
{
    my $calls;
    sub return_nil { $calls++; return; }

    $calls = 0;
    ok return_nil() ~~ Nil, 'return_nil() ~~ Nil';
    is return_nil().WHAT, 'Nil()', 'return_nil().WHAT says Nil';
    is return_nil.WHAT, 'Nil()', 'return_nil.WHAT says Nil';
    is $calls, 3, 'return_nil() called thrice';

    my $n = return_nil();
    ok $n ~~ Failure, 'variable holding nil ~~ Failure';
    is $n.WHAT, 'Failure()', '.WHAT on Nil variable says Failure';
}

#?rakudo todo 'RT 69270'
{
    my $x = 0;
    $x++ for Nil;
    is $x, 0, '$Statement for Nil; does zero iterations';
}

done_testing;

# vim: ft=perl6
