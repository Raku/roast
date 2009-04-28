use v6;
use Test;

# old: L<S16/"Unfiled"/"IO.getpeername">
# L<S32::IO/IO::Socket/getpeername>

=begin pod

IO.getpeername test

=end pod

plan 1;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

my $sock = connect('google.com', 80);
ok $sock.getpeername.defined, "IO.getpeer works";
