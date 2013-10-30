use v6;
use Test;

plan 10;

ok $*SCHEDULER ~~ Scheduler, "Default scheduler does Scheduler role";

{
    my $x = False;
    $*SCHEDULER.schedule({
        pass "Scheduled code ran";
        $x = True;
    });
    1 while $*SCHEDULER.outstanding;
    ok $x, "Code was scheduled on another thread by default";
}

{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.schedule({ die "oh noes" });
    1 while $*SCHEDULER.outstanding;
    is $message, "oh noes", "setting uncaught_handler works";
}

{
    my $tracker;
    $*SCHEDULER.schedule_with_catch(
        {
            $tracker = 'scheduled,';
            die "oops";
        },
        -> $ex {
            is $ex.message, "oops", "Correct exception passed to handler";
            $tracker ~= 'caught';
        });
    1 while $*SCHEDULER.outstanding;
    is $tracker, "scheduled,caught", "Code run, then handler";
}

{
    my $tracker;
    $*SCHEDULER.schedule_with_catch(
        {
            $tracker = 'scheduled,';
        },
        -> $ex {
            $tracker ~= 'caught';
        });
    1 while $*SCHEDULER.outstanding;
    is $tracker, "scheduled,", "Handler not run if no error";
}

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    $*SCHEDULER.schedule_in({ $tracker ~= '2s'; }, 2);
    $*SCHEDULER.schedule_in({ $tracker ~= '1s'; }, 1);
    is $tracker, '', "schedule_in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks ran in right order";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    $*SCHEDULER.schedule_every({ $a++ }, 0.1);
    sleep 1;
    ok 5 < $a < 15, "schedule_every schedules repeatedly";
}
