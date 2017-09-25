use v6;

# L<S28/Perl 5 to Perl 6 special variable translation>

use Test;

plan 3;

my $manual-inittime = INIT now ;

ok defined($*INITTIME),     '$*INITTIME is defined';
isa-ok $*INITTIME, Instant, "   ... and is-a type Instant";

# Check that $*INITTIME refers to an instant that occurred
# within the second before our manually sampled inittime
is-approx $*INITTIME, $manual-inittime - 0.5, :abs-tol(0.5),
                            "   ... of approximately correct value";
