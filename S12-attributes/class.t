use v6;

use Test;

=begin pod

Class Attributes

=end pod

#L<S12/Class attributes/"Class attributes are declared">
#L<S12/Class methods/Such a metaclass method is always delegated>

plan 21;

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

# RT #102478
{
    class RT102478_1 { BEGIN EVAL q[has $.x] };
    is RT102478_1.new(x => 3).x, 3,
        'can declare attribute inside of a BEGIN EVAL in class';

    class RT102478_2 { EVAL q[has $.x] };
    throws_like { RT102478_2.new(x => 3).x },
        X::Method::NotFound,
        'cannot declare attribute inside of an EVAL in class';
}

# vim: ft=perl6
