use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 14;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?rakudo todo 'directories are not marked with trailing / yet RT #124784'
ok @files>>.relative.grep('t/'), 'current directory contains a t/ dir';
ok @files.grep(*.basename eq 't'), 'current directory contains a t/ dir';
#?rakudo skip 'entries are still IO::Path RT #124785'
ok @files[0] ~~ IO::Local, 'dir() returns IO::Local';
#?rakudo todo 'dirname is not yet absolute RT #124786'
is @files[0].dirname, $*CWD, 'dir() returns IO::Path object in the current directory';

nok @files>>.relative.grep('.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.basename eq 't'), "can exclude t/ dir";

# previous tests rewritten to not smartmatch against IO::Local.
# Niecza also seems to need the ~, alas.
nok @files.grep(*.basename eq '.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.basename eq 't'), "can exclude t/ dir";

#?rakudo todo '$*CWD misses slash at end still RT #124787'
is dir('t').[0].dirname, $*CWD ~ 't', 'dir("t") returns paths with .dirname of "t"';

# RT #123308
{
    my $res = dir "/";
    ok $res !~~ m/ "/" ** 2 /,
        'results for \'dir "/"\' do not begin with 2 slashes';
}

# RT #112662
is_run 'dir | say', {
    err => rx/'Argument' .* 'say' .* 'use .say'/,
}, '`dir | say` has useful error message';

# vim: ft=perl6
