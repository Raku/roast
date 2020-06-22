use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S16/IO/$*HOME>

plan 8;

BEGIN %*ENV<HOME> = make-temp-dir.absolute;

isa-ok $*HOME, IO::Path,  '$*HOME contains IO::Path object';
lives-ok { $*HOME.raku }, '$*HOME.raku works';
lives-ok { $*HOME.gist }, '$*HOME.gist works';

if $*DISTRO.is-win {
    is_run ｢
        BEGIN %*ENV<HOME>:delete;
        BEGIN %*ENV<HOMEDRIVE HOMEPATH> = ('C:', ｢\foobar｣);
        die unless $*HOME.absolute eq ｢C:\foobar｣.IO.absolute;
        $*HOME = 42; # can still assign to it
    ｣, {:out(''), :err(''), :0status },
    '$*HOME is HOMEDRIVE+HOMEPATH when HOME env is unset on Windows';
}
else {
    is_run ｢
        BEGIN %*ENV<HOME>:delete;
        BEGIN %*ENV<HOMEDRIVE HOMEPATH> = ('C:', ｢\foobar｣);
        die unless $*HOME === Nil;
        $*HOME = 42; # can still assign to it
    ｣, {:out(''), :err(''), :0status },
    '$*HOME is Nil even when HOMEDRIVE+HOMEPATH are set on non-Windows dists';
}

is_run ｢
    BEGIN %*ENV<HOMEDRIVE HOMEPATH>:delete;
    BEGIN %*ENV<HOME> = ｢C:\foobar｣;
    die unless $*HOME.absolute eq ｢C:\foobar｣.IO.absolute;
    $*HOME = 42; # can still assign to it
｣, {:out(''), :err(''), :0status }, '$*HOME is HOME when HOME env is set';

is_run ｢
    BEGIN %*ENV<HOME HOMEDRIVE HOMEPATH>:delete;
    die unless $*HOME === Nil;
    $*HOME = 42; # can still assign to it
｣, {:out(''), :err(''), :0status }, '$*HOME is Nil when env is unset';

{
    my $before = $*HOME;
    {
        temp $*HOME = '/foo'.IO;
        is-path $*HOME, '/foo'.IO, 'was able to `temp` $*HOME';
    }
    is-path $*HOME, $before,
        '`temp`ed $*HOME got restored to previous value';
}

# vim: expandtab shiftwidth=4
