use v6.d.PREVIEW;
use Test;

plan 19;

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
    throws-like { await @proms }, X::AdHoc, message => 'bust',
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
                    'Exception from awaiting many things, where on dies, does X::Await::Died';
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
