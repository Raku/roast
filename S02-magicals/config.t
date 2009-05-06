use v6;

use Test;

=begin kwid

Config Tests

If this test fails because your osname is not listed here, please add it.
But don't add other osnames just because you know of them. That way we can
get a list of osnames that have actually passed tests.

=end kwid

plan 4;

# $?OS is the OS we were compiled in.
#?rakudo skip 'unimpl $?OS'
ok $?OS, "We were compiled in '$?OS'";

# $*OS is the OS we are running
ok $*OS, "We are running under '$*OS'";

my $osnames = any <darwin linux FreeBSD MSWin32 mingw msys cygwin browser>;

#?rakudo skip 'unimpl $?OS'
is $?OS, $osnames, "we know of the OS we were compiled in";

is $*OS, $osnames, "we know of the OS we are running under";
