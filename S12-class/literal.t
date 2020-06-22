use v6;
use Test;

use lib $?FILE.IO.parent(2).add: 'packages/FooBarBaz/lib';
use Foo;

plan 2;

# L<S12/Classes/"class or type name using">
# Testing class literals
my $test1;

ok ($test1 = ::Foo) ~~ Foo, "::Foo is a valid class literal";

# Test removed per L<"http://www.nntp.perl.org/group/perl.perl6.language/22220">
# Foo.isa(Class) is false.
#isa-ok($test1, "Class", "It's a class");

my $x = EVAL 'Foo';
ok($x ===  ::Foo, "Foo is now a valid class literal");

# vim: expandtab shiftwidth=4
