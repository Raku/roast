use v6-alpha;

use Test;

=head1 DESCRIPTION

Test for the C<nothing> builtin.

=cut

# L<S29/Context/=item nothing>

plan 2;

lives_ok { nothing }, "nothing() works";

# Probably the most commonly used form:
my $var;
nothing while $var++ < 3;
# We're still here, so pass().
pass "nothing() works in while";
