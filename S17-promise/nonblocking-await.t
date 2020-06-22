use v6.d;
use Test;

plan 28;

# Limit scheduler to just 4 real threads, so we'll clearly be needing the
# non-blocking await support for these to pass.
PROCESS::<$SCHEDULER> := ThreadPoolScheduler.new(max_threads => 4);

{
    sub conc-fib($n) {
        start {
            $n <= 1
                ?? 1
                !! await(conc-fib($n - 2)) + await(conc-fib($n - 1))
        }
    }
    is await(conc-fib(15)), 987, 'Recursion creating a deep await-tree completes correctly';
}

{
    sub conc-fib($n) {
        start {
            $n <= 1
                ?? die "oopsy"
                !! await(conc-fib($n - 2)) + await(conc-fib($n - 1))
        }
    }
    #?rakudo.jvm skip 'hangs on JVM'
    throws-like { await(conc-fib(15)) }, Exception,
        message => "oopsy",
        'Deep Promise tree conveys exception up to the top';
}

{
    my @proms = (1..100).map: {
        start {
            await Promise.in(0.01);
            await Promise.in(0.05);
            $_
        }
    };
    is ([+] await @proms), 5050, 'Hundreds of time-based Promises awaited completes correctly';
}

{
    my $p = Promise.new;
    my @proms = (1..100).map: {
        start {
            await Promise.in(0.1), $p;
            $_
        }
    };
    sleep 0.15;
    ok [==](flat Planned, @proms>>.status), 'await of multiple Promises suspends until all ready';
    $p.keep;
    is ([+] await @proms), 5050, 'Hundred of await on time/manual Promise completes corectly';
}

{
    my $p = Promise.new;
    my @proms = (1..100).map: {
        start {
            await Promise.in(0.1), $p;
            $_
        }
    };
    sleep 0.15;
    ok [==](flat Planned, @proms>>.status), 'await of multiple Promises suspends until all ready';
    $p.break('bust');
    #?rakudo.jvm skip 'hangs on JVM (sometimes)'
    throws-like { await @proms }, Exception, message => 'bust',
        'Multiple await also conveys errors correctly';
}

{
    my @proms = (1..100).map: -> $i {
        start {
            await supply { whenever Supply.interval(0.001 * $i) { emit $i; done } }
        }
    };
    #?rakudo.jvm skip 'hangs on JVM'
    is ([+] await @proms), 5050, 'Hundred of outstanding awaits on supplies works';
}

{
    my @proms = (1..100).map: -> $i {
        start {
            await supply {
                whenever Supply.interval(0.001 * $i) {
                    $i > 50
                        ?? die 'strewth'
                        !! done
                }
            }
        }
    };
    #?rakudo.jvm skip 'hangs on JVM'
    throws-like { await @proms }, Exception, message => 'strewth',
        'Hundred of outstanding awaits on supplies that die works';
}

{
    my $c = Channel.new;
    my @proms = (1..100).map: -> $i {
        start {
            await($c) + await($c)
        }
    };
    for 1..200 {
        $c.send($_);
    }
    #?rakudo.jvm skip 'hangs on JVM'
    is ([+] await @proms), 20100, 'Hundred of outstanding awaits on channels works';
}

{
    my $c = Channel.new;
    my @proms = (1..100).map: -> $i {
        start {
            await($c) + await($c)
        }
    };
    for 1..100 {
        $c.send($_);
    }
    $c.close;
    #?rakudo.jvm skip 'hangs on JVM'
    throws-like { await @proms }, X::Channel::ReceiveOnClosed,
        'Hundred of outstanding awaits on channels that gets closed works';
}

#?rakudo.jvm skip 'hangs on JVM'
{
    sub death-bar() {
        die "golly!";
    }
    sub foo() {
        start { death-bar() }
    }

    {
        sub waiting-for-it() {
            await foo()
        }
        waiting-for-it;
        CATCH {
            default {
                ok .does(X::Await::Died),
                    'Exception from awaiting broken Promise does X::Await::Died';
                like .gist, /'golly!'/,
                    'Exception contains original exception message';
                like .gist, /'death-bar'/,
                    'Exception contains stack location where Promise code died';
                like .gist, /'waiting-for-it'/,
                    'Exception contains stack location where we awaited';
            }
        }
    }

    {
        my $p = Promise.new;
        $p.keep(42);
        sub waiting-for-them() {
            await $p, foo();
        }
        waiting-for-them;
        CATCH {
            default {
                ok .does(X::Await::Died),
                    'Exception from awaiting many things, where one dies, does X::Await::Died';
                like .gist, /'golly!'/,
                    'Exception contains original exception message';
                like .gist, /'death-bar'/,
                    'Exception contains stack location where Promise code died';
                like .gist, /'waiting-for-them'/,
                    'Exception contains stack location where we awaited';
            }
        }
    }
}

# Should not attempt non-blocking await when a lock is held.
{
    # Try to create good chance of resume on a different thread.
    my $l = Lock.new;
    my $p1 = start {
        sleep 0.5;
    }
    my $p2 = start {
        $l.protect: {
            sleep 0.1;
            await $p1;
        }
    }
    my @ps = start { } xx 20;
    lives-ok { await $p1, $p2, @ps },
        'No error due to trying to do non-blocking await when lock held (protect)';
}
{
    # Same test as above except without .protect
    my $l = Lock.new;
    my $p1 = start {
        sleep 0.5;
    }
    my $p2 = start {
        $l.lock();
        sleep 0.1;
        await $p1;
        $l.unlock();
    }
    my @ps = start { } xx 20;
    lives-ok { await $p1, $p2, @ps },
        'No error due to trying to do non-blocking await when lock held (lock/unlock)';
}

# https://github.com/Raku/old-issue-tracker/issues/6046
#?rakudo.jvm skip 'UnwindException'
{
    my $kill = Promise.new;
    my $started = Promise.new;
    my $s-address = '0.0.0.0';
    my $c-address = '127.0.0.1';
    my $port = 4893;
    my $ok = start react {
        whenever IO::Socket::Async.listen($s-address, $port) -> $conn {
            whenever $conn.Supply(:bin) -> $buf {
                await $conn.write: $buf;
                $conn.close;
            }
        }
        whenever $kill { done }
        $started.keep;
    }

    await $started;
    my @responses;
    for ^20 {
        react {
            whenever IO::Socket::Async.connect($c-address, $port) -> $client {
                await $client.write('is this thing on?'.encode('ascii'));
                whenever $client.Supply(:bin) {
                    push @responses, .decode('ascii');
                    $client.close;
                }
            }
        }
    }
    $kill.keep;
    lives-ok { await $ok }, 'Server survived';
    ok @responses == 20, 'Got 20 responses from async socket server that does non-blocking await';
    is @responses[0], 'is this thing on?', 'First response correct';
    ok [eq](@responses), 'Rest of responses also correct';
}

# https://github.com/Raku/old-issue-tracker/issues/6521
{
    my @foo = do {
        await start { do for ^2 { my uint64 @ = 9, 9; }.Slip },
              start { do for ^2 { my uint64 @ = 1, 2; }.Slip };
    }
    is @foo.elems, 4, "slips awaited over get flattened out";
}
{
  await start {
    my @foo = do {
        await start { do for ^2 { my uint64 @ = 9, 9; }.Slip },
              start { do for ^2 { my uint64 @ = 1, 2; }.Slip };
    }
    is @foo.elems, 4, "slips awaited over get flattened out";
  }
}

#?rakudo.jvm skip 'atomicint NYI'
{ # https://github.com/rakudo/rakudo/issues/1323
    # Await must be called in sink context here to trigger the covered bug.
    # Gymnastics with atomic ints are just to reduce test runtime; the point
    # of the test is that await awaits in this case for all Promises to
    # complete instead of just returning immediately.
    # (same test exists in 6.c tests on purpose; to cover Rakudo impl)
    my atomicint $x;
    sub p { start { sleep .3; $x⚛++ } }
    await (((p(), (p(), (p(),))), (p(), p(), p())), (p(), p(), p()));
    is-deeply $x, 9, '&await awaits in sink context, with nested iterables';
}

# vim: expandtab shiftwidth=4
