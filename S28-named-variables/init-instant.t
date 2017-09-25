use v6;

# L<S28/Perl 5 to Perl 6 special variable translation>

use Test;

plan 3;

my $manual-init-time = INIT now ;

ok defined($*INIT-INSTANT),     '$*INIT-INSTANT is defined';
isa-ok $*INIT-INSTANT, Instant, "   ... and is-a type Instant";

# Check that $*INIT-INSTANT refers to an instant that occurred
# within the second before our manually sampled init time
is-approx $*INIT-INSTANT, $manual-init-time - 0.5, :abs-tol(0.5),
                            "   ... of approximately correct value";
