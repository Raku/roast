use v6;
use Test;

plan 14;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :in(2));
    isa_ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :in(1));
    isa_ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :in ran in right order";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2s'} },
      :in(2),
      :catch({ cas $tracker, { $_ ~ '2scatch'} })
    );
    isa_ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'}; die },
      :in(1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    isa_ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :in/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s1scatch2s", "Timer tasks on $name:in/:catch ran in right order";
    LEAVE @c>>.cancel;
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    ok @c[*-1].can("cancel"), 'can we cancel (1)';
    push @c, $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    ok @c[*-1].can("cancel"), 'can we cancel (2)';
    is $tracker, '2s1s', "Cue on $name with :in *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '2s'; },
      :in(2),
      :catch({ $tracker ~= '2scatch'})
    );
    ok @c[*-1].can("cancel"), 'can we cancel (3)';
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '1s'; die },
      :in(1),
      :catch({ $tracker ~= '1scatch'})
    );
    ok @c[*-1].can("cancel"), 'can we cancel (4)';
    is $tracker, '2s1s1scatch', "Cue on $name with :in/:catch *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}
