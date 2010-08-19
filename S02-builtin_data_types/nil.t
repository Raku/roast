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

ok empty_sub()          ~~ Nil, 'empty sub returns Nil';
ok empty_do()           ~~ Nil, 'do {} is Nil';
ok empty_branch_true()  ~~ Nil, 'if 1 {} is Nil';
ok empty_branch_false() ~~ Nil, 'else {} is Nil';
ok bare_return()        ~~ Nil, 'bare return returns Nil';
ok rt74448()            ~~ Nil, 'eval of empty string is Nil';

nok Nil.defined, 'Nil is not defined';
ok  ().defined,  '() is defined';
nok (my $x = Nil).defined, 'assigning Nil to scalar leaves it undefined';
ok (my $y = ()).defined, 'assigning () to scalar results in a defined parcel';

# RT #63894
{
    my $calls;
    sub return_nil { $calls++; return; }

    $calls = 0;
    ok return_nil() ~~ Nil, 'return_nil() ~~ Nil';
    is return_nil().WHAT, 'Nil()', 'return_nil().WHAT says Nil';
    is $calls, 2, 'return_nil() called twice';

    my $n = return_nil();
    ok $n.notdef, 'variable holding nil is not defined';
}

{
    my $x = 0;
    $x++ for Nil;
    is $x, 0, '$Statement for Nil; does zero iterations';
}

done_testing;

# vim: ft=perl6
