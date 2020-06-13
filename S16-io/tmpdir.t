use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


# L<S16/IO/$*TMPDIR>

plan 9;

isa-ok $*TMPDIR, IO::Path;
lives-ok { $*TMPDIR.raku }, '$*TMPDIR.raku works';
lives-ok { $*TMPDIR.gist }, '$*TMPDIR.gist works';

isa-ok .tmpdir, IO::Path, "{.^name}.tmpdir returns IO::Path"
    for IO::Spec::Unix, IO::Spec::Win32, IO::Spec::Cygwin, IO::Spec::QNX;

{
    my $before = $*TMPDIR;
    {
        temp $*TMPDIR = '/foo'.IO;
        is-path $*TMPDIR, '/foo'.IO, 'was able to `temp` $*TMPDIR';
    }
    is-path $*TMPDIR, $before,
        '`temp`ed $*TMPDIR got restored to previous value';
}

# vim: expandtab shiftwidth=4
