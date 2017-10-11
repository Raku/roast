use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 16;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?rakudo todo 'directories are not marked with trailing / yet RT #124784'
ok @files>>.relative.grep('t/'), 'current directory contains a t/ dir';
ok @files.grep(*.basename eq 't'), 'current directory contains a t/ dir';
isa-ok @files[0], IO::Path, 'dir() returns IO::Path objects';

with make-temp-dir() {
    (my $wanted = .add: 'foo').spurt: '';
    is-deeply .dir.head.resolve.absolute, $wanted.resolve.absolute,
        'dir() returns IO::Path objects properly resolving to the found paths';
}

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

# vim: ft=perl6
