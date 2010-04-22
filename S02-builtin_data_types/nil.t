use v6;
use Test;

# note that Nil is not actually a type, but just an empty parcel

plan *;

sub empty_sub {}
sub empty_do { do {} }
sub empty_branch_true { if 1 {} else { 1; } }
sub empty_branch_false { if 0 { 1; } else {} }
sub bare_return { return; }
sub rt74448 { eval '' }

#?rakudo 4 skip 'return value of if/for etc'
ok empty_sub()          ~~ Nil, 'empty sub returns Nil';
ok empty_do()           ~~ Nil, 'do {} is Nil';
ok empty_branch_true()  ~~ Nil, 'if 1 {} is Nil';
ok empty_branch_false() ~~ Nil, 'else {} is Nil';
ok bare_return()        ~~ Nil, 'bare return returns Nil';
#?rakudo todo 'RT 74448: eval of empty string should be Nil'
ok rt74448()            ~~ Nil, 'eval of empty string is Nil';

# RT #63894
{
    my $calls;
    sub return_nil { $calls++; return; }

    $calls = 0;
    ok return_nil() ~~ Nil, 'return_nil() ~~ Nil';
    is return_nil().WHAT, 'Parcel()', 'return_nil().WHAT says Parcel';
    is return_nil.WHAT, 'Parcel()', 'return_nil.WHAT says Nil';
    is $calls, 3, 'return_nil() called thrice';

    my $n = return_nil();
    #?rakudo todo 'Nil stored in a variable should be undef'
    ok $n.notdef, 'variable holding nil is not defined';
}

{
    my $x = 0;
    $x++ for Nil;
    is $x, 0, '$Statement for Nil; does zero iterations';
}

done_testing;

# vim: ft=perl6
