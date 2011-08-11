use v6;

use Test;

=begin pod

Class Attributes

=end pod

#L<S12/Class attributes/"Class attributes are declared">
#L<S12/Class methods/Such a metaclass method is always delegated>

plan 28;

class Foo {
    our $.bar = 23;
    our $.yada is rw = 13;
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
#?pugs 99 todo 'class attributes'
lives_ok { $test4 = Quux.new() },
    'Can instantiate with overridden instance method';
is $test4.bar, 17, 'Instance call gets instance attribute, not class attribute';
my $test5 = 0;
dies_ok {$test5 = Quux.bar}, 'class attribute accessor hidden by accessor in subclass; we do not magically ignore it';
#?rakudo 5 todo 'class attributes'
is $test5, 23, 'class attribute really works, even when overridden';
my $test6 = 0;
lives_ok { $test6 = Quux.^bar}, 'class attribute accessible via ^name';
is $test6, 23, 'class attribute via ^name really works';
my $test7 = 0;
#?pugs 2 todo 'feature'
lives_ok {$test7 = $test4.^bar},
    'class attribute accessible via ^name called on instance';
is $test7, 23, 'class attribute via $obj.^name really works';

# L<S12/Class methods/"you can associate a method with the current
# metaclass instance">

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
    is $a.count,    2, 'can call the class method on an object';
    is T1.count,    2, '... and on the proto object';
    is T1.^count,   2, '... and on the proto object with Class.^method';
    is $a.^count,   2, '... and $obj.^method';
    is T1.HOW.count(T1), 2, '... and by explicitly using .HOW with proto object';
    is $a.HOW.count($a), 2, '... and by explicitly using .HOW with instance';

}

{
    class Oof {
        my $.x is rw;
    }
    my $x = Oof.new();
    $x.x = 42;
    is($x.x, 42, "class attribute accessors work");
    my $y = Oof.new();
    is($y.x, 42, "class attributes shared by all instances");
}

# RT #57336
{
    # TODO: Test that the exceptions thrown here are the right ones
    #       and not the result of some other bug.

    my $bad_code;

    $bad_code = '$.a';
    eval $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $bad_code ='$!a';
    eval $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";
    
    $bad_code = 'class B0rk { has $.a; say $.a; }';
    eval $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";
    
    $bad_code = 'class Chef { my $.a; say $.a; }';
    eval $bad_code;
    ok $! ~~ Exception, "bad code: '$bad_code'";
}

# vim: ft=perl6
