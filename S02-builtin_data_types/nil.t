use v6;
use Test;

plan 8;

# RT #63894
{
    my $calls;
    sub return_nil { $calls++; return; }

    $calls = 0;
    ok return_nil() ~~ Nil, 'return_nil() ~~ Nil';
    is return_nil().WHAT, 'Nil()', 'return_nil().WHAT says Nil';
    is $calls, 2, 'return_nil() called twice';

    $calls = 0;
    #?rakudo todo 'RT #63894'
    ok (return_nil ~~ Nil), 'return_nil ~~ Nil';
    is return_nil.WHAT, 'Nil()', 'return_nil.WHAT says Nil';
    is $calls, 2, 'return_nil() called twice';

    my $n = return_nil();
    ok $n ~~ Failure, 'variable holding nil ~~ Failure';
    is $n.WHAT, 'Failure()', '.WHAT on Nil variable says Failure';
}
