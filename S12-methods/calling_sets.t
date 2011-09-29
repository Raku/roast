use Test;
plan 32;

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

    is $c.*bar(), Nil, '.* on undefined method gives Nil';

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

    dies_ok { $c."?foo"() }, '? at start of dynamic name does not imply .?';

    dies_ok { $c."+foo"() }, '+ at start of dynamic name does not imply .+';

    dies_ok { $c."*foo"() }, '* at start of dynamic name does not imply .*';
}


# Some tests involiving .?, .+ and .* with multi-methods.
class D {
    has $.cnt is rw;
    multi method foo() { $.cnt++ }
    multi method foo(Int $x) { $.cnt++ }   #OK not used
    multi method foo($x) { $.cnt++ }   #OK not used
}
class E is D {
    multi method foo() { $.cnt++ }
    multi method foo($x) { $.cnt++ }   #OK not used
}

#?rakudo skip 'ambiguous dispatch'
{
    my $e = E.new();

    $e.cnt = 0;
    $e.foo();
    is $e.cnt, 1, 'dispatch to one sanity test';

    $e.cnt = 0;
    $e.?foo();
    is $e.cnt, 1, '.? calls first matching multi method';

    $e.cnt = 0;
    $e.*foo();
    is $e.cnt, 2, '.* calls up inheritance hierarchy and all possible multis';

    $e.cnt = 0;
    $e.*foo(2.5);
    is $e.cnt, 2, '.* calls up inheritance hierarchy and all possible multis';

    $e.cnt = 0;
    $e.*foo(2);
    is $e.cnt, 3, '.* calls up inheritance hierarchy and all possible multis';

    $e.cnt = 0;
    $e.+foo();
    is $e.cnt, 2, '.+ calls up inheritance hierarchy and all possible multis';

    $e.cnt = 0;
    $e.+foo(2.5);
    is $e.cnt, 2, '.+ calls up inheritance hierarchy and all possible multis';

    $e.cnt = 0;
    $e.+foo(2);
    is $e.cnt, 3, '.+ calls up inheritance hierarchy and all possible multis';

    is $e.?foo("lol", "no", "match"), Nil, '.? when no possible multis gives Nil';

    my $lived = 0;
    try { $e.+foo("lol", "no", "match"); $lived = 1; }
    is $lived, 0, '.+ with no matching multis is an error';

    is ($e.*foo("lol", "no", "match")).elems, 0, '.* when no possible multis gives empty list';
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
    my @list =  MMT1.new.?nonexistent();
    is +@list, 0, '.?nonexisent() returns Nil';
}

eval_dies_ok '1.*WHAT', '.WHAT is a macro and cannoted be .*ed';

# vim: ft=perl6
