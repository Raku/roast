use v6;
use Test;

plan 9;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1));
    sleep 1;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every schedules repeatedly";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :catch({ cas $b, {.succ} }));
    sleep 1;
    diag "seen $a runs" if !
      ok 3 < $a < 15, "Cue with :every/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 3 < $b < 15, "Cue with :every/:catch schedules repeatedly (2)";
}

{
    my $a = 0;
    $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :in(2));
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:in schedules repeatedly";
}

{
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ cas $a,{.succ}; die }, :every(0.1), :in(2), :catch({ cas $b, {.succ} }));
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:in/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 5 < $b < 15, "Cue with :every/:in/:catch schedules repeatedly (2)";
}

{
    my $a = 0;
    $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :at(now + 2));
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:at schedules repeatedly";
}

{
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :at(now + 2), :catch({ cas $b, {.succ} }));
    sleep 3;
    diag "seen $a runs" if !
      ok 5 < $a < 15, "Cue with :every/:at/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !
      ok 5 < $b < 15, "Cue with :every/:at/:catch schedules repeatedly (2)";
}
