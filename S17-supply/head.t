use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 9;

dies-ok { Supply.head }, 'can not be called as a class method';
dies-ok { Supply.new.head("foo") }, 'cannot have "foo" head';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..10).head, [1,], "head without argument works";
    tap-ok Supply.from-list(1..10).head(5), [1..5], "head five works";
    tap-ok Supply.from-list(1..10).head(15), [1..10], "head 15 works";
}

# RT #126824
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
    is $channel.list.join(', '), '42, 43, 44', 'RT #126824';
}

# vim: ft=perl6 expandtab sw=4
