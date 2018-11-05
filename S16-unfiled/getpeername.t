use v6.d;
use Test;

# old: L<S16/"Unfiled"/"IO.getpeername">
# L<S32::IO/IO::Socket/getpeername>

=begin pod

IO.getpeername test

=end pod

plan 1;

my $sock = IO::Socket::INET.connect('google.com', 80);
ok $sock.getpeername.defined, "IO::Socket::INet.getpeername works";

# vim: ft=perl6
