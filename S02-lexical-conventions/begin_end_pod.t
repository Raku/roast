use v6;

# Test various forms of comments

use Test;

plan 2;

# L<S02/Double-underscore forms/"The double-underscore forms are going away:">

ok 1, "Before the =finish Block";
is $=finish,q:to/TEXT/, 'Can we read the lines after =finish';
flunk "After the end block";

# vim: ft=perl6
TEXT

=finish
flunk "After the end block";

# vim: ft=perl6
