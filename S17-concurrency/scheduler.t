use v6;
use Test;

plan 54;

# real scheduling here
my $name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "$name does Scheduler role";

{
    my $x = False;
    $*SCHEDULER.cue({
        pass "Cued code on $name ran";
        $x = True;
    });
    1 while $*SCHEDULER.loads;
    ok $x, "Code was cued to $name by default";
}

{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    1 while $*SCHEDULER.loads;
    is $message, "oh noes", "$name setting uncaught_handler works";
}

{
    my $tracker;
    $*SCHEDULER.cue(
      { $tracker = 'cued,'; die "oops" },
      :catch( -> $ex {
          is $ex.message, "oops", "$name passed correct exception to handler";
          $tracker ~= 'caught';
      })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,caught", "Code run on $name, then handler";
}

{
    my $tracker;
    $*SCHEDULER.cue(
        { $tracker = 'cued,' },
        :catch( -> $ex { $tracker ~= 'caught' })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,", "Catch handler on $name not run if no error";
}

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    is $tracker, '', "Cue on $name with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :in ran in right order";
}

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
    is $tracker, '', "Cue on $name with :in/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s1scatch2s", "Timer tasks on $name:in/:catch ran in right order";
}

{
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    is $tracker, '', "Cue on $name with :at doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :at ran in right order";
}

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
    is $tracker, '', "Cue on $name with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s2scatch", "Timer tasks on $name :at/:catch ran in right order";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :every(0.1));
    sleep 1;
    diag "seen $a runs"
      if !ok 5 < $a < 15, "Cue with :every schedules repeatedly";
}

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

{
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :in(2), :every(0.1));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:in schedules repeatedly";
}

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

{
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :at(now + 2), :every(0.1));
    sleep 3;
    diag "seen $a runs" if !ok 5 < $a < 15,
      "Cue with :every/:at schedules repeatedly";
}

{
    my $tracker;
    $*SCHEDULER.cue({ $tracker++ }, :times(10));
    sleep 3;
    is $tracker, 10, "Cue on $name with :times(10)";
}

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

{
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)) },
      "$name cannot combine :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)) },
      "$name cannot combine :every with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)), :catch({...}) },
      "$name cannot combine :catch with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)), :catch({...}) },
      "$name cannot combine :every/:catch with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10)) },
      "$name cannot combine :every and :times";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :at(now + 2)) },
      "$name cannot combine :every and :times with :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :in(1)) },
      "$name cannot combine :every and :times with :in";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :catch({...})) },
      "$name cannot combine :every and :times with :catch";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $x = False;
    $*SCHEDULER.cue({
        pass "Cued code on $name ran";
        $x = True;
    });
    1 while $*SCHEDULER.loads;
    ok $x, "Code was cued to $name by default";
}

{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    1 while $*SCHEDULER.loads;
    is $message, "oh noes", "$name setting uncaught_handler works";
}

{
    my $tracker;
    $*SCHEDULER.cue(
      { $tracker = 'cued,'; die "oops" },
      :catch( -> $ex {
          is $ex.message, "oops", "$name passed correct exception to handler";
          $tracker ~= 'caught';
      })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,caught", "Code run on $name, then handler";
}

{
    my $tracker;
    $*SCHEDULER.cue(
        { $tracker = 'cued,' },
        :catch( -> $ex { $tracker ~= 'caught' })
    );
    1 while $*SCHEDULER.loads;
    is $tracker, "cued,", "Catch handler on $name not run if no error";
}

{
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    is $tracker, '2s1s', "Cue on $name with :in *DOES* schedule immediately";
}

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
    is $tracker, '2s1s1scatch', "Cue on $name with :in/:catch *DOES* schedule immediately";
}

{
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    is $tracker, '2s1s', "Cue on $name with :at *DOES* schedule immediately";
}

{
    my $tracker;
    $*SCHEDULER.cue({ $tracker++ }, :times(10));
    sleep 5;
    is $tracker, 10, "Cue on $name with :times(10)";
}

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
    is $tracker, '2s2scatch1s', "Cue on $name with :at/:catch *DOES* schedule immediately";
}

{
    dies_ok { $*SCHEDULER.cue({ ... }, :every(1)) },
      "$name cannot specify :every in CurrentThreadScheduler";
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)) },
      "$name cannot combine :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)) },
      "$name cannot combine :every with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)), :catch({...}) },
      "$name cannot combine :catch with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)), :catch({...}) },
      "$name cannot combine :every/:catch with :in and :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10)) },
      "$name cannot combine :every and :times";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :at(now + 2)) },
      "$name cannot combine :every and :times with :at";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :in(1)) },
      "$name cannot combine :every and :times with :in";
    dies_ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :catch({...})) },
      "$name cannot combine :every and :times with :catch";
}
