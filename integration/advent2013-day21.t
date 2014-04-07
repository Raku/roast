use v6;
use Test;
plan 24;

# Positionals
{
    sub greet($name) { "hello $name" }

    is greet("joe"), "hello joe";
    dies_ok {EVAL 'greet()'};
}

our sub guess($who, $what?) {
    # manually check to see if $what is defined
    $what.defined
}

dies_ok {EVAL 'guess()'};
is_deeply guess("World"), False, 'optional';
is_deeply guess("World",37), True, 'optional';

{
    sub dance($who, $dance = "Salsa") {
	$dance;
    }
    is dance("Rachael"), "Salsa", 'default';
    is dance("Rachael", "Watusi"), "Watusi", 'default';
}

{
    multi sub dance($who, $dance) {
	"$who is doing the $dance";
    }
    multi sub dance($who) {
	dance($who, "Salsa");
    }

    is dance("Rachael"), "Rachael is doing the Salsa", 'multi';
    is dance("Rachael", "Watusi"), "Rachael is doing the Watusi", 'multi';
}

# Types
{
    sub greet(Str $name) {"hello $name"}
    lives_ok {EVAL 'greet("joe")'},'type check';
    dies_ok {EVAL 'greet(3)'},'type check';
}

{
    multi odd-or-even(Int $i where * %% 2) { "even" };
    multi odd-or-even(Int $i) { "odd"};
    is odd-or-even(42), "even", 'where clause';
    is odd-or-even(37), "odd", 'where clause';
}

{
    multi fib(1) { 1 }
    multi fib(2) { 1 }
    multi fib(Int $i) { fib($i-1) + fib($i-2) }

    is fib(10), 55, 'literal arguments'
}

# Named
{
    sub doctor(:$number, :$prop) {
	"Doctor # $number liked to play with his $prop";
    }

    is doctor(:prop("cricket bat"), :number<5>),
    'Doctor # 5 liked to play with his cricket bat',
    'named';

    is doctor(:number<4>, :prop<scarf>),
    'Doctor # 4 liked to play with his scarf',
    'named';

    my $prop = "fez";
    my $number = 11;
    is doctor(:$prop, :$number),
    'Doctor # 11 liked to play with his fez',
    'named';
}

{
    sub doctor(:number($incarnation), :prop($accoutrement)) {
        "Doctor # $incarnation liked to play with his $accoutrement";
    }
    my $number = 2;
    my $prop = "recorder";
    is doctor(:$number, :$prop),
    'Doctor # 2 liked to play with his recorder',
    'named (mapped)';
    
}

# Slurpy
{
    sub Sprintf(Cool $format, *@args) {
       return $format => @args
    }
    is_deeply Sprintf("%d plus %d is %d", 37, 5, 42), ("%d plus %d is %d" => [37, 5, 42]), 'sprintf example';
}

{
    my &callwith := -> *@pos, *%named {
	@pos => %named
    };
    is_deeply callwith(10, 20, :a(30), :b(40)),
    [10,20] => {a => 30, b => 40},
    'pointy block syntax';
}

# Methods
{
    class Foo {
	method explode($self: $method) {
	    [$self, $method];
	}
    }

    my $obj = Foo.new;
    my $r = $obj.explode(42);
    is_deeply $r, [$obj, 42], 'method invocant';
}

# Parameter Traits
{
    my $a = 35;
    sub tst-ro($p is readonly) {$p = 42;}
    dies_ok {EVAL 'test-ro($a)'}, 'readonly trait';
}
{    
    my $a = 35;
    sub tst-rw($p is rw) {$p = 42;}
    tst-rw($a);
    is $a, 42, 'rw trait';
}
{
    my $a = 35;
    sub tst-ro($p is copy) {$p = 42;}
    is $a, 35, 'copy trait';
}
