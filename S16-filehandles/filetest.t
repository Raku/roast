use v6;

use Test;

=begin pod

=head1 DESCRIPTION

This test tests the various filetest operators.

=end pod

plan 41;

# L<S32::IO/IO::FSNode/=item IO ~~ :X>
# L<S03/Changes to Perl 5 operators/The filetest operators are gone.>
# old: L<S16/Filehandles, files, and directories/A file test, where X is one of the letters listed below.>

#?niecza todo
dies_ok { 't' ~~ :d }, 'file test from before spec revision 27503 is error';

# Basic tests
ok 't'.IO ~~ :d,             "~~:d returns true on directories";
lives_ok { 'non_existing_dir'.IO ~~ :d },
         'can :d-test against non-existing dir and live';
ok !('non_existing_dir'.IO ~~ :d ),
         'can :d-test against non-existing dir and return false';
ok $*PROGRAM.IO ~~ :f,  "~~:f returns true on files";
ok $*PROGRAM.IO ~~ :e,  "~~:e returns true on files";
ok 't'.IO ~~ :e,             "~~:e returns true on directories";
ok $*PROGRAM.IO ~~ :r,  "~~:r returns true on readable files";
ok $*PROGRAM.IO ~~ :w,  "~~:w returns true on writable files";

if $*DISTRO.is-win {
  skip "win32 doesn't have ~~:x", 2;
} else {
  if $*EXECUTABLE_NAME.IO ~~ :e {
    ok $*EXECUTABLE_NAME.IO ~~ :x, "~~:x returns true on executable files";
  }
  else {
    skip "'$*EXECUTABLE_NAME' is not present (interactive mode?)", 1;
  }
  ok 't'.IO ~~ :x,    "~~:x returns true on cwd()able directories";
}

nok "t".IO ~~ :f, "~~:f returns false on directories";
ok "t".IO ~~ :r,  "~~:r returns true on a readable directory";

ok 'doesnotexist'.IO !~~ :d, "~~:d returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :r, "~~:r returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :w, "~~:w returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :x, "~~:x returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :f, "~~:f returns false on non-existent directories";

ok not 'doesnotexist.t'.IO ~~ :f, "~~:f returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :r, "~~:r returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :w, "~~:w returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :x, "~~:x returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :f, "~~:f returns false on non-existent files";

#?niecza skip ".s NYI"
ok($*PROGRAM.IO.s > 42,   "~~:s returns size on existent files");

nok "doesnotexist.t".IO ~~ :s, "~~:s returns false on non-existent files";

nok $*PROGRAM.IO ~~ :z,   "~~:z returns false on existent files";
nok "doesnotexist.t".IO ~~ :z, "~~:z returns false on non-existent files";
nok "t".IO ~~ :z,              "~~:z returns false on directories";

my $fh = open("empty_file", :w);
close $fh;
#?niecza todo
ok "empty_file".IO ~~ :z,      "~~:z returns true for an empty file";
unlink "empty_file";

#?niecza skip "Asynchronous programming NYI exception generated"
{
    if $*DISTRO.is-win {
      skip "~~:M/~~:C/~~:A not working on Win32 yet", 9
    }
    else {
        my $fn = 'test_file_filetest_t';
        my $fh = open($fn, :w);
        close $fh;
        sleep 1; # just to make sure
        #?rakudo 3 skip ':M, :C, :A'
        ok ($fn.IO ~~ :M) < 0,      "~~:M works on new file";
        ok ($fn.IO ~~ :C) < 0,      "~~:C works on new file";
        ok ($fn.IO ~~ :A) < 0,      "~~:A works on new file";
        unlink $fn;

        if "README".IO !~~ :f {
            skip "no file README", 3;
        } else {
            ok ("README".IO ~~ :M) > 0, "~~:M works on existing file";
            ok ("README".IO ~~ :C) > 0, "~~:C works on existing file";
            ok ("README".IO ~~ :A) > 0, "~~:A works on existing file";
        }

        #?rakudo 3 skip ':M, :C, :A'
        ok not "xyzzy".IO ~~ :M, "~~:M returns undefined when no file";
        ok not "xyzzy".IO ~~ :C, "~~:C returns undefined when no file";
        ok not "xyzzy".IO ~~ :A, "~~:A returns undefined when no file";
    }
}

# potential parsing difficulties (pugs)
{
    sub f($) { return 8; }

    is(f($*PROGRAM), 8, "f(...) works");
    is(-f($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
    is(- f($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
}


# vim: ft=perl6
