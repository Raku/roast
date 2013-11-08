use v6;
use Test;

plan 10;

ok $*SCHEDULER ~~ Scheduler, "Default scheduler does Scheduler role";

{
    my $x = False;
    $*SCHEDULER.cue({
        pass "Cued code ran";
        $x = True;
    });
    1 while $*SCHEDULER.outstanding;
    ok $x, "Code was cued on another thread by default";
}

{
    my $message;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $message = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    1 while $*SCHEDULER.outstanding;
    is $message, "oh noes", "setting uncaught_handler works";
}

{
    my $tracker;
    $*SCHEDULER.cue_with_catch(
        {
            $tracker = 'cued,';
            die "oops";
        },
        -> $ex {
            is $ex.message, "oops", "Correct exception passed to handler";
            $tracker ~= 'caught';
        });
    1 while $*SCHEDULER.outstanding;
    is $tracker, "cued,caught", "Code run, then handler";
}

{
    my $tracker;
    $*SCHEDULER.cue_with_catch(
        {
            $tracker = 'cued,';
        },
        -> $ex {
            $tracker ~= 'caught';
        });
    1 while $*SCHEDULER.outstanding;
    is $tracker, "cued,", "Handler not run if no error";
}

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    is $tracker, '', "cue with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks ran in right order";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    $*SCHEDULER.cue({ $a++ }, :every(0.1));
    sleep 1;
    ok 5 < $a < 15, "schedule_every schedules repeatedly";
}
