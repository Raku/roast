use v6;
use Test;
plan 2;

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

my $tmpfile = "eof-test-" ~ nonce();
{
  my $fh = open($tmpfile, :w) or die qq/Failed to open "$tmpfile": $!/;
  $fh.print: "EOF_TESTING\n\n";
  close $fh or die qq/Failed to close "$tmpfile": $!/;
}

{
  my $fh = open $tmpfile or die qq/Failed to open "$tmpfile": $!/;
  $fh.lines;

  ok $fh.eof, 'Regular file EOF was reached';
  close $fh or die qq/Failed to close "$tmpfile": $!/;
}

# RT #127370
my $procfile = '/proc/1/comm';
{
  if $*KERNEL.name eq 'linux' {
    my $fh = open $procfile or die qq/Failed to open "$procfile": $!/;
;
    $fh.slurp-rest;

    ok $fh.eof, '/proc file EOF was reached';
    close $fh or die qq/Failed to close "$procfile": $!/;
  }
  else {
    skip "Don't test reading /proc file if not in Linux", 1;
  }
}

END { unlink $tmpfile }

# vim: ft=perl6
