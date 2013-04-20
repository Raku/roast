use v6;

use Test;

plan 15;

# L<S12/"Construction and Initialization">

class OwnConstr {
    has $.x = 13;
    my $in_own = 0;
    method own() {
        $in_own++;
        return self.bless(self.CREATE(), :x(42));
    }
    method in_own {
        $in_own;
    }
}
ok OwnConstr.new ~~ OwnConstr, "basic class instantiation";
is OwnConstr.new.x, 13,        "basic attribute access";
# As usual, is instead of todo_is to suppress unexpected succeedings
is OwnConstr.in_own, 0,                   "own constructor was not called";

ok OwnConstr.own ~~ OwnConstr, "own construction instantiated its class";
is OwnConstr.own.x, 42,        "attribute was set from our constructor";
is OwnConstr.in_own, 2,        "own constructor was actually called";


# L<"http://www.mail-archive.com/perl6-language@perl.org/msg20241.html">
# provide constructor for single positional argument

class Foo {
  has $.a;
  
  method new ($self: Str $string) {
    $self.bless(*, a => $string);
  }
}


ok Foo.new("a string") ~~ Foo, '... our Foo instance was created';

#?pugs todo 'feature'
is Foo.new("a string").a, 'a string', "our own 'new' was called";


# Using ".=" to create an object
{
  class Bar { has $.attr }
  my Bar $bar .= new(:attr(42));
  is $bar.attr, 42, "instantiating an object using .= worked (1)";
}
# Using ".=()" to create an object
{ 
  class Fooz { has $.x }
  my Fooz $f .= new(:x(1));
  is $f.x, 1, "instantiating an object using .=() worked";
}

{
  class Baz { has @.x is rw }
  my Baz $foo .= new(:x(1,2,3));
  lives_ok -> { $foo.x[0] = 3 }, "Array initialized in auto-constructor is not unwritable...";
  is $foo.x[0], 3, "... and keeps its value properly."
}	

# RT #64116
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
{
    class RT64116 { has %.env is rw };

    my $a = RT64116.CREATE;

    lives_ok { $a.env = { foo => "bar" } }, 'assign to attr of .CREATEd class';
    is $a.env<foo>, 'bar', 'assignment works';
}

# RT #76476
{
    use MONKEY_TYPING;
    class MonkeyNew { has $.x is rw };
    augment class MonkeyNew {
        method new() {
            self.bless(*, :x('called'));
        }
    };
    is MonkeyNew.new().x, 'called', 'monkey-typed .new() method is called';
}

# vim: ft=perl6
