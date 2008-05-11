use v6-alpha;

use Test;

plan 41;

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
  ok (!try { $a.hi }), "calling a method on no object didn't succeed (1)";
  ok ($a.backend = Backend1.new()), "setting a handler object (1)";
  ok (!($a ~~ Backend1)),             "object wasn't isa()ed (1)";
  is try{ $a.hi }, 42, "method was successfully handled by backend object (1)";
}

{
  my $a;
  ok ($a = Frontend.new), "basic instantiation worked (2)";
  ok (!try { $a.hi }), "calling a method on no object didn't succeed (2)";
  ok ($a.backend = Backend2.new()), "setting a handler object (2)";
  ok (!($a ~~ Backend2)),             "object wasn't isa()ed (2)";
  is try{ $a.hi }, 23, "method was successfully handled by backend object (2)";
}


# L<S12/Delegation/"Any other kind of argument" "smartmatch selector for method">
class ReFrontend { has $.backend is rw handles /^hi/ };
ok ReFrontend.new, "class definition using a smartmatch handle worked";

{
  my $a;
  ok ($a = ReFrontend.new), "basic instantiation worked (3)";
  ok (!try { $a.hi }), "calling a method on no object didn't succeed (3)";
  ok ($a.backend = Backend1.new()), "setting a handler object (3)";
  ok (!($a ~~ Backend1)),             "object wasn't isa()ed (3)";
  is try{ $a.hi }, 42, "method was successfully handled by backend object (3)", :todo<feature>;
}


# L<S12/Delegation/If you say>
class ClassFrontend { has $.backend is rw handles Backend2 };
ok ClassFrontend.new, "class definition using a Class handle worked";
{
  my $a;
  ok ($a = ClassFrontend.new), "basic instantiation worked (4)";
  ok (!try { $a.hi }), "calling a method on no object didn't succeed (4)";
  ok ($a.backend = Backend1.new()), "setting a handler object (4)";
  ok (!($a ~~ Backend1)),             "object wasn't isa()ed (4-1)";
  ok (!($a ~~ Backend2)),             "object wasn't isa()ed (4-2)";
  is (try{ $a.hi }), 42, "method was successfully handled by backend object (4)", :todo<feature>;
}


# L<S12/Delegation/You can specify multiple method names:>
class MultiFrontend { has $.backend is rw handles <hi cool> }
ok MultiFrontend.new, "class definition using multiple method names worked";
{
  my $a;
  ok ($a = MultiFrontend.new), "basic instantiation worked (5)";
  ok (!try { $a.hi   }), "calling a method on no object didn't succeed (5-1)";
  ok (!try { $a.cool }), "calling a method on no object didn't succeed (5-2)";
  ok ($a.backend = Backend1.new()), "setting a handler object (5)";
  ok (!($a ~~ Backend1)),             "object wasn't isa()ed (5)";
  is (try { $a.hi }),     42, "method was successfully handled by backend object (5-1)", :todo<feature>;
  is (try { $a.cool }), 1337, "method was successfully handled by backend object (5-2)", :todo<feature>;
}

#

class MyArray {
    has @.elems handles "join";
    method concat handles <chars bytes graphs codes> { .join("") }
}

ok MyArray.new, "class with attribute and return value delegation";
{
  my $a;
  ok ($a = MyArray.new(elems => [1..5])), "basic instantiation worked";
  is try{ $a.concat }, "12345", "attribute delegation worked", :todo<feature>;
  is try{ $a.bytes  }, 5, "return delegation worked", :todo<feature>;
  is try{ $a.chars  }, 5, "return delegation worked", :todo<feature>;
  is try{ $a.codes  }, 5, "return delegation worked", :todo<feature>;
  is try{ $a.graphs }, 5, "return delegation worked", :todo<feature>;
}

# vim: syn=perl6
