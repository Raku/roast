use v6;

use Test;

plan 66;

=begin desc

Delegation tests from L<S12/Delegation>

=end desc

# L<S12/Delegation>

class Backend1 {
    method hi() { 42 };
    method cool() { 1337 };
    method with_params($x) { $x xx 2 };
}
role Backend2 { method hi() { 23 }; method cool() {  539 } }
class Frontend { has $.backend is rw handles "hi" }
class Frontend2 { has $.backend handles <with_params> };
ok Backend1.new, "class definition worked";

is Backend1.new.hi, 42, "basic sanity (1)";
is Backend2.new.hi, 23, "basic sanity (2)";

{
  my $a;
  ok ($a = Frontend.new), "basic instantiation worked (1)";
  dies_ok { $a.hi }, "calling a method on no object didn't succeed (1)";
  ok ($a.backend = Backend1.new()), "setting a handler object (1)";
  ok (!($a ~~ Backend1)), "object wasn't isa()ed (1)";
  #?pugs skip 'no such method hi'
  is $a.hi, 42, "method was successfully handled by backend object (1)";
}

{
  my $a;
  ok ($a = Frontend.new), "basic instantiation worked (2)";
  dies_ok { $a.hi }, "calling a method on no object didn't succeed (2)";
  ok ($a.backend = Backend2.new()), "setting a handler object (2)";
  ok (!($a ~~ Backend2)), "object wasn't isa()ed (2)";
  #?pugs skip 'no such method hi'
  is $a.hi, 23, "method was successfully handled by backend object (2)";
}

#?pugs skip 'no such method with_params'
{
    my $a = Frontend2.new( backend => Backend1.new() );
    is $a.with_params('abc'), ('abc' xx 2), 'Delegation works with parameters';
}

# L<S12/Delegation/You can specify multiple method names:>
class MultiFrontend { has $.backend is rw handles <hi cool> }
ok MultiFrontend.new, "class definition using multiple method names worked";
{
  my $a;
  ok ($a = MultiFrontend.new), "basic instantiation worked (5)";
  dies_ok { $a.hi   }, "calling a method on no object didn't succeed (5-1)";
  dies_ok { $a.cool }, "calling a method on no object didn't succeed (5-2)";
  ok ($a.backend = Backend1.new()), "setting a handler object (5)";
  ok (!($a ~~ Backend1)),             "object wasn't isa()ed (5)";
  #?pugs skip 'no such method hi'
  is ($a.hi),     42, "method was successfully handled by backend object (5-1)";
  #?pugs skip 'no such method cool'
  is ($a.cool), 1337, "method was successfully handled by backend object (5-2)";
}

# L<S12/Delegation/you put a pair>
class PairTest {
    has $.backend1 is rw handles :hello<hi>;
    has $.backend2 is rw handles (:ahoj<hi>, :w00t('cool'));
}
{
    my $a = PairTest.new;
    $a.backend1 = Backend1.new();
    $a.backend2 = Backend2.new();
    dies_ok { $a.hi   }, "calling method with original name fails";
    dies_ok { $a.cool }, "calling method with original name fails";
    #?pugs 3 skip 'no such method'
    is $a.hello, 42, "calling method with mapped name works";
    is $a.ahoj, 23, "calling method with mapped name works";
    is $a.w00t, 539, "calling method with mapped name works";
}

# L<S12/Delegation/If you say>
{
  class ClassFrontend { has $.backend is rw handles Backend2 };
  ok ClassFrontend.new, "class definition using a Class handle worked";
  {
    my $a;
    ok ($a = ClassFrontend.new), "basic instantiation worked (4)";
    dies_ok { $a.hi }, "calling a method on no object didn't succeed (4)";
    ok ($a.backend = Backend1.new()), "setting a handler object (4)";
    ok (!($a ~~ Backend1)),             "object wasn't isa()ed (4-1)";
    ok (!($a ~~ Backend2)),             "object wasn't isa()ed (4-2)";
    #?pugs skip 'no such method'
    is $a.hi, 42, "method was successfully handled by backend object (4)";
  }
}
{
    role R1 { method awesome { "yeah!" } }
    class Backend3 does R1 { method sucks { "boo" } }
    class RoleFrontend { has $.backend is rw handles R1; }
    my $a = RoleFrontend.new();
    ok !$a.does(R1), "having a handles role doesn't make the class do the role";
    dies_ok { $a.awesome }, "calling a method on no object didn't succeed";
    $a.backend = Backend3.new();
    #?pugs skip 'no such method'
    is $a.awesome, "yeah!", "method in role was successfully handled by backend object";
    dies_ok { $a.sucks }, "but method in backend class but not role not handled";
}

# L<S12/Delegation/"Any other kind of argument" "smartmatch selector for method">
{
  class ReFrontend { has $.backend is rw handles /^hi|oo/ };
  ok ReFrontend.new, "class definition using a smartmatch handle worked";
 
  {
    my $a;
    ok ($a = ReFrontend.new), "basic instantiation worked (3)";
    dies_ok { $a.hi }, "calling a method on no object didn't succeed (3)";
    ok ($a.backend = Backend1.new()), "setting a handler object (3)";
    ok (!($a ~~ Backend1)),             "object wasn't isa()ed (3)";
    #?pugs 2 skip 'no such method'
    is $a.hi, 42, "method was successfully handled by backend object (3)";
    is $a.cool, 1337, "method was successfully handled by backend object (3)";
  }
}
{
    class WorrevaFrontend {
        has $.backend is rw handles *;
        has $.backend2 is rw handles *;
        method test { 1 }
        method hi { 2 }
    }
    ok WorrevaFrontend.new, "class definition using a smartmatch on * worked";
    my $a = WorrevaFrontend.new();
    $a.backend = Backend1.new();
    $a.backend2 = Backend2.new();
    is $a.test, 1, "didn't try to delegate method in the class even with handles *...";
    is $a.hi, 2, "...even when it exists in the target class";
    #?pugs skip 'no such method'
    is $a.cool, 1337, "...but otherwise it delegates, and first * wins";
}

# delegation with lvalue routines
{
    class BackendRw {
        has $.a is rw;
        has $.b is rw;
        has $.c;
    }
    class FrontendRw {
        has BackendRw $.backend handles <a b c>;
        submethod BUILD {
            $!backend = BackendRw.new();
        }
    }
    my $t = FrontendRw.new();
    #?pugs todo
    lives_ok { $t.a = 'foo' }, 'can assign to lvalue delegated attribute';
    dies_ok  { $t.c = 'foo' }, '... but only to lvaues attributes';
    #?pugs skip 'no such method'
    is $t.a, 'foo', 'assignment worked';
    #?pugs todo
    is $t.backend.a, 'foo', 'can also query that through the backend';
    #?pugs skip 'no such method'
    nok $t.c.defined, 'died assignment had no effect';
}

# arrays, hashes
#?pugs skip "Can't modify constant item: VUndef"
{
    class PseudoArray {
        has @!data handles <Str push pop elems shift unshift>;
    }
    my $x = PseudoArray.new();
    $x.push: 3, 4;
    $x.push: 6;
    is ~$x, '3 4 6',    'delegation of .Str and .push to array attribute';
    $x.pop;
    is ~$x, '3 4',      'delegation of .pop';
    $x.unshift('foo');
    is ~$x, 'foo 3 4',  'delegation of .unshift';
    is $x.shift, 'foo', 'delegation of .shift (1)';
    is ~$x, '3 4',      'delegation of .shift (2)';
    is $x.elems, 2,     'delegation of .elems';
}

#?pugs skip "Can't modify constant item: VUndef"
{
    class PseudoHash { has %!data handles <push Str> };
    my $h = PseudoHash.new;
    $h.push: 'a' => 5;
    is $h.Str, ~{a => 5}, 'delegation of .Str and .push to hash';
}

{
    class TypePseudoHash { has %!data handles Hash }
    my $h = TypePseudoHash.new;
    $h<a> = 'c';
    $h<b> = 'd';
    is $h<a b>.join('|'), 'c|d', 'can do handles + type object (1)';
}

#?pugs skip "Can't modify constant item: VUndef"
{
    role OtherRole {
        method c() { 3 }
    }
    role RBackend does OtherRole {
        method a() { 1 }
        method b() { 2 }
    }
    class PunnedRBackend does RBackend { };

    class RFrontend {
        has $!backend handles RBackend = PunnedRBackend.new;
    }

    my $a = RFrontend.new;
    is $a.a(), 1, 'got all methods via "handles $typeObject" (1)';
    is $a.b(), 2, 'got all methods via "handles $typeObject" (2)';
    is $a.c(), 3, 'got all methods via "handles $typeObject" (next role)';
    dies_ok { $a.d() }, '... but non existing methods still die';
}

# vim: syn=perl6
