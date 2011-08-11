use v6;

# Test various forms of comments

use Test;

plan 1;

# L<S02/Literals/"The double-underscore forms are going away:">

ok 1, "Before the =END Block";

=begin END

ok 2, "After the end block";


# vim: ft=perl6
