use v6;

use Test;

plan 6;

# L<S12/Construction and Initialization>
# Basic instantiation.
class Foo1 { };
my $foo1 = Foo1.new();
ok(defined($foo1), 'instantiated a class');

# Instantiation with initializing attributes.
class Foo2 {
    has $!a;
    has $!b;
    method check {
        $!a + $!b
    }
}
my $foo2 = Foo2.new(:a(39), :b(3));
is($foo2.check(), 42, 'initializing attributes in new');

# RT #62732
{
    eval 'NoSuchClass.new()';
    ok  $!  ~~ Exception, 'death to instantiating nonexistent class';
    ok "$!" ~~ / NoSuchClass /,
       'error for "NoSuchClass.new()" mentions NoSuchClass';

    eval 'NoSuch::Subclass.new()';
    ok  $!  ~~ Exception, 'death to instantiating nonexistent::class';
    ok "$!" ~~ / 'NoSuch::Subclass' /,
       'error for "NoSuch::Subclass.new()" mentions NoSuch::Subclass';
}

# vim: ft=perl6
