use Test;

plan 1;

{
    my $n           = 10000;
    my $n-threads   = 4;
    my $target      = 0;
    my $target-lock = Lock::Async.new;
    await start {
        for ^$n -> $i {
            $target-lock.protect: {
                $target += $i;
            }
        }
    } xx $n-threads;
    is $target, $n-threads * [+](^$n),
        'Lock::Async provides mutual exclusion when doing +=';
}

# vim: expandtab shiftwidth=4
