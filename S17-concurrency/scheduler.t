use v6;
use Test;

plan 7;

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
