use v6;
use Test;

plan 6;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :in(2));
    $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :in(1));
    is $tracker, '', "Cue on $name with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :in ran in right order";
}

{
    my $tracker = '';
    $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2s'} },
      :in(2),
      :catch({ cas $tracker, { $_ ~ '2scatch'} })
    );
    $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'}; die },
      :in(1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    is $tracker, '', "Cue on $name with :in/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s1scatch2s", "Timer tasks on $name:in/:catch ran in right order";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

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
