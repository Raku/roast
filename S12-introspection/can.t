use v6;

use Test;

=begin pod

Tests for can.

=end pod

plan 25;

# L<S12/"Introspection"/Unlike in Perl 5 where .can returns a single Code object>

lives_ok { Str.can("split") },   "method can on built-in Str works";
ok "foo".can("split"),           "methd can on built-in Str gives correct result if method found";
#?niecza todo '.can returns something Positional'
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
lives_ok { $dog.can("bark") }, "method can on custom class works";
ok $dog.can("bark"),           "method can on custom class gives correct result if method found (on instance)";
ok !$dog.can("w00f"),          "method can on custom class gives correct result if method not found (on instance)";
ok Dog.can("bark"),            "method can on custom class gives correct result if method found (on proto)";
ok !Dog.can("w00f"),           "method can on custom class gives correct result if method not found (on proto)";

my $meth = $dog.can("bark");
#?niecza skip 'No match'
is $meth[0]($dog), "bow", "the result for can contains an invokable, giving us the sub (on instance)";
$meth = Dog.can("bark");
#?niecza skip 'No match'
is $meth[0](Dog), "bow",  "the result for can contains an invokable, giving us the sub (on proto)";

#?niecza skip 'No match'
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

#?niecza skip 'No match'
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

#?niecza skip 'No match'
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

#?niecza skip 'No match'
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
#?niecza todo
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

# vim: ft=perl6
