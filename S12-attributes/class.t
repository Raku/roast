use v6;

use Test;

=begin pod

Class Attributes

=end pod

#L<S12/Class attributes/"Class attributes are declared">
#L<S12/Class methods/Such a metaclass method is always delegated>

plan 27;

class Foo {
    our $.bar = 23;
    our $.yada = 13;
} 

my $test = 0;
ok ($test = Foo.bar), 'accessors for class attributes work';
is $test, 23, 'class attributes really work';

class Baz is Foo {};

my $test2 = 0;
lives_ok { $test2 = Baz.bar }, 'inherited class attribute accessors work';
is $test2, 23, 'inherited class attributes really work';

my $test3 = 0;
lives_ok { Baz.yada = 42; $test3 = Baz.yada }, 'inherited rw class attribute accessors work';
is $test3, 42, 'inherited rw class attributes really work';

class Quux is Foo { has $.bar = 17; };

my $test4 = 0;
lives_ok { $test4 = Quux.new() },
    'Can instantiate with overridden instance method';
is $test4.bar, 17, 'Instance call gets instance attribute, not class attribute';
my $test5 = 0;
dies_ok {$test5 = Quux.bar}, 'class attribute accessor hidden by accessor in subclass; we do not magically ignore it';

# L<S12/Class methods/"you can associate a method with the current
# metaclass instance">

#?niecza skip 'method ^foo'
{
    class T1 {
        our $c = 0;
        method ^count($obj) {   #OK not used
            return $c;
        }
        method mi { ++$c };
        method md { --$c };
    }

    my ($a, $b, $c) = map { T1.new() }, 1..3;
    is $c.mi,       1, 'can increment class variable in instance method';
    is $b.mi,       2, '.. and the class variable is really shared';
    #?rakudo 6 skip 'nom regression - method ^foo'
    is $a.count,    2, 'can call the class method on an object';
    is T1.count,    2, '... and on the proto object';
    is T1.^count,   2, '... and on the proto object with Class.^method';
    is $a.^count,   2, '... and $obj.^method';
    is T1.HOW.count(T1), 2, '... and by explicitly using .HOW with proto object';
    is $a.HOW.count($a), 2, '... and by explicitly using .HOW with instance';

}

{
    class Oof {
        my $.x;
    }
    my $x = Oof.new();
    $x.x = 42;
    is($x.x, 42, "class attribute accessors work");
    my $y = Oof.new();
    is($y.x, 42, "class attributes shared by all instances");
}

# RT#122087
{
    class Woof {
        my $.x = 'yap';
    }
    my $x = Woof.new();
    is($x.x, 'yap', "class attribute initialization works");
}

# RT #57336
#?niecza skip 'Exception'
{
    # TODO: Test that the exceptions thrown here are the right ones
    #       and not the result of some other bug.

    my $bad_code;

    $bad_code = '$.a';
    try EVAL $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $bad_code ='$!a';
    try EVAL $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $bad_code = 'class B0rk { has $.a; say $.a; }';
    try EVAL $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $bad_code = 'class Chef { my $.a; say $.a; }';
    try EVAL $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";
}

# RT #114230
{
    class RT114230 {
        has &!x;
        method f {
            &!x //= { 'ook!' };
            my $res = defined &!x;
            &!x();
        }
    }
    lives_ok { RT114230.new.f },
        'no Null PMC access when doing //= on an undefined attribute and then calling it';
}

#?niecza skip "Two definitions of method b"
{
    class A {
        has $.b = 1;
        method b() { 2; }
    };
    is A.new.b, 2, "don't create accessor if the class declares an explicit method of that name";


    role B {
        has $.b = 1;
        method b() { 2; }
    };
    is B.new.b, 2;
}

# vim: ft=perl6
