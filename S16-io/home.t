use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# L<S16/IO/$*HOME>

plan 8;

BEGIN %*ENV<HOME> = $*TMPDIR.absolute;

isa-ok $*HOME, IO::Path,  '$*HOME contains IO::Path object';
lives-ok { $*HOME.perl }, '$*HOME.perl works';
lives-ok { $*HOME.gist }, '$*HOME.gist works';

if $*DISTRO.is-win {
    is_run ｢
        BEGIN %*ENV<HOME>:delete;
        BEGIN %*ENV<HOMEDRIVE HOMEPATH> = ('C:', ｢\foobar｣);
        die unless $*HOME.absolute eq ｢C:\foobar｣.IO.absolute;
    ｣, {:out(''), :err(''), :0status },
    '$*HOME is HOMEDRIVE+HOMEPATH when HOME env is unset on Windows';
}
else {
    is_run ｢
        BEGIN %*ENV<HOME>:delete;
        BEGIN %*ENV<HOMEDRIVE HOMEPATH> = ('C:', ｢\foobar｣);
        die unless $*HOME === Nil;
    ｣, {:out(''), :err(''), :0status },
    '$*HOME is Nil even when HOMEDRIVE+HOMEPATH are set on non-Windows dists';
}

is_run ｢
    BEGIN %*ENV<HOMEDRIVE HOMEPATH>:delete;
    BEGIN %*ENV<HOME> = ｢C:\foobar｣;
    die unless $*HOME.absolute eq ｢C:\foobar｣.IO.absolute;
｣, {:out(''), :err(''), :0status }, '$*HOME is HOME when HOME env is set';

is_run ｢
    BEGIN %*ENV<HOME HOMEDRIVE HOMEPATH>:delete;
    die unless $*HOME === Nil
｣, {:out(''), :err(''), :0status }, '$*HOME is Nil when env is unset';

{
    my $before = $*HOME;
    {
        temp $*HOME = '/foo'.IO;
        is-deeply $*HOME, '/foo'.IO, 'was able to `temp` $*HOME';
    }
    is-deeply $*HOME, $before,
        '`temp`ed $*HOME got restored to previous value';
}
