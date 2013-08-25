use Test;

# L<S16/IO/$*CWD>
# see also S28-named-variables/cwd.t

plan 3;

isa_ok $*CWD, IO::Path;
lives_ok { $*CWD.perl }, '$*CWD.perl works';
lives_ok { $*CWD.gist }, '$*CWD.gist works';
