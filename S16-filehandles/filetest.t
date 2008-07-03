use v6;

use Test;

=begin pod

=head1 DESCRIPTION

This test tests the various filetest operators.

=end pod

plan 37;

#if $*OS eq any <MSWin32 mingw msys cygwin> {
#    skip 30, "file tests not fully available on win32";
#    exit;
#};

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

# L<S03/Changes to Perl 5 operators/The filetest operators are gone.>
# L<S16/Filehandles, files, and directories/A file test, where X is one of the letters listed below.>

# Basic tests
ok 't' ~~ :d,             "~~:d returns true on directories";
ok $*PROGRAM_NAME ~~ :f,  "~~:f returns true on files";
ok $*PROGRAM_NAME ~~ :e,  "~~:e returns true on files";
ok 't' ~~ :e,             "~~:e returns true on directories";
ok $*PROGRAM_NAME ~~ :r,  "~~:r returns true on readable files";
ok $*PROGRAM_NAME ~~ :w,  "~~:w returns true on writable files";

if $*OS eq any <MSWin32 mingw msys cygwin> {
  skip 2, "win32 doesn't have ~~:x";
} else {
  if $*EXECUTABLE_NAME ~~ :e {
    ok $*EXECUTABLE_NAME ~~ :x, "~~:x returns true on executable files";
  }
  else {
    skip 1, "'$*EXECUTABLE_NAME' is not present (interactive mode?)";
  }
  ok 't' ~~ :x,    "~~:x returns true on cwd()able directories";
}

ok not "t" ~~ :f, "~~:f returns false on directories";
ok "t" ~~ :r,  "~~:r returns true on a readable directory";

skip 2, "/etc/shadow tests skipped";
#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 2, "win32 doesn't have /etc/shadow";
#} else {
#  ok not "/etc/shadow" ~~ :r, "~~:r returns false on unreadable files";
#  ok not "/etc/shadow" ~~ :w, "~~:w returns false on unwritable files";
#}

ok not 'doesnotexist' ~~ :d, "~~:d returns false on non existant directories";
ok not 'doesnotexist' ~~ :r, "~~:r returns false on non existant directories";
ok not 'doesnotexist' ~~ :w, "~~:w returns false on non existant directories";
ok not 'doesnotexist' ~~ :x, "~~:x returns false on non existant directories";
ok not 'doesnotexist' ~~ :f, "~~:f returns false on non existant directories";

ok not 'doesnotexist.t' ~~ :f, "~~:f returns false on non existant files";
ok not 'doesnotexist.t' ~~ :r, "~~:r returns false on non existant files";
ok not 'doesnotexist.t' ~~ :w, "~~:w returns false on non existant files";
ok not 'doesnotexist.t' ~~ :x, "~~:x returns false on non existant files";
ok not 'doesnotexist.t' ~~ :f, "~~:f returns false on non existant files";

#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 1, "~~:s is not working on Win32 yet"
#}
#else {
  # XXX - Without parens, $*PROGRAM_NAME ~~ :s>42 is chaincomp.
  ok(($*PROGRAM_NAME~~:s) > 42,   "~~:s returns size on existant files");
#}
ok not "doesnotexist.t" ~~ :s, "~~:s returns false on non existant files";

ok not $*PROGRAM_NAME ~~ :z,   "~~:z returns false on existant files";
ok not "doesnotexist.t" ~~ :z, "~~:z returns false on non existant files";
ok not "t" ~~ :z,              "~~:z returns false on directories";

my $fh = open("empty_file", :w);
close $fh;
#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 1, " ~~ :z is not working on Win32 yet"
#}
#else {
  ok "empty_file" ~~ :z,      "~~:z returns true for an empty file";
#}
unlink "empty_file";

if $*OS eq any <MSWin32 mingw msys cygwin> {
  skip 9, "~~:M/~~:C/~~:A not working on Win32 yet"
}
else {
my $fh = open("test_file", :w);
close $fh;
sleep 1; # just to make sure
ok ("test_file" ~~ :M) < 0,      "~~:M works on new file";
ok ("test_file" ~~ :C) < 0,      "~~:C works on new file";
ok ("test_file" ~~ :A) < 0,      "~~:A works on new file";
unlink "test_file";

if (! "README" ~~ :f) {
  skip 3, "no file README";
} else {
  ok ("README" ~~ :M) > 0, "~~:M works on existing file";
  ok ("README" ~~ :C) > 0, "~~:C works on existing file";
  ok ("README" ~~ :A) > 0, "~~:A works on existing file";
}

ok not "xyzzy" ~~ :M, "~~:M returns undef when no file";
ok not "xyzzy" ~~ :C, "~~:C returns undef when no file";
ok not "xyzzy" ~~ :A, "~~:A returns undef when no file";
}

eval q{
    ok $*PROGRAM_NAME.:s > 42,   ".:s returns size on existant files";
}
