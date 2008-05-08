use v6;
use Test;

# L<S29/Context/"=item sleep">


plan 4;

my $start = time();
diag "Sleeping for 3s";
my $sleep_says = sleep 3;
my $diff = time() - $start;

cmp_ok( $sleep_says, &infix:«>=», 2,  'Sleep says it slept at least 2 seconds');
cmp_ok( $sleep_says, &infix:«<=», 10, '... and no more than 10' );

cmp_ok( $diff, &infix:«>=», 2,  'Actual time diff is at least 2 seconds' );
cmp_ok( $diff, &infix:«<=», 10, '... and no more than 10' );
