use v6.c;
use Test;
plan 3;

# L<S29/IO/unlink>
# old: L<S16/"Filehandles, files, and directories"/"unlink">

sub nonce() { "unlink-t-testfile-" ~ 1000.rand }

my $fn = "unlink-test-file" ~ nonce;

# open, explicit close, unlink, test
{
  my $fh = open($fn, :w);
  close $fh;

  ok $fn.IO ~~ :e,   "open() created a tempfile";
  ok(unlink($fn), "unlink() returned true");
  ok $fn.IO !~~ :e,  "unlink() actually deleted the tempfile";
}


# vim: ft=perl6
