use v6;
use Test;

plan 7;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = '';
    $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :at(now + 2));
    $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :at(now + 1));
    is $tracker, '', "Cue on $name with :at doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :at ran in right order";
}

{
    my $tracker = '';
    $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2s'}; die },
      :at(now + 2),
      :catch({ cas $tracker, {$_ ~ '2scatch'} })
    );
    $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'} },
      :at(now + 1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    is $tracker, '', "Cue on $name with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s2scatch", "Timer tasks on $name :at/:catch ran in right order";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $tracker = '';
    $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    is $tracker, '2s1s', "Cue on $name with :at *DOES* schedule immediately";
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
