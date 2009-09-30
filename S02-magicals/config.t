use v6;

use Test;

=begin kwid

Config Tests

If this test fails because your osname is not listed here, please add it.
But don't add other osnames just because you know of them. That way we can
get a list of osnames that have actually passed tests.

=end kwid

plan 6;

# $?OS is the OS we were compiled in.
#?rakudo skip 'unimpl $?OS'
ok $?OS, "We were compiled in '$?OS'";

# $*OS is the OS we are running
ok $*OS, "We are running under '$*OS'";

my $osnames = any <darwin linux FreeBSD MSWin32 mingw msys cygwin browser solaris haiku>;

#?rakudo skip 'unimpl $?OS'
ok $?OS eq $osnames, "we know of the OS we were compiled in";

ok $*OS eq $osnames, "we know of the OS we are running under";

# like $*OS, this is tested in perlver.t but that test is not included
ok $*OSVER, '$*OSVER is present';

# vim: ft=perl6
