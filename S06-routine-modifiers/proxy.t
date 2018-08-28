use v6;

use Test;

# Tests for the Proxy class

# L<S06/Lvalue subroutines/"or a specially tied proxy object, with suitably">
# Return value of assignments of Proxy objects is decided now.
# See thread "Assigning Proxy objects" on p6l,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21838">.
# Quoting Larry:
#   The intention is that lvalue subs behave in all respects as if they
#   were variables.  So consider what
#
#       say $nonproxy = 40;
#
#   should do.

plan 25;

my $foo        = 42;
my $was_inside = 0;

sub lvalue_test1() is rw {
  $was_inside++;
  return-rw Proxy.new:
    FETCH => method () { 100 + $foo },
    STORE => method ($new) { $foo = $new - 100 };
};

{
    is $foo, 42,       "basic sanity (1)";
    is $was_inside, 0, "basic sanity (2)";

    is lvalue_test1(),              142, "getting var through Proxy (1)";
    # No todo_is here to avoid unexpected succeeds (? - elaborate?)
    is      $was_inside,              1, "lvalue_test1() was called (1)";

    is (lvalue_test1() = 123),      123, "setting var through Proxy";
    is      $was_inside,              2, "lvalue_test1() was called (2)";
    is      $foo,                    23, "var was correctly set (1)";

    is lvalue_test1(),              123, "getting var through Proxy (2)";
    is      $was_inside,              3, "lvalue_test1() was called (3)";
}

$foo        = 4;
$was_inside = 0;

sub lvalue_test2() is rw {
  $was_inside++;
  return-rw Proxy.new:
    FETCH => method ()     { 10 + $foo },
    STORE => method ($new) { $foo = $new - 100 };
};

{
    is $foo, 4,        "basic sanity (3)";
    is $was_inside, 0, "basic sanity (4)";


    is lvalue_test2(),               14, "getting var through Proxy (4)";
    # No todo_is here to avoid unexpected succeeds
    is      $was_inside,              1, "lvalue_test2() was called (4)";

    is (lvalue_test2() = 106),      16, "setting var through Proxy returns new value of the var";
    is      $was_inside,              2, "lvalue_test2() was called (5)";
    is      $foo,                     6, "var was correctly set (2)";

    is lvalue_test2(),               16, "getting var through Proxy (5)";
    is      $was_inside,              3, "lvalue_test2() was called (5)";
}

$foo        = 4;
$was_inside = 0;

sub lvalue_test3() {
  $was_inside++;
  return Proxy.new:
    FETCH => method ()     { 10 + $foo },
    STORE => method ($new) { $was_inside = 42 };
};

{
    is $foo, 4,        "basic sanity (6)";
    is $was_inside, 0, "basic sanity (7)";


    is lvalue_test3(),               14, "getting var through Proxy (8)";
    # No todo_is here to avoid unexpected succeeds
    is      $was_inside,              1, "lvalue_test3() was called (8)";

    dies-ok { EVAL '(lvalue_test3() = 42)' }, "Proxy returned from non is-rw is prefetched rvalue";
    is      $was_inside,              2, "lvalue_test3() was called (9)";

}

# https://github.com/rakudo/rakudo/issues/1466
subtest '.perl on Proxied object does not crash' => {
    plan 4;
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{Int}).VAR.perl｣,
        'Int fetch value';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{Nil}).VAR.perl｣,
        'Nil fetch value';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{IterationEnd}).VAR.perl｣,
        'IterationEnd fetch value';
    eval-lives-ok ｢(Proxy.new: :STORE{$^a,$^b}, :FETCH{42}).VAR.perl｣,
        '42 (i.e. .DEFINITE) fetch value';
}

# vim: ft=perl6
