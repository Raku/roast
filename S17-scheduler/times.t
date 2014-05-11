use v6;
use Test;

plan 2;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = 0;
    $*SCHEDULER.cue({ cas $tracker, {.succ} }, :times(10));
    sleep 3;
    is $tracker, 10, "Cue on $name with :times(10)";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

{
    my $tracker;
    $*SCHEDULER.cue({ $tracker++ }, :times(10));
    sleep 5;
    is $tracker, 10, "Cue on $name with :times(10)";
}
