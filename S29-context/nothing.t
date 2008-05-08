use v6;

use Test;

=begin description

Test for the C<nothing> builtin.

=end description

# L<S29/Context/=item nothing>

plan 2;

lives_ok { nothing }, "nothing() works";

# Probably the most commonly used form:
my $var;
nothing while $var++ < 3;

# We're still here, so pass().
pass "nothing() works in while";

