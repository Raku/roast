use v6;

use Test;

plan 18;

=begin pod

Basic parameterized role tests, see L<S12/Roles>

=end pod

#?pugs emit skip_rest('parameterized roles'); exit;
#?pugs emit =begin SKIP

# L<S12/Roles/to be considered part of the long name:>

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
role TypeSelection[Str $x] {
    method x { 1 }
}
role TypeSelection[Num $x] {
    method x { 2 }
}
role TypeSelection[Int $x] {
    method x { 3 }
}
role TypeSelection[::T] {
    method x { 4 }
}
class TS_1 does TypeSelection["OH HAI"] { }
class TS_2 does TypeSelection[42] { }
class TS_3 does TypeSelection[4.2] { }
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

#?pugs emit =end SKIP

# vim: ft=perl6
