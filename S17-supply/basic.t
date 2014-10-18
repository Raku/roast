use v6;

use Test;

plan 22;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supply.new;
    
        my @vals;
        my $saw_done;
        my $tap = $s.tap( -> $val { @vals.push($val) },
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
        my $s = Supply.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $s.tap(-> $val { @tap1_vals.push($val) });

        $s.emit(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $s.tap(-> $val { @tap2_vals.push($val) });
        $s.emit(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        ok $tap1.close, "did the close of the first tap work";
        $s.emit(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
        ok $tap2.close, "did the close of the second tap work";
    }
}
