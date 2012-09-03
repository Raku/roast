use v6;

use Test;


plan 29;

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

ok eval('List').does(Positional), "List does Positional";
#?niecza skip 'Undeclared name Seq'
ok eval('Seq').does(Positional), "Seq does Positional";
ok eval('Array').does(Positional), "Array does Positional";
ok eval('Range').does(Positional), "Range does Positional";
ok eval('Parcel').does(Positional), "Parcel does Positional";
#?niecza skip 'Undeclared name Buf'
ok eval('Buf').does(Positional), "Buf does Positional";
#?rakudo todo "Capture does Positional"
ok eval('Capture').does(Positional), "Capture does Positional";

my %hash;
#?pugs todo 'feature'
ok %hash.does(Associative), 'uninitialized %var does Associative';
%hash = {};
ok %hash.does(Associative), 'value in %var does Associative';

#?niecza todo
ok eval('Pair').does(Associative), "Pair does Associative";
ok eval('Set').does(Associative), "Set does Associative";
ok eval('Bag').does(Associative), "Bag does Associative";
#?niecza skip 'Undeclared name KeyHash'
ok eval('KeyHash').does(Associative), "KeyHash does Associative";
#?rakudo todo "Capture does Associative"
ok eval('Capture').does(Associative), "Capture does Associative";


sub foo {}
ok &foo.does(Callable), 'a Sub does Callable';
#?rakudo todo 'method outside class - fix test?'
#?niecza skip 'Methods must be used in some kind of package'
{
    method meth {}
    ok &meth.does(Callable), 'a Method does Callable';
}
proto mul(|) {*}
multi mul {}
ok &mul.does(Callable), 'a multi does Callable';
proto pro {}
ok &pro.does(Callable), 'a proto does Callable';

# &token, &rule return a Method?
#?niecza skip 'Methods must be used in some kind of package'
{
    token bar {<?>}
    #?pugs todo 'feature'
    #?rakudo todo 'token/rule outside of class and grammar'
    ok &bar.does(Callable), 'a token does Callable';
    rule baz {<?>}
    #?pugs todo 'feature'
    #?rakudo todo 'token/rule outside of class and grammar'
    ok &baz.does(Callable), 'a rule does Callable';
    # &quux returns a Sub ?
    macro quux {}
    #?pugs todo 'feature'
    ok &quux.does(Callable), 'a macro does Callable';
}

# RT 69318
{
    sub a { return 'a' };
    sub b { return 'b' };
    dies_ok { &a = &b }, 'cannot just assign &b to &a';
    is a(), 'a', 'and the correct function is still in place';

}

# RT #74654
{
    sub f() { '42' };
    my $x = &f;
    is &$x(), '42', 'can use &$x() for invoking';
}

# vim: ft=perl6
