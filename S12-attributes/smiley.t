use v6;
use Test;

plan 7;

class Foo0 { has Int:_ $.bar }
is Foo0.new.bar, Int, 'Int:_ on attribute without initializer';

class Foo1 { has Int:_ $.bar = 0 }
is Foo1.new.bar, 0, 'Int:_ on attribute with initializer';

throws-like 'class Foo2 { has Int:D $.bar }',
    X::Syntax::Variable::MissingInitializer,
    type => 'Int:D',
    'Int:D on attribute wíthout initializer throws';

class Foo3 { has Int:D $.bar = 1 }
is Foo3.new.bar, 1, 'Int:D on attribute with initializer';

class Foo4 { has Int:U $.bar }
ok Foo4.new.bar ~~ Int, 'Int:U on attribute without initializer';

class Foo5 { has Int:U $.bar = IntStr }
ok Foo5.new.bar ~~ Int, 'Int:U on attribute with initializer';

{
    use variables :D;
    #?rakudo todo 'variables pragma NYI'
    throws-like 'class Foo6 { has Int $.bar }',
        X::Syntax::Variable::MissingInitializer,
        type => 'Int:D',
        'Int:D on attribute wíthout initializer throws';
}

# vim: ft=perl6
