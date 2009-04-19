use v6;

use Test;

plan 2;

# $*CWD is currently just a string

ok( defined($*CWD), 'we have something in our $CWD');

### Get CWD from parrot

my $cwd = Q:PIR {
    $P0 = new ['OS']
    $S0 = $P0.'cwd'()
    %r = box $S0
};
is($*CWD, $cwd, 'matches CWD from parrot');

# vim: ft=perl6
