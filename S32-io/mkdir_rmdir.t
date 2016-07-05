use v6;
use Test;

plan 9;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

#?niecza skip "mkdir rmdir NYI"
#?rakudo skip "mkdir rmdir NYI RT #124788"
{
    my $d = testdir();
    $d.mkdir;
    ok $d.e, "$d exists";
    ok $d.d, "$d is a directory";

    $d.rmdir;
    ok !$d.e, "$d was removed";
}

# rmdir soft-fails when dir doesn't exist.
#?niecza skip "rmdir NYI"
#?rakudo skip "rmdir NYI RT #124789"
#?DOES 1
{
    my $err = testdir().path.rmdir;
    isa_fatal_ok $err, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
#?niecza skip "mkdir rmdir NYI"
#?rakudo skip "mkdir rmdir NYI RT #124790"
{
    my $dir = testdir();
    $dir.mkdir;
    spurt "$dir/file", "hello world";
    my $err = $dir.rmdir;
    isa_fatal_ok $err, X::IO::Rmdir;

    unlink "$dir/file";
    $dir.rmdir;
}

# mkdir in a dir that doesn't exist
#?niecza skip "mkdir NYI"
#?rakudo skip "mkdir NYI RT #124791"
{
    my $dir = testdir().child(testdir());
    my $err = $dir.mkdir;
    isa_fatal_ok $err, X::IO::Mkdir;
}

# mkdir a dir that already exists
#?niecza skip "mkdir NYI"
#?rakudo skip "mkdir NYI RT #124792"
{
    my $dir = testdir();
    $dir.mkdir;
    my $err = $dir.mkdir;
    isa_fatal_ok $err, X::IO::Mkdir;
}

# RT #126976
subtest {
    # This test is a bit tricky:
    #   it generally should throw since we can't create '/' directory
    #   on Windows, however, such .mkdir returns True due to a
    #   backward compatibility wart. BUT, it fails if the test is run
    #   from a root directory, such as C:\ [discussion:
    #    http://irclog.perlgeek.de/perl6-dev/2016-07-05#i_12784679]
    #
    #   So what we're doing here is skipping the exception testing if
    #     we are on Windows and got True. We also attempt to .mkdir
    #     a few times to ensure segfaults aren't lurking in there.

    my $result;
    try {
        $result = "/".IO.mkdir;
        CATCH { default { $result = $_; } };
    } for ^5;

    if $*DISTRO ~~ /'mswin32'/ and $result ~~ Bool and $result {
        skip '"/".IO.mkdir succeeds on Windows when not run in root dir', 2;
    }
    else {
        isa-ok $result, X::IO::Mkdir, 'we received an exception';
        like $result.message, /'Failed to create directory'/,
            'exception has right message';
    }
}, '"/".IO.mkdir must not segfault';

sub testdir {
    my $testdir = "testdir-" ~ 1000000.rand.floor;
    die if $testdir.path.e;
    END try { $testdir.path.rmdir; 1; }
    $testdir.path;
}

sub isa_fatal_ok($e, $wanted) {
    $e ~~ "blow up";
    CATCH {
        when $wanted {
            ok True, "Got expected " ~ $wanted.perl;
            return;
        }
        default {
            ok False, "Got wrong error";
            return;
        }
    };
    ok False, "No exception, expected " ~ $wanted.perl;
}
