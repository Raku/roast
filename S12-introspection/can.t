use v6;

use Test;

=begin pod

Tests for can.

=end pod

plan 29;

# L<S12/"Introspection"/Unlike in Perl where .can returns a single Code object>

lives-ok { Str.can("split") },   "method can on built-in Str works";
ok "foo".can("split"),           "methd can on built-in Str gives correct result if method found";
ok "foo".can("split") ~~ Positional, '.can returns  something Positional';
ok !"foo".can("hazcheezburger"), "methd can on built-in Str gives correct result if method not found";
ok "bar".^can("split"),          "calling ^can also works";
ok "x".HOW.can("x", "split"),    "and also through the HOW";
ok Str.can("split"),             "can call on the proto-object too";
ok !Str.can("hazcheezburger"),   "can call on the proto-object too";

class Dog {
    method bark {
        "bow";
    }
}

my $dog = Dog.new;
lives-ok { $dog.can("bark") }, "method can on custom class works";
ok $dog.can("bark"),           "method can on custom class gives correct result if method found (on instance)";
ok !$dog.can("w00f"),          "method can on custom class gives correct result if method not found (on instance)";
ok Dog.can("bark"),            "method can on custom class gives correct result if method found (on proto)";
ok !Dog.can("w00f"),           "method can on custom class gives correct result if method not found (on proto)";

my $meth = $dog.can("bark");
is $meth[0]($dog), "bow", "the result for can contains an invokable, giving us the sub (on instance)";
$meth = Dog.can("bark");
is $meth[0](Dog), "bow",  "the result for can contains an invokable, giving us the sub (on proto)";

{
    my $iters = 0;
    my $found = "";
    for $dog.can("bark") -> $meth {
        $found ~= $meth($dog);
        $iters++;
    }
    is $iters, 1,     "had right number of methods found (on instance)";
    is $found, "bow", "got right method called (on instance)";
}

{
    my $iters = 0;
    my $found = "";
    for Dog.can("bark") -> $meth {
        $found ~= $meth($dog);
        $iters++;
    }
    is $iters, 1,     "had right number of methods found (on proto)";
    is $found, "bow", "got right method called (on proto)";
}

class Puppy is Dog {
    method bark {
        "yap";
    }
}
my $pup = Puppy.new();

{
    my $iters = 0;
    my $found = "";
    for $pup.can("bark") -> $meth {
        $found ~= $meth($pup);
        $iters++;
    }
    is $iters, 2,        "subclass had right number of methods found (on instance)";
    is $found, "yapbow", "subclass got right methods called (on instance)";
}

{
    my $iters = 0;
    my $found = "";
    for Puppy.can("bark") -> $meth {
        $found ~= $meth($pup);
        $iters++;
    }
    is $iters, 2,        "subclass had right number of methods found (on proto)";
    is $found, "yapbow", "subclass got right methods called (on proto)";
}

# RT #76584
ok Str.can('split') ~~ /split/, 'return value of .can stringifies sensibly';

{
    # RT #76882
    my class A {
        method b() { 'butterfly' }
    }
    sub callit($invocant, $method) { $method($invocant) };
    is callit(A.new, A.^can('b')[0]), 'butterfly',
        'can call method reference outside the class';
}

{
    # RT #123621
    my class A {
        submethod x() { 42 }
    }
    ok A.^can("x"), 'submethods found by .^can';
    ok A.can("x"), 'submethods found by .can';

    class B is A {
    }
    nok B.^can("x"), 'submethods from base classes not bogusly found by .^can';
    nok B.can("x"), 'submethods from base classes not bogusly found by .can';
}

# vim: ft=perl6
