use v6;
use Test;

plan 1;

# RT #125616
for ^1000 {
    my $proc = Proc::Async.new('cat', '/tmp/test-file', :w);
    $proc.stdout.tap(-> $data {});
    my $p = $proc.start;
    $proc.close-stdin;
    await $p;
}

pass 'made it to the end';
