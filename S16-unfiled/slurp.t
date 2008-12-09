use v6;

use Test;

plan 9;

# L<E07/"And every one shall share..." /returns them as a single string/>
# L<S16/"Unfiled"/"=item IO.slurp">

# read self, so that we can know for sure what's
# in the file
my $self = 't/spec/S16-unfiled/slurp.t';

#?rakudo 1 skip "no index() function"
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
{
  my @slurped_lines = lines($self);
  ok +@slurped_lines > 30, "more than 30 lines in this file ?";

  my $fh = open $self orelse die;
  my @expected_lines = =$fh;
  $fh.close;
  
  is +@slurped_lines, +@expected_lines, "same number of lines read";
  my $diff = 0;
  for 0..@slurped_lines-1 -> $i {
    $diff += @slurped_lines[$i] eq @expected_lines[$i] ?? 1 !! 0;
  }
  #?pugs todo ''
  is $diff, 0, "all the lines are the same";

  # chomp does not work on arrays yet
  my @chomped_lines;
  for @slurped_lines -> $line {
    push @chomped_lines, chomp $line;
  }
  is_deeply @expected_lines, @chomped_lines, "same lines read with both slurp and via open";

  my @dot_lines = "README".slurp;
  is +@dot_lines, +@expected_lines, "same number of lines read";

  my $filename = "README";
  my @var_dot_lines = $filename.slurp;
  is +@var_dot_lines, +@expected_lines, "same number of lines read";
}
