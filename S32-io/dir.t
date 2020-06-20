use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 17;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?rakudo todo 'directories are not marked with trailing / yet'
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

nok @files.grep(*.basename eq '.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.basename eq 't'), "can exclude t/ dir";

is dir('t').[0].dirname, 't', 'dir("t") returns paths with .dirname of "t"';

# https://github.com/Raku/old-issue-tracker/issues/3593
{
    my $res = dir "/";
    ok $res !~~ m/ "/" ** 2 /,
        'results for \'dir "/"\' do not begin with 2 slashes';
}

{
    my $dir = make-temp-dir;
    $dir.add('foo.txt').open(:w).close;

    my $tested = False;
    @ = dir IO::Path.new($dir, :CWD($dir)), :test{
        when 'foo.txt' {
            is-path $*CWD, $dir, '$*CWD is set right inside dir(:test)';
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

# https://github.com/Raku/old-issue-tracker/issues/6658
subtest '.dir with relative paths sets right CWD' => {
    plan 3;
    (((my $dir := make-temp-dir).add('meow').mkdir).add('foos')).spurt: 'pass';
    is $dir.dir.head.add('foos').slurp, 'pass', 'right .dir with original path';
    is $dir.add('meow').dir.head.slurp, 'pass', 'right .dir with .add-ed path';
    is IO::Path.new('meow', :CWD($dir.absolute)).dir.head.slurp, 'pass',
        'right .dir with relative path';
}

{
    ok dir("/")[0].starts-with("/"),
      "make sure dir / produces absolute paths";
}

# vim: expandtab shiftwidth=4
