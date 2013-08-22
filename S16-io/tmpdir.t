use Test;

# L<S16/IO/$*TMPDIR>

plan 3;

isa_ok $*TMPDIR, IO::Path;
lives_ok { $*TMPDIR.perl }, '$*TMPDIR.perl works';
lives_ok { $*TMPDIR.gist }, '$*TMPDIR.gist works';
