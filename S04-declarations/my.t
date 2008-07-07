use v6;
use Test;

plan 6;

#L<S04/The Relationship of Blocks and Declarations/"declarations, all
# lexically scoped declarations are visible"> 
{

    #?rakudo todo 'lexicals bug'
    eval_dies_ok('$x; my $x = 42', 'my() variable not yet visible prior to declartation');
    is(eval('my $x = 42; $x'), 42, 'my() variable is visible now (2)');
}


{
    my $ret = 42;
    eval_dies_ok '$ret = $x ~ my $x;', 'my() variable not yet visible (1)';
    is $ret, 42,                       'my() variable not yet visible (2)';
}

#?rakudo skip 'scoping bug'
{
    my $ret = 42;
    lives_ok { $ret = my($x) ~ $x }, 'my() variable is visible (1)';
    is $ret, "",                     'my() variable is visible (2)';
}


# vim: ft=perl6
