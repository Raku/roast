use v6;

use Test;

plan 55;

=begin desc

Delegation tests from L<S12/Delegation>

=end desc

# L<S12/Delegation>

class Backend1 { method hi() { 42 }; method cool() { 1337 } }
class Backend2 { method hi() { 23 }; method cool() {  539 } }
class Frontend { has $.backend is rw handles "hi" }
ok Backend1.new, "class definition worked";

is Backend1.new.hi, 42, "basic sanity (1)";
is Backend2.new.hi, 23, "basic sanity (2)";

{
  my $a;
  ok ($a = Frontend.new), "basic instantiation worked (1)";
  dies_ok { $a.hi }, "calling a method on no object didn't succeed (1)";
  ok ($a.backend = Backend1.new()), "setting a handler object (1)";
  ok (!($a ~~ Backend1)), "object wasn't isa()ed (1)";
  is $a.hi, 42, "method was successfully handled by backend object (1)";
}

{
  my $a;
  ok ($a = Frontend.new), "basic instantiation worked (2)";
  dies_ok { $a.hi }, "calling a method on no object didn't succeed (2)";
  ok ($a.backend = Backend2.new()), "setting a handler object (2)";
  ok (!($a ~~ Backend2)), "object wasn't isa()ed (2)";
  is $a.hi, 23, "method was successfully handled by backend object (2)";
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
  is ($a.hi),     42, "method was successfully handled by backend object (5-1)";
  is ($a.cool), 1337, "method was successfully handled by backend object (5-2)";
}

# L<S12/Delegation/you put a pair/>
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
    #?pugs skip 'feature'
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
    is $a.cool, 1337, "...but otherwise it delegates, and first * wins";
}



#?DOES 7
#?rakudo skip 'unimplemented'
{
  class MyArray {
    has @.elems handles "join";
    method concat handles <chars bytes graphs codes> { .join("") }
  }

  ok MyArray.new, "class with attribute and return value delegation";
  {
    my $a;
    ok ($a = MyArray.new(elems => [1..5])), "basic instantiation worked";
    #?pugs 5 eval 'feature'
    is $a.concat , "12345", "attribute delegation worked";
    is $a.bytes  , 5, "return delegation worked";
    is $a.chars  , 5, "return delegation worked";
    is $a.codes  , 5, "return delegation worked";
    is $a.graphs , 5, "return delegation worked";
  }
}

# vim: syn=perl6
