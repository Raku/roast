use v6;

use Test;

plan 4;

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

# vim: ft=perl6
