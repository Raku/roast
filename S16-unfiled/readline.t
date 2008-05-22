use v6;
use Test;

# L<S16/"Unfiled"/"=item IO.readline">

plan 3;

#if $*OS eq "browser" {
#  skip_rest "Programs running in browsers don't have access to regular IO.";
#  exit;
#}

my $fh = open $*PROGRAM_NAME;
ok($fh, "could open self");
isa_ok($fh, 'IO');

my $line;
eval '
  $fh is chomped;
  $line = =$fh;
';

#?pugs todo 'feature, depends on "is chomped"'
is($line, "use v6;", "first line was chomped");

