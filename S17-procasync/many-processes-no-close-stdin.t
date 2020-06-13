use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

is_run ｢
    my $prog   = $*DISTRO.is-win ?? 'cmd'   !! 'cat';
    my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';

    for ^1000 {
        my $proc = Proc::Async.new($prog, |@target, :w);

        my $promise = $proc.start;
        await $promise;
    }

    print 'pass'
｣, {:out<pass>, :err(''), :0status}, 'made it to the end';

# vim: expandtab shiftwidth=4
