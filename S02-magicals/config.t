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
ok $?OS, "We were compiled in '$?OS'";
# $*OS is the OS we are running undef.
ok $*OS, "We are running under '$*OS'";

# my $osnames = 'darwin' | 'linux' | 'MSWin32' | 'FreeBSD';
my $osnames = any <darwin linux FreeBSD MSWin32 mingw msys cygwin browser>;
if ($?OS eq $osnames) {
    pass("...and we know of the OS we were compiled in")
} else {
    flunk("We do not know of the OS we were compiled in -- please report to the pugs team", :todo)
}

if ($*OS eq $osnames) {
    pass("...and we know of the OS we are running under")
} else {
    flunk("We do not know of the OS we are running under -- please report to the pugs team", :todo)
}
