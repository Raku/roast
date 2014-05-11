use v6;
use Test;

plan 32;

# real scheduling here
my $name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "$name does Scheduler role";

{
    my $loads = $*SCHEDULER.loads;
    ok $loads == 0, "$name returns a value before cuing";
}


#?rakudo skip "waiting for new '.loads' semantics"
{
    my $x = False;
    $*SCHEDULER.cue({
        pass "Cued code on $name ran";
        $x = True;
    });
    1 while $*SCHEDULER.loads;
    ok $x, "Code was cued to $name by default";
}

#?rakudo skip "waiting for new '.loads' semantics"
{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    1 while $*SCHEDULER.loads;
    is $message, "oh noes", "$name setting uncaught_handler works";
}

#?rakudo skip "waiting for new '.loads' semantics"
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

#?rakudo skip "waiting for new '.loads' semantics"
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
