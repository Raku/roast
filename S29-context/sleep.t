use v6;
use Test;

# L<S29/Context/"=item sleep">


plan 4;

my $start = time;
diag "Sleeping for 3s";
my $sleep_says = sleep 3;
my $diff = time - $start;

#?pugs todo
ok( $sleep_says >= 2 , 'Sleep says it slept at least 2 seconds');
ok( $sleep_says <= 10 , '... and no more than 10');

ok( $diff >= 2 , 'Sleep says it slept at least 2 seconds');
ok( $diff <= 10 , '... and no more than 10');

# vim: ft=perl6
