use v6;

use Test;


plan 26;

my $scalar;
ok $scalar.WHAT === Any, 'unitialized $var does Mu';
$scalar = 1;
ok $scalar ~~ Any, 'value contained in a $var does Mu';



{
    my @array;
    ok @array.does(Positional), 'unitialized @var does Positional';
}
{
    my @array = [];
    ok @array.does(Positional), 'value contained in a @var does Positional';
}
{
    my @array = 1;
    ok @array.does(Positional), 'generic val in a @var is converted to Positional';
}

#?rakudo skip 'Roles of builtin types'
#?DOES 5
{
    for <List Seq Range Buf Capture> -> $c {
        ok eval($c).does(Positional), "$c does Positional";
    }
}


my %hash;
#?pugs todo 'feature'
ok %hash.does(Associative), 'uninitialized %var does Associative';
%hash = {};
ok %hash.does(Associative), 'value in %var does Associative';

#?DOES 5
#?rakudo todo 'Associative role'
{
    for <Pair Mapping Set Bag KeyHash Capture> -> $c {
        if eval('$c') {
            ok $c.does(Associative), "$c does Associative";
        }
    }
}

#?rakudo skip 'Abstraction'
ok Class.does(Abstraction), 'a class is an Abstraction';

sub foo {}
ok &foo.does(Callable), 'a Sub does Callable';
#?rakudo skip 'method outside class - fix test?'
{
    method meth {}
    ok &meth.does(Callable), 'a Method does Callable';
}
multi mul {}
ok &mul.does(Callable), 'a multi does Callable';
proto pro {}
ok &pro.does(Callable), 'a proto does Callable';

# &token, &rule return a Method?
#?rakudo skip 'token/rule outside of class and grammar; macro'
{
    token bar {<?>}
    #?pugs todo 'feature'
    ok &bar.does(Callable), 'a token does Callable';
    rule baz {<?>}
    #?pugs todo 'feature'
    ok &baz.does(Callable), 'a rule does Callable';
    # &quux returns a Sub ?
    macro quux {}
    #?pugs todo 'feature'
    ok &quux.does(Callable), 'a rule does Callable';
}

# vim: ft=perl6
