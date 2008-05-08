use v6;
use Test;

# L<S16/"Unfiled"/"IO.getpeername">

=begin pod

IO.getpeername test

=end pod

plan 1;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

my $sock = connect('google.com', 80);
is (eval('is $sock.getpeername')), not undef, "IO.getpeer works";
