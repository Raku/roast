use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 6;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

{
    my $dir = make-temp-path;
    is-deeply mkdir($dir), $dir, 'mkdir returns the IO::Path it made';
    ok $dir.e, "$dir exists";
    ok $dir.d, "$dir is a directory";
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

# RT #126976
{
    "/".IO.mkdir for ^10;
    pass '"/".IO.mkdir does not segfault';
}

# vim: ft=perl6
