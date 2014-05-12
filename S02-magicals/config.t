use v6;

use Test;

=begin kwid

Config Tests

If this test fails because your osname is not listed here, please add it.
But don't add other osnames just because you know of them. That way we can
get a list of osnames that have actually passed tests.

=end kwid

plan 5;

# $?DISTRO.name is the OS we were compiled in.
#?rakudo skip 'unimpl $?DISTRO'
ok $?DISTRO.name, "We were compiled in '{$?DISTRO.name}'";

# $*DISTRO.name is the OS we are running
ok $*DISTRO.name, "We are running under '{$*DISTRO.name}'";

my $osnames = lc any <darwin linux freebsd MSWin32 mingw msys cygwin solaris haiku openbsd>;

#?rakudo skip 'unimpl $?OS'
ok $?DISTRO.name.lc eq $osnames, "we know of the OS we were compiled in";

ok $*DISTRO.name.lc eq $osnames, "we know of the OS we are running under";

# this is tested in perlver.t but that test is not included
ok $*DISTRO.version, '$*DISTRO.version is present';

# vim: ft=perl6
