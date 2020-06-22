use v6;

use Test;

plan 12;

class Foo {
    has $.foo-bonus;

    method bar (Foo $class: $arg) { return 100 + $arg }   #OK not used

    # xor methods call either class or instance not both
    multi method bar-Foo-xor (::?CLASS:U: $arg) { return 10 + $arg }
    multi method bar-Foo-xor (::?CLASS:D: $arg) { return 20 + $arg }
    method bar-Foo-named-instance (Foo:D $inst: $arg) {
        return 20 + $inst.foo-bonus + $arg
    }
}

{
    my $val;
    lives-ok {
        $val = Foo.bar(42);
    }, '... class|instance methods work for class';
    is($val, 142, '... basic class method access worked');
}

{
    my $foo = Foo.new();
    my $val;
    lives-ok {
        $val = $foo.bar(42);
    }, '... class|instance methods work for instance';
    is($val, 142, '... basic instance method access worked');
}

is(Foo.bar-Foo-xor(42), 52, 'multi method for class not instance');
is(Foo.new.bar-Foo-xor(42), 62, 'multi method for instance not class');
is( Foo.new(:25foo-bonus).bar-Foo-named-instance(42), 87,
    'instance only method named invocant'
);
throws-like(
    { Foo.bar-Foo-named-instance(42) }, X::Parameter::InvalidConcreteness,
    'correctly refused class invocant for instance only method'
);

class Act {
    my method rules() { 'the world' }
    our method rocks() { 'the house' }
    
    is(rules(Act), 'the world', 'my method is lexically installed');
}
dies-ok({ Act.rules }, 'my method not installed in methods table');
is(Act::rocks(Act), 'the house', 'our method is installed in package');
dies-ok({ Act.rocks }, 'our method not installed in methods table');

# vim: expandtab shiftwidth=4
