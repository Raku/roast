use v6;

use Test;

plan 32;

=begin pod

Basic parameterized role tests, see L<S14/Roles>

=end pod

#?pugs emit skip_rest('parameterized roles'); exit;

#?pugs emit =begin SKIP

# L<S14/Run-time Mixins/may be parameterized>

# Some basic arity-based selection tests.
role AritySelection {
    method x { 1 }
}
role AritySelection[$x] {
    method x { 2 }
}
role AritySelection[$x, $y] {
    method x { 3 }
}
class AS_1 does AritySelection { }
class AS_2 does AritySelection[1] { }
class AS_3 does AritySelection[1, 2] { }
is(AS_1.new.x, 1, 'arity-based selection of role with no parameters');
is(AS_2.new.x, 2, 'arity-based selection of role with 1 parameter');
is(AS_3.new.x, 3, 'arity-based selection of role with 2 parameters');

# Make sure Foo[] works as well as Foo.
role AritySelection2[] {
    method x { 1 }
}
role AritySelection2[$x] {
    method x { 2 }
}
class AS2_1 does AritySelection2 { }
class AS2_2 does AritySelection2[] { }
class AS2_3 does AritySelection2[1] { }
is(AS2_1.new.x, 1, 'Foo[] invoked as Foo');
is(AS2_2.new.x, 1, 'Foo[] invoked as Foo[]');
is(AS2_3.new.x, 2, 'Foo[1] (for sanity)');

# Some type based choices.
class NarrownessTestA { }
class NarrownessTestB is NarrownessTestA { }
role TypeSelection[Str $x] {
    method x { 1 }
}
role TypeSelection[NarrownessTestA $x] {
    method x { 2 }
}
role TypeSelection[NarrownessTestB $x] {
    method x { 3 }
}
role TypeSelection[::T] {
    method x { 4 }
}
class TS_1 does TypeSelection["OH HAI"] { }
class TS_2 does TypeSelection[NarrownessTestB] { }
class TS_3 does TypeSelection[NarrownessTestA] { }
class TS_4 does TypeSelection[Pair] { }
is(TS_1.new.x, 1, 'type-based selection of role');
is(TS_2.new.x, 3, 'type-based selection of role (narrowness test)');
is(TS_3.new.x, 2, 'type-based selection of role (narrowness test)');
is(TS_4.new.x, 4, 'type-based selection of role (type variable)');

# Use of parameters within methods.
role MethParams[$x] {
    method x { $x }
    method y { { "42" ~ $x } }
}
class MP_1 does MethParams[1] { }
class MP_2 does MethParams['BBQ'] { }
is(MP_2.new.x,   'BBQ',   'use of type params in methods works...');
is(MP_1.new.x,   1,       '...even over many invocations.');
is(MP_2.new.y,   '42BBQ', 'params in nested scopes in methods');
is(MP_1.new.y,   '421',   'params in nested scopes in methods');

# Use of parameters with attribute initialization.
role AttrParams[$a, $b] {
    has $.x = $a;
    has $.y = $b;
}
class AP_1 does AttrParams['a','b'] { }
class AP_2 does AttrParams[1,2] { }
is(AP_2.new.x,   1,    'use of type params in attr initialization works');
is(AP_2.new.y,   2,    'use of type params in attr initialization works');
is(AP_1.new.x,   'a',  'use of type params in attr initialization works after 2nd invocation');
is(AP_1.new.y,   'b',  'use of type params in attr initialization works after 2nd invocation');

# Use of parameters as type constraints.
{
    role TypeParams[::T] {
        method x(T $x) { return "got a " ~ T.gist() ~ " it was $x" }
    }
    class TTP_1 does TypeParams[Int] { }
    class TTP_2 does TypeParams[Str] { }
    is(TTP_1.new.x(42),       'got a Int() it was 42',     'type variable in scope and accepts right value');
    is(TTP_2.new.x("OH HAI"), 'got a Str() it was OH HAI', 'type variable in scope and accepts right value');
    dies_ok({ TTP_1.new.x("OH HAI") },                   'type constraint with parameterized type enforced');
    dies_ok({ TTP_2.new.x(42) },                         'type constraint with parameterized type enforced');
}

# test multi dispatch on parameterized roles
# not really basic anymore, but I don't know where else to put these tests
{
    role MD_block[Int $x where { $x % 2 == 0 }] {
        method what { 'even' };
    }
    role MD_block[Int $x where { $x % 2 == 1 }] {
        method what { 'odd' };
    }

    class CEven does MD_block[4] { };
    class COdd  does MD_block[3] { };

    is CEven.new.what, 'even',
       'multi dispatch on parameterized role works with where-blocks (1)';
    is COdd.new.what,  'odd',
       'multi dispatch on parameterized role works with where-blocks (2)';
    is CEven.what, 'even',
       'same with class methods (1)';
    is COdd.what,  'odd',
       'same with class methods (2)';
    eval_dies_ok 'class MD_not_Int does MD_block["foo"] { }',
                 "Can't compose without matching role multi";
}

{
    role MD_generics[::T $a, T $b] {
        method what { 'same type' }
    }
    role MD_generics[$a, $b] {
        method what { 'different type' }
    }
    class CSame does MD_generics[Array, Array] { }
    class CDiff does MD_generics[Int, Hash] { }

    is CSame.new.what, 'same type',
       'MD with generics at class composition time (1)';
    is CDiff.new.what, 'different type',
       'MD with generics at class composition time (2)';

    is CSame.what, 'same type',
       'MD with generics at class composition time (class method) (1)';
    is CDiff.what, 'different type',
       'MD with generics at class composition time (class method) (2)';
    eval_dies_ok 'class WrongFu does MD_generics[3] { }',
       'MD with generics at class composition times fails (wrong arity)';
}

#?pugs emit =end SKIP

# vim: ft=perl6
