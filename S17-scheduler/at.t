use v6;
use Test;

plan 15;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :at(now + 2));
    isa_ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :at(now + 1));
    isa_ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :at doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :at ran in right order";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2s'}; die },
      :at(now + 2),
      :catch({ cas $tracker, {$_ ~ '2scatch'} })
    );
    isa_ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'} },
      :at(now + 1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    isa_ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s2scatch", "Timer tasks on $name :at/:catch ran in right order";
    LEAVE @c>>.cancel;
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    ok @c[*-1].can("cancel"), 'can we cancel (1)';
    push @c, $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    ok @c[*-1].can("cancel"), 'can we cancel (2)';
    is $tracker, '2s1s', "Cue on $name with :at *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '2s'; die },
      :at(now + 2),
      :catch({ $tracker ~= '2scatch'})
    );
    #?rakudo todo "huh?"
    ok @c[*-1].can("cancel"), 'can we cancel (3)';
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '1s'; },
      :at(now + 1),
      :catch({ $tracker ~= '1scatch'})
    );
    ok @c[*-1].can("cancel"), 'can we cancel (4)';
    is $tracker, '2s2scatch1s', "Cue on $name with :at/:catch *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}
