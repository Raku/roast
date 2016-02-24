use v6;
use Test;
plan 38;

# L<S12/"Calling sets of methods">

# Some basic tests with only single-dispatch in operation.
class A {
    has $.cnt is rw;
    method foo { $.cnt += 4 }
}
class B is A {
    method foo { $.cnt += 2 }
}
class C is B {
    method foo { $.cnt += 1 }
}

{
    my $c = C.new();

    $c.cnt = 0;
    $c.?foo();
    is $c.cnt, 1, '.? calls first matching method';

    $c.cnt = 0;
    $c.*foo();
    is $c.cnt, 7, '.* calls up inheritance hierarchy';

    $c.cnt = 0;
    $c.+foo();
    is $c.cnt, 7, '.+ calls up inheritance hierarchy';

    is $c.?bar(), Nil,  '.? on undefined method gives Nil';

    my $lived = 0;
    try { $c.+bar(); $lived = 1; }
    is $lived, 0, '.+ on undefined method is an error';

    is-deeply $c.*bar(), (), '.* on undefined method gives Nil';

    my $foo = "foo";

    $c.cnt = 0;
    $c.?"$foo"();
    is $c.cnt, 1, '.? with dynamic method name';

    $c.cnt = 0;
    $c.*"$foo"();
    is $c.cnt, 7, '.* with dynamic method name';

    $c.cnt = 0;
    $c.+"$foo"();
    is $c.cnt, 7, '.+ with dynamic method name';

    dies-ok { $c."?foo"() }, '? at start of dynamic name does not imply .?';

    dies-ok { $c."+foo"() }, '+ at start of dynamic name does not imply .+';

    dies-ok { $c."*foo"() }, '* at start of dynamic name does not imply .*';
}


# Some tests involiving .?, .+ and .* with multi-methods. Since .+ and
# .* are only about single dispatch, then we end up calling the proto
# available at each inheritance level.
class D {
    multi method foo() { 'd' }
    multi method foo(Int $x) { 'dInt' }   #OK not used
    multi method foo($x) { 'dAny' }   #OK not used
}
class E is D {
    multi method foo() { 'e' }
    multi method foo(Int $x) { 'eInt' }   #OK not used
    multi method foo($x, $y, $z) { 'eAnyAnyAny' }   #OK not used
}

# RT #119193
{
    my $e = E.new();

    is $e.foo(), 'e', 'dispatch to one sanity test';
    is $e.foo(2.5), 'dAny', 'dispatch to one inherited sanity test';
    dies-ok { $e.foo('omg', 'fail') }, 'dispatch to one with no matching multi (sanity test)';

    is $e.?foo(), 'e', '.? gets same result as . if there is a multi (match)';
    is $e.?foo(2.5), 'dAny', '.? gets same result as . if there is a multi (inherited)';
    dies-ok { is $e.?foo('omg', 'fail') }, '.? gets same result as . if there is a multi (no match)';

    is $e.*foo(), <e d>, '.* calls multis up inheritance hierarchy';
    is $e.*foo(2.5), <dAny dAny>, '.* behaves as single dispatch at each step';
    dies-ok { $e.*foo(1, 2, 3) }, '.* dies if there is no matching multi in a base class';

    is $e.*foo(), <e d>, '.* calls multis up inheritance hierarchy';
    is $e.*foo(2.5), <dAny dAny>, '.* behaves as single dispatch at each step';
    dies-ok { $e.*foo(Mu) }, '.* dies if there is no matching multi in subclass';
    dies-ok { $e.*foo(1, 2, 3) }, '.* dies if there is no matching multi in a base class';

    is $e.+foo(), <e d>, '.* calls multis up inheritance hierarchy';
    is $e.+foo(2.5), <dAny dAny>, '.* behaves as single dispatch at each step';
    dies-ok { $e.+foo(Mu) }, '.* dies if there is no matching multi in subclass';
    dies-ok { $e.+foo(1, 2, 3) }, '.* dies if there is no matching multi in a base class';
}

# Some tests to make sure we walk methods from roles too.
role R1 {
    multi method mm { $.cnt += 1 }
    multi method sm { $.cnt += 2 }
}
role R2 {
    multi method mm { $.cnt += 3 }
}
class F does R1 {
    has $.cnt is rw;
}
class G is F does R2 {
}

{
    my $g = G.new();

    $g.cnt = 0;
    $g.?sm();
    is $g.cnt, 2, 'single dispatch method from role found with .?';

    $g.cnt = 0;
    $g.+sm();
    is $g.cnt, 2, 'single dispatch method from role found with .+';

    $g.cnt = 0;
    $g.*sm();
    is $g.cnt, 2, 'single dispatch method from role found with .*';

    $g.cnt = 0;
    $g.?mm();
    is $g.cnt, 3, 'multi dispatch method from role found with .?';

    $g.cnt = 0;
    $g.+mm();
    is $g.cnt, 4, 'multi dispatch method from role found with .+';

    $g.cnt = 0;
    $g.*mm();
    is $g.cnt, 4, 'multi dispatch method from role found with .*';
}

class MMT1 {
    multi method foo($x) { 42 }   #OK not used
}
class MMT2 is MMT1 {
    multi method foo(Int $x) { "oh noes" }   #OK not used
}
is MMT2.new.?foo("lol"), 42, '.? when initial multi does not match will find next one up';

{
    isa-ok MMT1.new.?nonexistent(), Nil, '.?nonexisent() returns Nil';
}

throws-like '1.*WHAT', Exception, '.WHAT is a macro and cannoted be .*ed';

# vim: ft=perl6
