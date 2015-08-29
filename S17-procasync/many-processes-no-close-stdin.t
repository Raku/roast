use v6;
use Test;

plan 1;

my $prog = $*DISTRO.is-win ?? 'ping' !! 'cat';
for ^1000 {
    my $proc = Proc::Async.new($prog, '/tmp/test-file', :w);

    my $promise = $proc.start;
    await $promise;
}

pass 'made it to the end';
