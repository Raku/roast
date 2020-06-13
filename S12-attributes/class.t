use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin pod

Class Attributes

=end pod

#L<S12/Class attributes/"Class attributes are declared">
#L<S12/Class methods/Such a metaclass method is always delegated>

plan 28;

class Foo {
    our $.bar = 23;
    our $.yada = 13;
}

my $test = 0;
ok ($test = Foo.bar), 'accessors for class attributes work';
is $test, 23, 'class attributes really work';

class Baz is Foo {};

my $test2 = 0;
lives-ok { $test2 = Baz.bar }, 'inherited class attribute accessors work';
is $test2, 23, 'inherited class attributes really work';

my $test3 = 0;
lives-ok { Baz.yada = 42; $test3 = Baz.yada }, 'inherited rw class attribute accessors work';
is $test3, 42, 'inherited rw class attributes really work';

class Quux is Foo { has $.bar = 17; };

my $test4 = 0;
lives-ok { $test4 = Quux.new() },
    'Can instantiate with overridden instance method';
is $test4.bar, 17, 'Instance call gets instance attribute, not class attribute';
my $test5 = 0;
dies-ok {$test5 = Quux.bar}, 'class attribute accessor hidden by accessor in subclass; we do not magically ignore it';

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

# https://github.com/Raku/old-issue-tracker/issues/3412
{
    class Woof {
        my $.x = 'yap';
    }
    my $x = Woof.new();
    is($x.x, 'yap', "class attribute initialization works");
}

# https://github.com/Raku/old-issue-tracker/issues/193
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

# https://github.com/Raku/old-issue-tracker/issues/2835
{
    class RT114230 {
        has &!x;
        method f {
            &!x //= { 'ook!' };
            my $res = defined &!x;
            &!x();
        }
    }
    lives-ok { RT114230.new.f },
        'no Null PMC access when doing //= on an undefined attribute and then calling it';
}

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

# https://github.com/Raku/old-issue-tracker/issues/2543
{
    class RT102478_1 { BEGIN EVAL q[has $.x] };
    is RT102478_1.new(x => 3).x, 3,
        'can declare attribute inside of a BEGIN EVAL in class';

    class RT102478_2 { EVAL q[has $.x] };
    throws-like { RT102478_2.new(x => 3).x },
        X::Method::NotFound,
        'cannot declare attribute inside of an EVAL in class';
}

# https://github.com/Raku/old-issue-tracker/issues/4407
is_run(
    'our $.a',
    { err => -> $o { $o ~~ /:i useless/ && $o ~~ /:i accessor/ } },
    'useless our $.a accessor method generation error contains useful enough hints'
);
is_run(
    'my $.a',
    { err => -> $o { $o ~~ /:i useless/ && $o ~~ /:i accessor/ } },
    'useless my $.a accessor method generation error contains useful enough hints'
);

# https://github.com/Raku/old-issue-tracker/issues/6062
subtest 'attribute access from where clauses' => {
    plan 7;
    throws-like ｢my class RT130748a { has $.a; has $.b where $!a }｣,
        X::Syntax::NoSelf, 'where, thunk, attr only';
    throws-like ｢my class RT130748b { has $.a; has $.b where * > $!a }｣,
        X::Syntax::NoSelf, 'where, whatevercode';
    throws-like ｢my class RT130748c { has $.a; has $.b where {$!a}｣,
        X::Syntax::NoSelf, 'where, block';

    my class RT130748d {
        has $.a = 42;
        has $.b where *.so = $!a+1;
        method z-thunk ($x where  $!a ) { pass 'where in method param, thunk' }
        method z-block ($x where {$!a}) { pass 'where in method param, block' }
        method z-whatever ($x where *+$!a) {
            pass 'where in method param, whatevercode'
        }
    }
    is-deeply RT130748d.new.b, 43, 'can still use attr in default values';
    RT130748d.new.z-thunk:    42;
    RT130748d.new.z-block:    42;
    RT130748d.new.z-whatever: 42;
}

{
    my class A {
        has $!a is built = 42;
        method b() { $!a }
    }
    my $a = A.new;
    is $a.b, 42, 'is the private attribute initialized to default value';
    $a = A.new(a => 666);
    is $a.b, 666, 'is the private attribute initialized with .new';
}

{
    my class A {
        has $.a is built(False) = 42;
    }
    my $a = A.new;
    is $a.a, 42, 'is the public attribute initialized to default value';
    $a = A.new(a => 666);
    is $a.a, 42, 'is the public attribute **NOT** initialized with .new';
}

# vim: expandtab shiftwidth=4
