use v6;
use Test;

# old: L<S16/"Unfiled"/"IO.getpeername">
# L<S32::IO/IO::Socket/getpeername>

=begin pod

IO.getpeername test

=end pod

plan 1;

my $sock = IO::Socket::INET.connect('google.com', 80);
#?rakudo todo "getpeername is not implemented yet"
# It's better to remove try when the TODO passes. Though more testing would then be needed anyway, I guess.
ok (try $sock.getpeername.defined), "IO::Socket::INet.getpeername works";

# vim: expandtab shiftwidth=4
