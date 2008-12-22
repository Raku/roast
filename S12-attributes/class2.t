use v6;

use Test;

=begin pod

Class Attributes

=end pod

#L<S12/Attributes/"Class attributes are declared">
#L<S12/Class methods/metaclass method always delegated>

plan 20;

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
lives_ok {$test5 = Quux.bar}, 'class attribute still accessible via class name';
#?rakudo 5 todo 'class attributes'
is $test5, 23, 'class attribute really works, even when overridden';
my $test6 = 0;
lives_ok { $test6 = Quux.^bar}, 'class attribute accessible via ^name';
is $test6, 23, 'class attribute via ^name really works';
my $test7 = 0;
lives_ok {$test7 = $test4.^bar},
    'class attribute accessible via ^name called on instance', :todo<feature>;
is $test7, 23, 'class attribute via $obj.^name really works', :todo<feature>;

# L<S12/Class methods/"you can associate a class method with the current
# metaclass instance">

#?rakudo skip '"method ^classmethod" syntax'
{
    class T1 {
        our $c = 0;
        method ^count {
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
    is $a.^count,   2, '... and $obj.^method'

}

# vim: ft=perl6
