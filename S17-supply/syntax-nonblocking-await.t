use v6.d.PREVIEW;
use Test;

plan 1;

{
    # Start 100 workers that do a `react`. This will, if `react` blocks,
    # clog up the thread pool.
    my $sup = Supplier.new;
    my $c = Channel.new;
    for ^100 {
        start {
            react {
                whenever $sup {
                    $c.send($_);
                    done;
                }
                $c.send("started");
            }
        }
    }

    # Ensure they're all started.
    $c.receive xx 100;

    # Start one more worker that will provide a value for all of the
    # reacts. If the thread pool is clogged, it won't get to run.
    await start { $sup.emit(2) }

    # Should now get all values sent.
    is [+](($c.receive xx 100)), 200, 'start react { ... } is non-blocking';
}
