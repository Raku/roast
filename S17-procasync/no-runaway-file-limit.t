use v6.c;
use Test;

plan 1;

# RT #125616
my $prog   = $*DISTRO.is-win ?? 'cmd'   !! 'cat';
my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';
for ^1000 {
    my $proc = Proc::Async.new($prog, |@target, :w);
    $proc.stdout.tap(-> $data {});
    my $p = $proc.start;
    $proc.close-stdin;
    await $p;
}

pass 'made it to the end';
