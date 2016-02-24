use v6.c;
use Test;

plan 1;

my $prog   = $*DISTRO.is-win ?? 'cmd'   !! 'cat';
my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';

for ^1000 {
    my $proc = Proc::Async.new($prog, |@target, :w);

    my $promise = $proc.start;
    await $promise;
}

pass 'made it to the end';
