use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 7;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

{
    my $dir = make-temp-dir;
    ok $dir.e, "$dir exists";
    ok $dir.d, "$dir is a directory";
}

# rmdir soft-fails when dir doesn't exist.
{
    my $dir = make-temp-dir;
    $dir.rmdir;
    throws-like { $dir.rmdir }, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
{
    my $dir = make-temp-dir;
    spurt "$dir/file", "hello world";
    throws-like { $dir.rmdir }, X::IO::Rmdir;
}

# mkdir in a dir that doesn't exist
#?rakudo skip "mkdir NYI RT #124791"
{
    # XXX: mkdir creates nested directories if they don't exist,
    # so does this test make sense anymore?
    my $dir = make-temp-dir;
    $dir.rmdir;
    throws-like { $dir.child('foo').mkdir }, X::IO::Mkdir;
}

# mkdir a dir that already exists
#?rakudo skip "mkdir NYI RT #124792"
{
    # XXX: mkdir returns True (pre 2017.05) or the IO::Path itself
    # when dir already exists, so does this test make sense?
    my $dir = make-temp-dir;
    throws-like { $dir.mkdir }, X::IO::Mkdir;
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

# vim: ft=perl6
