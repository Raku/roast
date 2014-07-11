use v6;

use Test;

plan 8;

class Foo {
    method bar (Foo $class: $arg) { return 100 + $arg }   #OK not used
}

{
    my $val;
    lives_ok {
        $val = Foo.bar(42);
    }, '... class|instance methods work for class';
    is($val, 142, '... basic class method access worked');
}

{
    my $foo = Foo.new();
    my $val;
    lives_ok {
        $val = $foo.bar(42);
    }, '... class|instance methods work for instance';
    is($val, 142, '... basic instance method access worked');
}

class Act {
    my method rules() { 'the world' }
    our method rocks() { 'the house' }
    
    is(rules(Act), 'the world', 'my method is lexically installed');
}
#?niecza todo "https://github.com/sorear/niecza/issues/185"
dies_ok({ Act.rules }, 'my method not installed in methods table');
is(Act::rocks(Act), 'the house', 'our method is installed in package');
#?niecza todo "https://github.com/sorear/niecza/issues/185"
dies_ok({ Act.rocks }, 'our method not installed in methods table');

# vim: ft=perl6
