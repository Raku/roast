use v6;
use Test;

plan 13;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?niecza skip "Grepping Str against a list of IO::Local does not work"
#?rakudo todo 'directories are not marked with trailing / yet'
ok @files>>.relative.grep('t/'), 'current directory contains a t/ dir';
ok @files.grep(*.basename eq 't'), 'current directory contains a t/ dir';
#?rakudo todo 'entries are still IO::Path'
ok @files[0] ~~ IO::Local, 'dir() returns IO::Local';
#?rakudo todo 'dirname is not yet absolute'
is @files[0].dirname, $*CWD, 'dir() returns IO::Path object in the current directory';

#?niecza 3 skip "Grepping Str against a list of IO::Local does not work"
nok @files>>.relative.grep('.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.basename eq 't'), "can exclude t/ dir";

# previous tests rewritten to not smartmatch against IO::Local.
# Niecza also seems to need the ~, alas.
nok @files.grep(*.basename eq '.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.basename eq 't'), "can exclude t/ dir";

#?rakudo todo '$*CWD misses slash at end still'
is dir('t').[0].dirname, $*CWD ~ 't', 'dir("t") returns paths with .dirname of "t"';

# RT #123308
{
    my $res = dir "/";
    ok $res !~~ m/ "/" ** 2 /,
        'results for \'dir "/"\' do not begin with 2 slashes';
}

# vim: ft=perl6
