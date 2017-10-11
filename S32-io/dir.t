use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 17;

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

{
    my $dir = make-temp-dir;
    $dir.add('foo.txt').open(:w).close;
    my $dir-str = $dir.absolute;

    my $tested = False;
    @ = dir $dir, :CWD($dir), :test{
        when 'foo.txt' {
            is-deeply $*CWD.absolute, $dir-str,
                '$*CWD is set right inside dir(:test)';
            $tested = True;
        }
    };
    $tested or flunk 'expected a dir $*CWD test but it never ran';
}

subtest "dir-created IO::Paths' absoluteness controlled by invocant" => {
    plan 2;
    my @files = '.'.IO.dir;
    cmp-ok +@files, '==', +@files.grep({not .is-absolute}), 'relative invocant';

    @files = '.'.IO.absolute.IO.dir;
    cmp-ok +@files, '==', +@files.grep({    .is-absolute}), 'absolute invocant';
}

with make-temp-dir() -> $dir {
    $dir.add("$_$_$_").spurt("") for "a".."z";

    ## Read the folder from multiple threads, and sanity-check each IO::Path.
    ## The sanity check should never fail, but at some point it does.
    is_run q:to/♥/,
        await do for ^20 {
            start {
                for \qq[$dir.perl()].dir -> $path {
                    die "FAILED!" if $path.absolute ne $path.Str
                }
            }
        }
        print 'pass';
    ♥
    {:out<pass>, :err(''), :0status},
    'dir() does not produce wrong results under concurrent load';
}

# vim: ft=perl6
