use v6;

# L<S28/Named variables/$*CWD>
# See also S16-io/cwd.t

use Test;

plan 2;

# $*CWD is currently just a string

ok( defined($*CWD), 'we have something in our $CWD');

# check if there is a t subfolder

my $subfolder_exists = 0;
if "$*CWD/t".IO ~~ :e {
    $subfolder_exists = 1;
}#if
ok( $subfolder_exists, 'we have a "t" subfolder');


# vim: ft=perl6
