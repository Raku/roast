use v6;

use Test;

plan 9;

# L<E07/"And every one shall share..." /returns them as a single string/>
# L<S16/"Unfiled"/"=item IO.slurp">

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

{
  my $contents = slurp "README";
  ok index($contents, "Pugs") != -1, "slurp() worked";
}

#?rakudo skip 'dies_ok() not implemented'
{
  dies_ok { slurp "does-not-exist" }, "slurp() on not-existant files fails";
}

#?rakudo skip 'dies_ok() not implemented'
{
  dies_ok { slurp "t/" }, "slurp() on directories fails";
}

# slurp in list context
{
  my @slurped_lines = slurp "README";
  ok +@slurped_lines > 50, "more than 50 lines in README file ?";

  my $fh = open "README" orelse die;
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
