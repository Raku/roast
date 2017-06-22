use Test;

# This test covers a nasty once-bug involving callsame and Failure, where the
# finalization of Failure could steal the target of a callsame and so lead to
# delegation not taking place. Golfed from a bug report on OO::Monitors, which
# turned out to be a bug in Rakudo. This at the time of adding it would fail
# even without any GC stress applied provided a decent number of iterations
# are done (thus the 50 repetitions; it relies on unfortunate timing).

plan 50;

class Grid {
    has @.grid;

    method change-cell($x, $s) {
        @!grid[$x] = $s;
    }
}

my $leaving = 0;
Grid.^lookup('change-cell').wrap(-> \SELF, | {
    LEAVE ++$leaving;
    callsame
});

my $grid = Grid.new();
for ^50 {
    $grid.grid = 'BUG' xx 100;
    for ^(100 div 2) -> $x {
        Failure.new() // ''; # Triggered glitches
        $grid.change-cell($x * 2,     'a');
        $grid.change-cell($x * 2 + 1, 'b');
    }
    ok $grid.grid.join !~~ /BUG/, 'callsame + Failure glitch not observed';
}
