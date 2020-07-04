use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 21;

dies-ok { Supply.head }, 'can not be called as a class method';
dies-ok { Supply.new.head("foo") }, 'cannot have "foo" head';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).head, [1,], "head without argument works";
    tap-ok Supply.from-list(1..10).head(0), [], "head zero works";
    tap-ok Supply.from-list(1..10).head(-10), [], "head minus ten works";
    tap-ok Supply.from-list(1..10).head(5), [1..5], "head five works";

    for \(15), \(*), \(Inf) -> \c {
        tap-ok Supply.from-list(1..10).head(|c), [1..10],
          "head {c.raku.substr(1)}  works";
    }

    tap-ok Supply.from-list(1..10).head(*-3), [1..7], "head minus three works";
    tap-ok Supply.from-list(1..10).head(*-15), [], "head minus fifteen works";
}

# https://github.com/Raku/old-issue-tracker/issues/4824
{
    my $channel = Channel.new;
    my $f = Supplier.new;
    my $s = $f.Supply.head(1);
    my $t = $s.tap(
        -> $ { $channel.send(42) },
        done => {$channel.send(43) },
    );
    my $p = $s.Promise;
    start {
        for 0..3 {
            $f.emit(42)
        };
        $f.done();
    }
    await $p;
    $channel.send(44);
    $channel.close;
    is $channel.list.join(', '), '42, 43, 44', 'does indeed fire';
}

# vim: expandtab shiftwidth=4
