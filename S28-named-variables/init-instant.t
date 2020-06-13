use v6;

# L<S28/Perl to Raku special variable translation>

use Test;

plan 3;

my $manual-init-time = INIT now ;

ok defined($*INIT-INSTANT),     '$*INIT-INSTANT is defined';
isa-ok $*INIT-INSTANT, Instant, "   ... and is-a type Instant";

# Check that $*INIT-INSTANT refers to an instant that occurred
# within a few seconds of our manually sampled init time
is-approx $*INIT-INSTANT, $manual-init-time, :abs-tol(5 * (%*ENV<ROAST_TIMING_SCALE>//1)),
                            "   ... of approximately correct value";

# vim: expandtab shiftwidth=4
