use v6;
use Test;

# L<S16/IO/$*TMPDIR>

plan 7;

isa-ok $*TMPDIR, IO::Path;
lives-ok { $*TMPDIR.perl }, '$*TMPDIR.perl works';
lives-ok { $*TMPDIR.gist }, '$*TMPDIR.gist works';

isa-ok .tmpdir, IO::Path, "{.^name}.tmpdir returns IO::Path"
    for IO::Spec::Unix, IO::Spec::Win32, IO::Spec::Cygwin, IO::Spec::QNX;
