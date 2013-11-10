use v6;
use Test;

plan 28;

#?rakudo.parrot skip 'NYI'
ok $*SCHEDULER ~~ Scheduler, "Default scheduler does Scheduler role";

#?rakudo.parrot skip 'NYI'
{
    my $x = False;
    $*SCHEDULER.cue({
        pass "Cued code ran";
        $x = True;
    });
    1 while $*SCHEDULER.loads;
    ok $x, "Code was cued on another thread by default";
}

#?rakudo.parrot skip 'NYI'
{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    1 while $*SCHEDULER.loads;
    is $message, "oh noes", "setting uncaught_handler works";
}

#?rakudo.parrot skip 'NYI'
{
    my $tracker;
    $*SCHEDULER.cue(
      { $tracker = 'cued,'; die "oops" },
      :catch( -> $ex {
          is $ex.message, "oops", "Correct exception passed to handler";
          $tracker ~= 'caught';
      })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,caught", "Code run, then handler";
}

#?rakudo.parrot skip 'NYI'
{
    my $tracker;
    $*SCHEDULER.cue(
        { $tracker = 'cued,' },
        :catch( -> $ex { $tracker ~= 'caught' })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,", "Handler not run if no error";
}

#?rakudo.parrot skip 'NYI'
{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    is $tracker, '', "Cue with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks with :in ran in right order";
}

#?rakudo.parrot skip 'NYI'
{
    my $tracker = '';
    $*SCHEDULER.cue(
      { $tracker ~= '2s'; },
      :in(2),
      :catch({ $tracker ~= '2scatch'})
    );
    $*SCHEDULER.cue(
      { $tracker ~= '1s'; die },
      :in(1),
      :catch({ $tracker ~= '1scatch'})
    );
    is $tracker, '', "Cue with :in and :catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s1scatch2s", "Timer tasks :in/:catch ran in right order";
}

#?rakudo.parrot skip 'NYI'
{
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    is $tracker, '', "Cue with :at doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks with :at ran in right order";
}

#?rakudo.parrot skip 'NYI'
{
    my $tracker = '';
    $*SCHEDULER.cue(
      { $tracker ~= '2s'; die },
      :at(now + 2),
      :catch({ $tracker ~= '2scatch'})
    );
    $*SCHEDULER.cue(
      { $tracker ~= '1s'; },
      :at(now + 1),
      :catch({ $tracker ~= '1scatch'})
    );
    is $tracker, '', "Cue with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s2scatch", "Timer tasks :at/:catch ran in right order";
}

#?rakudo.parrot skip 'NYI'
{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :every(0.1));
    sleep 1;
    diag "seen $a runs"
      if !ok 5 < $a < 15, "Cue with :every schedules repeatedly";
}

#?rakudo.parrot skip 'NYI'
{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ $a++; die }, :every(0.1), :catch({ $b++ }));
    sleep 1;
    diag "seen $a runs"
      if !ok 5 < $a < 15, "Cue with :every/:catch schedules repeatedly (1)";
    diag "seen $b deaths"
      if !ok 5 < $b < 15, "Cue with :every/:catch schedules repeatedly (2)";
}

#?rakudo.parrot skip 'NYI'
{
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :in(2), :every(0.1));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:in schedules repeatedly";
}

#?rakudo.parrot skip 'NYI'
{
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ $a++; die }, :in(2), :every(0.1), :catch({ $b++ }));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:in/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !ok 5 < $b < 15,
      "Cue with :every/:in/:catch schedules repeatedly (2)";
}

#?rakudo.parrot skip 'NYI'
{
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :at(now + 2), :every(0.1));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:at schedules repeatedly";
}

#?rakudo.parrot skip 'NYI'
{
    my $a = 0;
    my $b = 0;
    $*SCHEDULER.cue({ $a++; die }, :at(now + 2), :every(0.1), :catch({ $b++ }));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:at/:catch schedules repeatedly (1)";
    diag "seen $b deaths" if !ok 5 < $b < 15,
      "Cue with :every/:at/:catch schedules repeatedly (2)";
}

#?rakudo.parrot skip 'NYI'
{
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)) },
      'cannot combine :in and :at';
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)) },
      'cannot combine :every with :in and :at';
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)), :catch({...}) },
      'cannot combine :catch with :in and :at';
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)), :catch({...}) },
      'cannot combine :every/:catch with :in and :at';
}
