use v6;
use Test;
plan 6;

# L<S29/IO/unlink>
# old: L<S16/"Filehandles, files, and directories"/"unlink">

sub nonce() { "unlink-t-testfile-" ~ 1000.rand }

my $fn = "unlink-test-file" ~ nonce;

my $iswin32 = ?($*OS eq any <MSWin32 mingw msys cygwin>) ?? "Timely closing of file handles does not yet work" !! False;

# open, explicit close, unlink, test
{
  my $fh = open($fn, :w);
  close $fh;

  ok $fn.IO ~~ :e,   "open() created a tempfile";
  ok(unlink($fn), "unlink() returned true");
  ok $fn.IO !~~ :e,  "unlink() actually deleted the tempfile";
}

# open, implicit close because of scope exit, unlink, test
{
  { my $fh = open($fn, :w) }

  ok $fn.IO ~~ :e,   "open() created a tempfile";
  ok(unlink($fn), "unlink() returned true");
  #?rakudo skip 'implicit closure of file handle at scope exit not implemented (FAILS ON WINDOWS) (noauto)'
  ok $fn.IO !~~ :e,  "unlink() actually deleted the tempfile";
}

# vim: ft=perl6
