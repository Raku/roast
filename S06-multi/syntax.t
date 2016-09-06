use v6;

use Test;

plan 45;

# L<S06/Routine modifiers/>
# L<S06/Parameters and arguments/>

# multi sub with signature
multi sub foo() { "empty" }
multi sub foo($a) { "one" }    #OK not used
is(foo(), "empty", "multi sub with empty signature");
is(foo(42), "one", "multi sub with parameter list");

# multi sub without signature
multi sub bar { "empty" }
multi sub bar($a) { "one" }    #OK not used
#?niecza skip 'No candidates for dispatch to &bar'
is(bar(), "empty", "multi sub with no signature");
#?niecza skip 'Ambiguous dispatch for &bar'
is(bar(42), "one", "multi sub with parameter list");

# multi without a routine type
multi baz { "empty" }
multi baz($a) { "one" }    #OK not used
#?niecza skip 'No candidates for dispatch to &baz'
is(baz(), "empty", "multi with no signature");
#?niecza skip 'Ambiguous dispatch for &baz'
is(baz(42), "one", "multi with parameter list");

# multi without a routine type with signature
multi foobar() { "empty" }
multi foobar($a) { "one" }    #OK not used
is(foobar(), "empty", "multi with empty signature");
is(foobar(42), "one", "multi with parameter list");

# multi with some parameters not counting in dispatch (;;) - note that if the
# second parameter is counted as part of the dispatch, then invoking with 2
# ints means they are tied candidates as one isn't narrower than the other.
# (Note Int is narrower than Num - any two types where one is narrower than
# the other will do it, though.)
class T { }
class S is T { }
multi foo(S $a, T $b) { 1 }    #OK not used
multi foo(T $a, S $b) { 2 }    #OK not used
multi bar(S $a;; T $b) { 1 }    #OK not used
multi bar(T $a;; S $b) { 2 }    #OK not used
my $lived = 0;
try { foo(S,S); $lived = 1 }
is($lived, 0, "dispatch tied as expected");
#?niecza skip 'Ambiguous dispatch for &bar'
is(bar(S,S), 1, "not tied as only first type in the dispatch");

# not allowed to declare anonymous routines with only, multi or proto.
#?niecza todo
throws-like 'only sub {}', X::Anon::Multi, 'anonymous only sub is an error';
throws-like 'multi sub {}', X::Anon::Multi, 'anonymous multi sub is an error';
throws-like 'proto sub {}', X::Anon::Multi, 'anonymous proto sub is an error';
#?niecza todo
throws-like 'only {}', X::Anon::Multi, 'anonymous only is an error';
throws-like 'multi {}', X::Anon::Multi, 'anonymous multi is an error';
throws-like 'proto {}', X::Anon::Multi, 'anonymous proto is an error';
#?niecza todo
throws-like 'class A { only method {} }', X::Anon::Multi,
    'anonymous only method is an error';
throws-like 'class B { multi method {} }', X::Anon::Multi,
    'anonymous multi method is an error';
throws-like 'class C { proto method {} }', X::Anon::Multi,
    'anonymous proto method is an error';

ok(&foo ~~ Callable, 'a multi does Callable');
#?niecza todo
ok(~&foo ~~ /foo/,  'a multi stringifies sensibly');

# note - example in ticket [perl #58948] a bit more elaborate
{
    multi sub max($a, $b, $c) {return 9}    #OK not used

    lives-ok { max(1, 2, 3) }, 'use multi method to override builtin lives';
    is EVAL('max(1, 2, 3)'), 9, 'use multi method to override builtin';
}

# named and slurpy interaction - there have been bugs in the past on this front
{
    multi nsi_1(Int $x, Bool :$flag, *@vals) { "nsi 1" };    #OK not used
    is nsi_1(1),             'nsi 1', 'interaction between named and slurpy (1)';
    is nsi_1(1, 2, 3, 4, 5), 'nsi 1', 'interaction between named and slurpy (2)';

    multi nsi_2(Bool :$baz = Bool::False, *@vals) { "nsi 2" };    #OK not used
    is nsi_2(:baz(Bool::True), 1, 2, 3), 'nsi 2', 'interaction between named and slurpy (3)';
    is nsi_2(1, 2, 3),                   'nsi 2', 'interaction between named and slurpy (4)';
}

# RT #68234
{
    multi rt68234(:$key!) { 'with key' };    #OK not used
    multi rt68234(*%_)    { 'unknown' };    #OK not used
    is rt68234(:key), 'with key', 'can find multi method with key';
    is rt68234(:unknown), 'unknown', 'can find multi method with slurpy';
}

# RT #68158
{
    multi rt68158() { 1 }
    multi rt68158(*@x) { 2 }    #OK not used
    is rt68158(),  1, 'non-slurpy wins over slurpy';
    is rt68158(9), 2, 'slurpy called when non-slurpy can not bind';
}

# RT #64922
{
    multi rt64922($x, %h?) { 1 }    #OK not used
    multi rt64922(@x) { 2 }    #OK not used
    is rt64922(1),     1, 'optional parameter does not break type-based candidate sorting';
    is rt64922([1,2]), 2, 'optional parameter does not break type-based candidate sorting';
}

# RT #65672
{
    multi rt65672()   { 99 }
    multi rt65672($x) { $x }
    sub rt65672caller( &x ) { &x() }
    is rt65672caller( &rt65672 ), 99, 'multi can be passed as callable';
}

# We had a bug where the multiness leaked into a sub, so we got errors
# about anonymous methods not being allowed to be multi.
{
    multi sub kangaroo() { return method () { self * 2 } }
    my $m = kangaroo();
    is 21.$m(), 42, 'can write anonymous methods inside multi subs';
}


# RT #75136
# a multi declaration should only return the current candidate, not the whole
# set of candidates.
{
    multi sub koala(Int $x) { 42 * $x };

    my $x = multi sub koala(Str $x) { 42 ~ $x }
    is $x.candidates.elems,
        1, 'multi sub declaration returns just the current candidate';
    is $x('moep'), '42moep', 'and that candidate works';
    dies-ok { $x(23) }, '... and does not contain the full multiness';
}

multi with_cap($a) { $a }
multi with_cap($a,$b,|cap) { return with_cap($a + $b, |cap) }
is with_cap(1,2,3,4,5,6), 21, 'captures in multi sigs work';

#RT #114886 - order of declaration matters
{
    proto sub fizzbuzz($) {*};
    multi sub fizzbuzz(Int $ where * %% 15) { 'FizzBuzz' };
    multi sub fizzbuzz(Int $ where * %% 5) { 'Buzz' };
    multi sub fizzbuzz(Int $ where * %% 3) { 'Fizz' };
    multi sub fizzbuzz(Int $number) { $number };
    my $a;
    try $a = (1,3,5,15).map(&fizzbuzz).join(" ");
    is $a, <1 Fizz Buzz FizzBuzz>, "ordered multi subs";
}

# RT #68528
#?niecza skip 'Ambiguous call to &rt68528'
{
    multi rt68528(:$a!, *%_) { return "first"  };
    multi rt68528(:$b,  *%_) { return "second" };
    is(rt68528(:a, :b), "first", "RT #68528 - first defined wins the tie");
}

# RT #74900
{
    multi rt74900() { "zero" };
    multi rt74900(Int $a?) { "Int" };
    multi rt74900(Str $a?) { "Str" };
    is rt74900(), "zero", "Exact arity match wins over candidates with optionals";
    is rt74900(42), "Int", "With Int argument hit optional Int candidate";
    is rt74900("bar"), "Str", "With Str argument hit optional Str candidate";
}

{
    multi foo(Int $a) { return "first" };
    multi foo(Int $a where *.so) { return "second" }
    is foo(10), "second", "where-blocked multi has higher priority than non-where-blocked multi";
}

# vim: ft=perl6
