use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 78;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supplier.new;

        my @vals;
        my $saw_done;
        my $tap = $s.Supply.tap( -> $val { @vals.push($val) },
          done => { $saw_done = True });

        $s.emit(1);
        is ~@vals, "1", "Tap got initial value";
        nok $saw_done, "No done yet";

        $s.emit(2);
        $s.emit(3);
        $s.done;
        is ~@vals, "1 2 3", "Tap saw all values";
        ok $saw_done, "Saw done";
    }

    {
        my $s = Supplier.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $s.Supply.tap(-> $val { @tap1_vals.push($val) });

        $s.emit(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $s.Supply.tap(-> $val { @tap2_vals.push($val) });
        $s.emit(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        ok $tap1.close, "did the close of the first tap work";
        $s.emit(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
        ok $tap2.close, "did the close of the second tap work";
    }

    my $p = Supplier.new;
    lives-ok { $p.emit(1) }, 'Can emit to publisher with no supply taken';

    my $s1 = $p.Supply;
    lives-ok { $p.emit(1) }, 'Can emit to publisher with supply untapped';

    {
        my (@emitted, $done, $quit);
        my $t1 = $s1.tap({@emitted.push($_)}, done => {$done++}, quit => {$quit++});

        is @emitted, [], 'Right after tapping, nothing emitted';
        nok $done, 'Right after tapping, no done';
        nok $quit, 'Right after tapping, no quit';

        $p.emit(42);
        is @emitted, [42], 'Correct first event emitted';
        nok $done, 'Not yet done';
        nok $quit, 'Not quit';

        $p.emit(44);
        is @emitted, [42, 44], 'Correct second event emitted';

        $p.done();
        is @emitted, [42, 44], 'done does not emit events';
        ok $done, 'done callback fires';
        nok $quit, 'quit callback does not fire';

        # RT #123477
        $p.emit(46);
        is @emitted, [42, 44], 'no further events after done';

        $t1.close;
    }

    my $s2;
    lives-ok { $s2 = $p.Supply }, 'Can take second Supply from Supplier';

    {
        my (@emitted, $done, $quit);
        my $t1 = $s2.tap({@emitted.push($_)}, done => {$done++}, quit => {$quit++});

        is @emitted, [], 'Right after tapping, nothing emitted (second supply)';
        nok $done, 'Right after tapping, no done (second supply)';
        nok $quit, 'Right after tapping, no quit (second supply)';

        $p.emit(42);
        is @emitted, [42], 'Correct first event emitted (second supply)';
        nok $done, 'Not yet done (second supply)';
        nok $quit, 'Not quit (second supply)';

        $p.emit(44);
        is @emitted, [42, 44], 'Correct second event emitted (second supply)';

        $p.quit(X::AdHoc.new);
        is @emitted, [42, 44], 'quit does not emit events';
        nok $done, 'done callback does not fire';
        ok $quit, 'quit callback fires';

        # RT #123477
        $p.emit(46);
        is @emitted, [42, 44], 'no further events after quit';

        $t1.close;
    }

    # RT #126379
    {
        is_run q[Supply.interval(1).tap(-> { say 'hi' }); sleep 3;], {
            status => 1,
            err => /
                'Unhandled exception in code scheduled on thread' .+
                'Too many positionals' .+ 'expected 0 arguments but got 1'
            /
        }, '.tap block with incorrect signature must fail';
    }

    # RT #128968
    subtest 'can use .emit as a method' => {
        plan 3;
        react { whenever supply { .emit for "foo", 42, .5 } {
            pass "can .emit {.^name} ($_)";
        }}
    }

    # RT #130919
    subtest 'call done/quit on all taps' => {
        plan 2;

        {
            my $supplier = Supplier.new;
            my $supply   = $supplier.Supply;

            my @done;
            $supply.tap: done => { @done.push(1) }
            $supply.tap: done => { @done.push(1) }
            $supplier.done;

            is +@done, 2, 'All done callbacks were called';
        }

        {
            my $supplier = Supplier.new;
            my $supply   = $supplier.Supply;

            my @quit;
            $supply.tap: quit => { @quit.push($_) }
            $supply.tap: quit => { @quit.push($_) }
            $supplier.quit(1);

            is +@quit, 2, 'All quit callbacks were called';
        }
    }
}

# vim: ft=perl6 expandtab sw=4
