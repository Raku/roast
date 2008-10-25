use v6;

use Test;

plan 2;

BEGIN { @*INC.unshift('t/oo/class/TestFiles'); }

# Testing class literals
require Foo;
my $test1;

lives_ok {
    $test1 = ::Foo;
}, "::Foo is a valid class literal";

# Test removed per L<"http://www.nntp.perl.org/group/perl.perl6.language/22220">
# Foo.isa(Class) is false.
#isa_ok($test1, "Class", "It's a class");

my $x = eval 'Foo';
ok($x ===  ::Foo, "Foo is now a valid class literal");
