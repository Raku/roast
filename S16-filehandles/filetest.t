use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

=begin pod

=head1 DESCRIPTION

This test tests the various filetest operators.

=end pod

plan 128;

# L<S32::IO/IO::FSNode/=item IO ~~ :X>
# L<S03/Changes to Perl 5 operators/The filetest operators are gone.>
# old: L<S16/Filehandles, files, and directories/A file test, where X is one of the letters listed below.>

dies-ok { 't' ~~ :d }, 'file test from before spec revision 27503 is error';

# Basic tests
ok 't'.IO ~~ :d,             "~~:d returns true on directories";
lives-ok { 'non_existing_dir'.IO ~~ :d },
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
  if $*EXECUTABLE-NAME.IO ~~ :e {
    ok $*EXECUTABLE-NAME.IO ~~ :x, "~~:x returns true on executable files";
  }
  else {
    skip "'$*EXECUTABLE-NAME' is not present (interactive mode?)", 1;
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

ok($*PROGRAM.IO.s > 42,   "~~:s returns size on existent files");

nok "doesnotexist.t".IO ~~ :s, "~~:s returns false on non-existent files";

nok $*PROGRAM.IO ~~ :z,   "~~:z returns false on existent files";
nok "doesnotexist.t".IO ~~ :z, "~~:z returns false on non-existent files";
nok "t".IO ~~ :z,              "~~:z returns false on directories";

my $fh = open("empty_file", :w);
close $fh;
ok "empty_file".IO ~~ :z,      "~~:z returns true for an empty file";
unlink "empty_file";

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

# potential parsing difficulties
{
    sub f($) { return 8; }

    is(f($*PROGRAM), 8, "f(...) works");
    is(-f($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
    is(- f($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
}

# RT #114000
{
    my $file = 'ThisDoesNotExistAtAll.link';
    if $file.IO.e {
        skip "could not run 2 tests since file $file exists", 2;
    }
    else {
        lives-ok { $file.IO ~~ :l },
            'can :l-test against non-existing file and live';
        nok $file.IO ~~ :l, '~~:l returns false on non-existent files';
    }
}

# RT #129162
{
    my $name = "symlink-test-source";
    my $target = "symlink-test-target";
    my $src = open($name, :w);
    $src.close;
    symlink($target, $name);
    unlink $name;

    ok $target.IO.l, "Broken symlink exists";
    unlink $target;
}

#?rakudo.jvm skip '[io grant] NoSuchFileException for open(:create)'
#?DOES 4
{
    my $f = make-temp-file;
    fails-like { $f.z }, X::IO::DoesNotExist, '.z fails for non-existent files';

    $f.open(:create).close; # `touch` the file
    is-deeply $f.z, True, '.z returns True for empty files';

    $f.spurt: 'test data';
    is-deeply $f.z, False, '.z return False for non-empty files';

    isa-ok make-temp-dir.z, Bool, '.z can be called on directories';
}

{
    sub filetest ($file, $test, $res, $chmod) {
        $file.chmod: $chmod;
        my $mod = "with 0{$chmod.base(8)} mode";
        with $test {
            when 'r' {
                is-deeply $file.r,         $res, ".r is $res $mod";
                is-deeply ($file ~~ :r),   $res, "~~ :r is $res $mod";
            }
            when 'w' {
                is-deeply $file.w,         $res, ".w is $res $mod";
                is-deeply ($file ~~ :w),   $res, "~~ :w is $res $mod";
            }
            when 'x' {
                is-deeply $file.x,         $res, ".x is $res $mod";
                is-deeply ($file ~~ :x),   $res, "~~ :x is $res $mod";
            }
            when 'rw' {
                is-deeply $file.rw,        $res, ".rw is $res $mod";
                is-deeply ($file ~~ :rw),  $res, "~~ :rw is $res $mod";
            }
            when 'rwx' {
                is-deeply $file.rwx,       $res, ".rwx is $res $mod";
                is-deeply ($file ~~ :rwx), $res, "~~ :rwx is $res $mod";
            }
        }
    }

    my $f = make-temp-file;
    $f.spurt: 'test data';

    filetest $f, 'r',   True,   0o777;
    filetest $f, 'r',   True,   0o666;
    filetest $f, 'r',   True,   0o555;
    filetest $f, 'r',   True,   0o444;
    filetest $f, 'r',   False,  0o333;
    filetest $f, 'r',   False,  0o222;
    filetest $f, 'r',   False,  0o111;
    filetest $f, 'r',   False,  0o000;

    filetest $f, 'w',   True,   0o777;
    filetest $f, 'w',   True,   0o666;
    filetest $f, 'w',   False,  0o555;
    filetest $f, 'w',   False,  0o444;
    filetest $f, 'w',   True,   0o333;
    filetest $f, 'w',   True,   0o222;
    filetest $f, 'w',   False,  0o111;
    filetest $f, 'w',   False,  0o000;

    filetest $f, 'x',   True,   0o777;
    filetest $f, 'x',   False,  0o666;
    filetest $f, 'x',   True,   0o555;
    filetest $f, 'x',   False,  0o444;
    filetest $f, 'x',   True,   0o333;
    filetest $f, 'x',   False,  0o222;
    filetest $f, 'x',   True,   0o111;
    filetest $f, 'x',   False,  0o000;

    filetest $f, 'rw',  True,   0o777;
    filetest $f, 'rw',  True,   0o666;
    filetest $f, 'rw',  False,  0o555;
    filetest $f, 'rw',  False,  0o444;
    filetest $f, 'rw',  False,  0o333;
    filetest $f, 'rw',  False,  0o222;
    filetest $f, 'rw',  False,  0o111;
    filetest $f, 'rw',  False,  0o000;

    filetest $f, 'rwx', True,   0o777;
    filetest $f, 'rwx', False,  0o666;
    filetest $f, 'rwx', False,  0o555;
    filetest $f, 'rwx', False,  0o444;
    filetest $f, 'rwx', False,  0o333;
    filetest $f, 'rwx', False,  0o222;
    filetest $f, 'rwx', False,  0o111;
    filetest $f, 'rwx', False,  0o000;
}

# vim: ft=perl6
