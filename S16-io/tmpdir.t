use Test;

# L<S16/IO/$*TMPDIR>

plan 3;

#?rakudo todo 'still in newio branch'
isa_ok $*TMPDIR, IO::Dir;
lives_ok { $*TMPDIR.perl }, '$*TMPDIR.perl works';
lives_ok { $*TMPDIR.gist }, '$*TMPDIR.gist works';
