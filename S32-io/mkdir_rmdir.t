use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

{
    my $dir = make-temp-dir;
    ok $dir.e, "$dir exists";
    ok $dir.d, "$dir is a directory";
}

# mkdir soft-fails when pathname exists and is not a directory.
{
    my $file = make-temp-dir.add: "file";
    spurt $file, "hello world";
    fails-like { $file.mkdir }, X::IO::Mkdir;
}

# rmdir soft-fails when dir doesn't exist.
{
    my $dir = make-temp-dir;
    $dir.rmdir;
    fails-like { $dir.rmdir }, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
{
    my $dir = make-temp-dir;
    spurt "$dir/file", "hello world";
    fails-like { $dir.rmdir }, X::IO::Rmdir;
}

# https://github.com/Raku/old-issue-tracker/issues/4899
{
    try { "/".IO.mkdir } for ^5;
    pass '"/".IO.mkdir does not segfault';
}

# vim: expandtab shiftwidth=4
