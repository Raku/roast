use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
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
    #?rakudo.jvm todo 'code does not fail for unkown reasons'
    fails-like { $dir.rmdir }, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
{
    my $dir = make-temp-dir;
    spurt "$dir/file", "hello world";
    fails-like { $dir.rmdir }, X::IO::Rmdir;
}

# mkdir in a dir that doesn't exist
#?rakudo skip "mkdir NYI RT #124791"
{
    # XXX: mkdir creates nested directories if they don't exist,
    # so does this test make sense anymore?
    my $dir = make-temp-dir;
    $dir.rmdir;
    fails-like { $dir.child('foo').mkdir }, X::IO::Mkdir;
}

# mkdir a dir that already exists
#?rakudo skip "mkdir NYI RT #124792"
{
    # XXX: mkdir returns True (pre 2017.05) or the IO::Path itself
    # when dir already exists, so does this test make sense?
    my $dir = make-temp-dir;
    fails-like { $dir.mkdir }, X::IO::Mkdir;
}

# RT #126976
{
    try { "/".IO.mkdir } for ^5;
    pass '"/".IO.mkdir does not segfault';
}

# vim: ft=perl6
