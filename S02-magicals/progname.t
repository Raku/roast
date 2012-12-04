use v6;

use Test;

plan 3;

# TODO: this should be $?OS, but that's not yet supported under Rakudo
if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

ok(PROCESS::<$PROGRAM_NAME> ~~ / t['/'|'\\']spec['/'|'\\']S02'-'magicals['/'|'\\']progname'.'\w+$/, "progname var matches test file path");
ok($*PROGRAM_NAME ~~ / t['/'|'\\']spec['/'|'\\']S02'-'magicals['/'|'\\']progname'.'\w+$/, "progname var accessible as context var");

# NOTE:
# above is a junction hack for Unix and Win32 file
# paths until the FileSpec hack is working - Stevan
# changed junction hack in test 2 to regex for Rakudo fudged filename - mberends

#?niecza todo
lives_ok { $*PROGRAM_NAME = "coldfusion" }, '$*PROGRAM_NAME is assignable';

# vim: ft=perl6
