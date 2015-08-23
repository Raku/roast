use v6;

use Test;

plan 97;

# Lots of the same tests from this directory run again with
# the parameters in a subsignature.

# from by-trait.t
# RT 66588
{
    my $ro_call = 0;
    my $rw_call = 0;
    multi sub uno_mas(|c( Int $ro       )) { $ro_call++; return 1 + $ro }
    multi sub uno_mas(|c( Int $rw is rw )) { $rw_call++; return ++$rw }

    is uno_mas(42), 43, 'multi works with constant';
    is $ro_call, 1, 'read-only multi was called';

    my $x = 99;
    #?niecza skip 'Ambiguous dispatch for &uno_mas'
    is uno_mas( $x ), 100, 'multi works with variable';
    #?niecza todo
    #?rakudo todo 'Calls wrong candidate'
    is $x, 100, 'variable was modified';
    #?niecza todo
    #?rakudo todo 'Calls wrong candidate'
    is $rw_call, 1, 'read-write multi was called';
}

# lexical-multis.t (has not many interesting tests for this purpose)

# lexical multi can add to package multi if no outer lexical ones
multi waz(|c ()) { 1 }
{
    my multi waz(|c ($x)) { 2 }   #OK not used
    is(waz(),       1, 'got multi from package');
    is(waz('slon'), 2, 'lexical multi also callable');
}
is(waz(), 1,             'multi from package still callable outside the inner scope...');
dies-ok { EVAL("waz('vtak')") }, '...but lexical multi no longer callable';


# positional-vs-named.t

# check the subroutine with the closest matching signature is called
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

# the single parameter cases named and positional below - part of RT 53814

multi earth (|c(:$me!))                 {"me $me"};
multi earth (|c(:$him!))                {"him $him"};
multi earth (|c(:$me!, :$him!))         {"me $me him $him"};
multi earth (|c(:$me!, :$him!, :$her!)) {"me $me him $him her $her"};
multi earth (|c($me))                   {"pos $me"};
multi earth (|c($me, :$you!))           {"pos $me you $you"};
multi earth (|c($me, :$her!))           {"pos $me her $her"};
multi earth (|c($me, $you))             {"pos $me pos $you"};
multi earth (|c($me, $you, :$her!))     {"pos $me pos $you her $her"};

is( earth(me => 1),                     'me 1',             'named me');
is( earth(him => 2),                    'him 2',            'named you');
is( earth(me => 1, him => 2),           'me 1 him 2',       'named me, named him');
is( earth(him => 2, me => 1),           'me 1 him 2',       'named him, named me');
is( earth(me => 1, him => 2, her => 3), 'me 1 him 2 her 3', 'named me named him named her');
is( earth(him => 2, me => 1, her => 3), 'me 1 him 2 her 3', 'named him named me named her');
is( earth(her => 3, me => 1, him => 2), 'me 1 him 2 her 3', 'named her named me named him');
is( earth(her => 3, him => 2, me => 1), 'me 1 him 2 her 3', 'named her named him named me');

is( earth('b', you => 4),      'pos b you 4',       'pos, named you');
is( earth('c', her => 3),      'pos c her 3',       'pos, named her');
is( earth('d', 'e'),           'pos d pos e',       'pos, pos');
is( earth('f', 'g', her => 3), 'pos f pos g her 3', 'pos, pos, named');

# ensure we get the same results when the subroutines are
# defined in reverse order

multi wind (|c($me, $you, :$her!))     {"pos $me pos $you her $her"};
multi wind (|c($me, $you))             {"pos $me pos $you"};
multi wind (|c($me, :$her!))           {"pos $me her $her"};
multi wind (|c($me, :$you!))           {"pos $me you $you"};
multi wind (|c(:$me!, :$him!, :$her!)) {"me $me him $him her $her"};
multi wind (|c(:$me!, :$him!))         {"me $me him $him"};
multi wind (|c(:$him))                 {"him $him"};
multi wind (|c(:$me))                  {"me $me"};

is( wind(me => 1),                     'me 1',             'named me');
is( wind(him => 2),                    'him 2',            'named you');
is( wind(me => 1, him => 2),           'me 1 him 2',       'named me, named him');
is( wind(him => 2, me => 1),           'me 1 him 2',       'named him, named me');
is( wind(me => 1, him => 2, her => 3), 'me 1 him 2 her 3', 'named me named him named her');
is( wind(him => 2, me => 1, her => 3), 'me 1 him 2 her 3', 'named him named me named her');
is( wind(her => 3, me => 1, him => 2), 'me 1 him 2 her 3', 'named her named me named him');
is( wind(her => 3, him => 2, me => 1), 'me 1 him 2 her 3', 'named her named him named me');

is( wind('b', you => 4),      'pos b you 4',       'pos, named you');
is( wind('c', her => 3),      'pos c her 3',       'pos, named her');
is( wind('d', 'e'),           'pos d pos e',       'pos, pos');
is( wind('f', 'g', her => 3), 'pos f pos g her 3', 'pos, pos, named');

{
    # a nom bug
    multi catch(|c(*@all            )) { 1 }   #OK not used
    multi catch(|c(*@all, :$really! )) { 2 }   #OK not used
    is catch(0, 5),           1, 'slurpy and named interact well (1)';
    is catch(0, 5, :!really), 2, 'slurpy and named interact well (2)';
}

# RT #78738
{
    multi zero(|c())       { 'no args' };
    multi zero(|c(:$foo!)) { 'named'   };
    is zero(), 'no args',
        'presence of mandatory named multi does not corrupt calling a nullary'
}

# proto.t

class A { }
class B { }
proto foo(|c($x)) { * }    #OK not used
multi foo(|c(A $x)) { 2 }  #OK not used
multi foo(|c(B $x)) { 3 }  #OK not used
multi foo(|c($x))   { 1 }  #OK not used
is(foo(A.new), 2, 'dispatch on class worked');
is(foo(B.new), 3, 'dispatch on class worked');
is(foo(42),    1, 'dispatch with no possible candidates fell back to proto');

#?rakudo skip "redeclaration of routine 'bar' RT #118069"
#?niecza skip "Illegal redeclaration of routine 'bar'"
{
    # Test that proto makes all further subs in the scope also be multi.
    proto bar(|c()) { "proto" }
    sub bar(|c($x)) { 1 }    #OK not used
    multi bar(|c($x, $y)) { 2 }    #OK not used
    multi sub bar(|c($x, $y, $z)) { 3 }    #OK not used
    sub bar(|c($x, $y, $z, $a)) { 4 }    #OK not used
    is bar(),  "proto", "called the proto";#
    is bar(1),       1, "sub defined without multi has become one";
    is bar(1,2),     2, "multi ... still works, though";
    is bar(1,2,3),   3, "multi sub ... still works too";
    is bar(1,2,3,4), 4, "called another sub as a multi candidate, made a multi by proto";
}

# L<S03/"Reduction operators">
{
    proto prefix:<[+]> (|c(*@args)) {
        my $accum = 0;
        $accum += $_ for @args;
        return $accum * 2; # * 2 is intentional here
    }

    #?rakudo todo 'operator protos'
    #?niecza todo
    is ([+] 1,2,3), 12, "[+] overloaded by proto definition";
}

# more similar tests
{
    proto prefix:<moose> (|c($arg)) { $arg + 1 }
    is (moose 3), 4, "proto definition of prefix:<moose> works";
}

#?niecza skip '>>>Stub code executed'
{
    proto prefix:<elk> (|c($arg)) { * }
    multi prefix:<elk> (|c($arg)) { $arg + 1 }
    is (elk 3), 4, "multi definition of prefix:<elk> works";
}

eval-dies-ok 'proto rt68242(|c($a)){};proto rt68242(|c($c,$d)){};',
    'attempt to define two proto subs with the same name dies';

# RT #65322
{
    my $rt65322 = q[
        multi sub rt65322(|c( Int $n where 1 )) { 1 }
              sub rt65322(|c( Int $n )) { 2 }
    ];
    eval-dies-ok $rt65322, "Can't define sub and multi sub without proto";
}

# RT #111454
#?niecza skip "System.NullReferenceException: Object reference not set to an instance of an object"
{
    my package Cont {
        our proto sub ainer(|c($)) {*}
        multi sub ainer(|c($a)) { 2 * $a };
    }
    is Cont::ainer(21), 42, 'our proto can be accessed from the ouside';
}

#?niecza skip 'Unhandled exception: Cannot use value like Block as a number'
{
    my proto f(|c($)) {
        2 * {*} + 5
    }
    multi f(|c(Str)) { 1 }
    multi f(|c(Int)) { 3 }

    is f('a'), 7, 'can use {*} in an expression in a proto (1)';
    is f(1),  11, 'can use {*} in an expression in a proto (2)';

    # RT #114882
    my $called_with = '';
    proto cached(|c($a)) {
        state %cache;
        %cache{$a} //= {*}
    }
    multi cached(|c($a)) {
        $called_with ~= $a;
        $a x 2;
    }
    is cached('a'), 'aa', 'caching proto (1)';
    is cached('b'), 'bb', 'caching proto (2)';
    is cached('a'), 'aa', 'caching proto (3)';
    is $called_with, 'ab', 'cached value did not cause extra call';

    proto maybe(|c($a)) {
        $a > 0 ?? {*} !! 0;
    }
    multi maybe(|c($a)) { $a };

    is maybe(8),  8, 'sanity';
    is maybe(-5), 0, "It's ok not to dispatch to the multis";
}

# RT #116164
#?niecza todo
{
    eval-dies-ok q[
        proto f(|c(Int $x)) {*}; multi f(|c($)) { 'default' }; f 'foo'
    ], 'proto signature is checked, not just that of the candidates';
}

# RT#125732
{
    my $tracker = '';
    multi a(|c($))     { $tracker ~= 'Any' };
    multi a(|c(Int $)) { $tracker ~= 'Int'; nextsame; $tracker ~= 'Int' };

    lives-ok { a(3) },      'can call nextsame inside a multi sub';
    #?rakudo todo 'Multimethod sort does not descend into subsignatures'
    is $tracker, 'IntAny', 'called in the right order';
}

# RT#125732
{
    my $tracker = '';
    multi b(|c($))     { $tracker ~= 'Any' };
    multi b(|c(Int $)) { $tracker ~= 'Int'; callsame; $tracker ~= 'Int' };

    lives-ok { b(3) },        'can call callsame inside a multi sub';
    #?rakudo todo 'Multimethod sort does not descend into subsignatures'
    is $tracker, 'IntAnyInt', 'called in the right order';
}

# RT#125732
{
    my $tracker = '';
    multi c(|c($x))     { $tracker ~= 'Any' ~ $x };
    multi c(|c(Int $x)) { $tracker ~= 'Int'; nextwith($x+1); $tracker ~= 'Int' };

    lives-ok { c(3) },      'can call nextwith inside a multi sub';
    #?rakudo todo 'Multimethod sort does not descend into subsignatures'
    is $tracker, 'IntAny4', 'called in the right order';
}

# RT#125732
{
    my $tracker = '';
    multi d(|c($x))     { $tracker ~= 'Any' ~ $x };
    multi d(|c(Int $x)) { $tracker ~= 'Int'; callwith($x+1); $tracker ~= 'Int' };

    lives-ok { d(3) },         'can call callwith inside a multi sub';
    #?rakudo todo 'Multimethod sort does not descend into subsignatures'
    is $tracker, 'IntAny4Int', 'called in the right order';
}

# RT #75008
{
    multi e(|c()) { nextsame };
    lives-ok &e, "It's ok to call nextsame in the last/only candidate";
}

# RT 125539
{
    multi a(|c(Int $a)) { samewith "$a" }
    multi a(|c(Str $a)) { is $a, "42", 'samewith $a stringified in sub' }

    class C {
        multi method b(|c(Int $b)) { samewith "$b" }
        multi method b(|c(Str $b)) {
            is $b, "42", 'samewith $b stringified for ' ~ self.perl;
        }
    }

    a 42;
    C.b(42);
    C.new.b(42);
}

{
    multi foo($n) {
        { $n ?? $n * samewith($n - 1) !! 1 }()
    }
    is foo(5), 120, 'samewith works from inside a nested closure';
}

# syntax.t

# multi sub with signature
multi sub footoo(|c()) { "empty" }
multi sub footoo(|c($a)) { "one" }    #OK not used
is(footoo(), "empty", "multi sub with empty signature");
is(footoo(42), "one", "multi sub with parameter list");

# multi without a routine type with signature
multi foobar(|c()) { "empty" }
multi foobar(|c($a)) { "one" }    #OK not used
is(foobar(), "empty", "multi with empty signature");
is(foobar(42), "one", "multi with parameter list");

# multi with some parameters not counting in dispatch (;;) - note that if the
# second parameter is counted as part of the dispatch, then invoking with 2
# ints means they are tied candidates as one isn't narrower than the other.
# (Note Int is narrower than Num - any two types where one is narrower than
# the other will do it, though.)
class T { }
class S is T { }
multi foo(|c(S $a, T $b)) { 1 }    #OK not used
multi foo(|c(T $a, S $b)) { 2 }    #OK not used
multi bar(|c(S $a;; T $b)) { 1 }    #OK not used
multi bar(|c(T $a;; S $b)) { 2 }    #OK not used
my $lived = 0;
try { foo(S,S); $lived = 1 }
is($lived, 0, "dispatch tied as expected");
#?niecza skip 'Ambiguous dispatch for &bar'
is(bar(S,S), 1, "not tied as only first type in the dispatch");

# note - example in ticket [perl #58948] a bit more elaborate
{
    multi sub max(|c($a, $b, $c)) {return 9}    #OK not used

    lives-ok { max(1, 2, 3) }, 'use multi method to override builtin lives';
    is EVAL('max(1, 2, 3)'), 9, 'use multi method to override builtin';
}

# named and slurpy interaction - there have been bugs in the past on this front
{
    multi nsi_1(|c(Int $x, Bool :$flag, *@vals)) { "nsi 1" };    #OK not used
    is nsi_1(1),             'nsi 1', 'interaction between named and slurpy (1)';
    is nsi_1(1, 2, 3, 4, 5), 'nsi 1', 'interaction between named and slurpy (2)';

    multi nsi_2(|c(Bool :$baz = Bool::False, *@vals)) { "nsi 2" };    #OK not used
    is nsi_2(:baz(Bool::True), 1, 2, 3), 'nsi 2', 'interaction between named and slurpy (3)';
    is nsi_2(1, 2, 3),                   'nsi 2', 'interaction between named and slurpy (4)';
}

# RT #68234
{
    multi rt68234(|c(:$key!)) { 'with key' };    #OK not used
    multi rt68234(|c(*%_))    { 'unknown' };    #OK not used
    is rt68234(:key), 'with key', 'can find multi method with key';
    is rt68234(:unknown), 'unknown', 'can find multi method with slurpy';
}

# RT #68158
{
    multi rt68158(|c()) { 1 }
    multi rt68158(|c(*@x)) { 2 }    #OK not used
    is rt68158(),  1, 'non-slurpy wins over slurpy';
    is rt68158(9), 2, 'slurpy called when non-slurpy can not bind';
}

# RT #64922
# RT #125732
{
    multi rt64922(|c($x, %h?)) { 1 }    #OK not used
    multi rt64922(|c(@x)) { 2 }    #OK not used
    is rt64922(1),     1, 'optional parameter does not break type-based candidate sorting';
    #?rakudo todo 'Multimethod sort does not descend into subsignatures'
    is rt64922([1,2]), 2, 'optional parameter does not break type-based candidate sorting';
}

# RT #65672
{
    multi rt65672(|c())   { 99 }
    multi rt65672(|c($x)) { $x }
    sub rt65672caller( &x ) { &x() }
    is rt65672caller( &rt65672 ), 99, 'multi can be passed as callable';
}

# RT #75136
# a multi declaration should only return the current candidate, not the whole
# set of candidates.
{
    multi sub koala(|c(Int $x)) { 42 * $x };

    my $x = multi sub koala(|c(Str $x)) { 42 ~ $x }
    is $x.candidates.elems,
        1, 'multi sub declaration returns just the current candidate';
    is $x('moep'), '42moep', 'and that candidate works';
    dies-ok { $x(23) }, '... and does not contain the full multiness';
}

multi with_cap(|c($a)) { $a }
multi with_cap(|c($a,$b,|cap)) { return with_cap($a + $b, |cap) }
is with_cap(1,2,3,4,5,6), 21, 'captures in multi sigs work';

#RT #114886 - order of declaration matters
{
    proto sub fizzbuzz($) {*};
    multi sub fizzbuzz(|c(Int $ where * %% 15)) { 'FizzBuzz' };
    multi sub fizzbuzz(|c(Int $ where * %% 5)) { 'Buzz' };
    multi sub fizzbuzz(|c(Int $ where * %% 3)) { 'Fizz' };
    multi sub fizzbuzz(|c(Int $number)) { $number };
    my $a;
    try $a = (1,3,5,15).map(&fizzbuzz).join(" ");
    is $a, <1 Fizz Buzz FizzBuzz>, "ordered multi subs";
}

# RT #68528
#?niecza skip 'Ambiguous call to &rt68528'
{
    multi rt68528(|c(:$a!, *%_)) { return "first"  };
    multi rt68528(|c(:$b,  *%_)) { return "second" };
    is(rt68528(:a, :b), "first", "RT #68528 - first defined wins the tie");
}

# vim: ft=perl6
