use v6;
use Test;

plan 25;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Also at risk of being a little fragile, but again hopefully OK on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1));
    isa-ok $c, Cancellation;
    sleep 1;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every schedules repeatedly";
    LEAVE $c.cancel;
}

{
    # Also at risk of being a little fragile, but again hopefully OK on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $stop;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :stop({$stop}));
    isa-ok $c, Cancellation;
    sleep 1;
    $stop = True;

    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every :stop schedules repeatedly";
    my $seen = $a;
    diag "seen {$a - $seen} runs after stop" if !
      ok $seen <= $a <= $seen + 1, "Cue with :every :stop stops scheduling";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 1;
    diag "seen $a runs" if !
      ok 3 < $a < 15, "Cue with :every/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 3 < $b < 15, "Cue with :every/:catch schedules repeatedly (2)";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :in(2));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:in schedules repeatedly";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a,{.succ}; die }, :every(0.1), :in(2), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:in/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 5 < $b < 15, "Cue with :every/:in/:catch schedules repeatedly (2)";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :at(now + 2));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:at schedules repeatedly";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :10times);
    isa-ok $c, Cancellation;
    sleep 3;
    diag "seen $a runs" if !
      is $a, 10, "Cue with :every/:times schedules repeatedly for 10 times";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :at(now + 2), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:at/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 5 < $b < 15, "Cue with :every/:at/:catch schedules repeatedly (2)";
    LEAVE $c.cancel;
}

{
    my Cancellation $c1;
    my Cancellation $c2;
    my Cancellation $c3;
    my Int          $count = 0;

    lives-ok {
        $c1 = $*SCHEDULER.cue({ cas $count, { .succ } }, every => Inf);
    }, "Can pass :every as Inf without throwing";
    sleep 3;
    #?rakudo.jvm todo 'fails more often than it passes'
    is $count, 1, "Passing :every as Inf immediately runs the given block once";

    lives-ok {
        $c2 = $*SCHEDULER.cue({ cas $count, { .succ } }, every => -Inf);
    }, "Can pass :every as -Inf without throwing";
    sleep 3;
    cmp-ok $count, '>', 0, "Passing :every as -Inf immediately runs the given block";

    throws-like {
        $c3 = $*SCHEDULER.cue(-> { }, every => NaN);
    }, X::Scheduler::CueInNaNSeconds, "Passing :at as NaN throws";

    $c1.cancel if $c1.defined;
    $c2.cancel if $c2.defined;
    $c3.cancel if $c3.defined;
}

# vim: expandtab shiftwidth=4
