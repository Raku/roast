use v6.d.PREVIEW;
use Test;

plan 9;

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

{
    sub death() {
        die "goodbye!"
    }
    sub i-will-die() {
        supply {
            whenever Supply.interval(0.001) {
                death()
            }
        }
    }
    sub i-will-react() {
        react {
            whenever i-will-die() { }
        }
    }
    i-will-react();
    CATCH {
        default {
            ok .does(X::React::Died),
                'An exception from a react that dies does X::React::Died';
            like .gist, /'goodbye!'/,
                'Exception report contains original message';
            like .gist, /'death'/,
                'Exception report contains original location';
            like .gist, /'i-will-react'/,
                'Exception report contains react location';
        }
    }
}

lives-ok { await start react { await Promise.in(0.1) } },
    'An await in the mainline of a react on the threadpool works';
lives-ok { await start react { await Promise.in(0.1), Promise.in(0.1) } },
    'An await of two things in the mainline of a react on the threadpool works';

lives-ok { my $s = supply { await Promise.in(0.1) }; react whenever $s { } },
    'An await in a supply tapped by a react lives';
lives-ok { my $s = supply { await Promise.in(0.1), Promise.in(0.2) }; react whenever $s { } },
    'An await of two things in a supply tapped by a react lives';
