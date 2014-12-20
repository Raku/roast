use Test;

# L<S16/IO/$*CWD>
# see also S28-named-variables/cwd.t

plan 3;

#?rakudo todo 'still in newio branch'
isa_ok $*CWD, IO::Dir;
lives_ok { $*CWD.perl }, '$*CWD.perl works';
lives_ok { $*CWD.gist }, '$*CWD.gist works';
