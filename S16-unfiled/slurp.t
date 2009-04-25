use v6;

use Test;

plan 5;

# L<E07/"And every one shall share..." /returns them as a single string/>
# L<S16/"Unfiled"/"=item IO.slurp">

# read self, so that we can know for sure what's
# in the file
my $self = 't/spec/S16-unfiled/slurp.t';

{
  my $contents = slurp $self;
 #ok index($contents, "StringThatsNowhereElse") != -1, "slurp() worked";
  ok $contents ~~ m/'StringThatsNowhereElse'/, "slurp() worked";
}

{
  dies_ok { slurp "does-not-exist" }, "slurp() on not-existant files fails";
}

{
  dies_ok { slurp "t/" }, "slurp() on directories fails";
}

# slurp in list context

my @slurped_lines = lines(open($self));
ok +@slurped_lines > 30, "more than 30 lines in this file ?";

{
  my $fh = open $self, :r;
  my $contents = slurp $fh;
  
  # lame use of filehandle but might be able to seek/rewind some day ...
  # also allows 'slurp $*IN' huffmanized to just slurp
  ok $fh.ins == 0 && $contents ~~ m/'use v6'.*'StringThatsNowhereElse'/,
    "slurp worked through file handle";
  
  $fh.close;
}

# vim: ft=perl6
