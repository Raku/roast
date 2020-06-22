use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4403
is_run ｢
    my $prog   = $*DISTRO.is-win ?? 'cmd'   !! 'cat';
    my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';
    for ^1000 {
        my $proc = Proc::Async.new($prog, |@target, :w);
        $proc.stdout.tap(-> $data {});
        my $p = $proc.start;
        $proc.close-stdin;
        await $p;
    }
    print 'pass'
｣, {:out<pass>, :err(''), :0status}, 'made it to the end';

# vim: expandtab shiftwidth=4
