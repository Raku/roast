use v6;
use Test;

plan 25;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :in(2));
    isa-ok @c[*-1], Cancellation;
    append @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :in(1));
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :in doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s", "Timer tasks on $name with :in ran in right order";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2s'} },
      :in(2),
      :catch({ cas $tracker, { $_ ~ '2scatch'} })
    );
    isa-ok @c[*-1], Cancellation;
    append @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'}; die },
      :in(1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :in/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s1scatch2s", "Timer tasks on $name :in/:catch ran in right order";
    LEAVE @c>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => Inf);
    }, "Can pass :in as Inf to ThreadPoolScheduler.cue without throwing";

    sleep 3;
    is $count, 0, "Passing :in as Inf to ThreadPoolScheduler.cue never runs the given block";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => -Inf);
    }, "Can pass :in as -Inf to ThreadPoolScheduler.cue without throwing";

    sleep 3;
    is $count, 1, "Passing :in as -Inf to ThreadPoolScheduler.cue instantly runs the given block";

    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::AdHoc, "Passing :in as NaN to ThreadPoolScheduler.cue throws", message => "Cannot set NaN as a number of seconds";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue({ $tracker ~= '2s'; }, :in(2));
    ok @c[*-1].can("cancel"), 'can we cancel (1)';
    append @c, $*SCHEDULER.cue({ $tracker ~= '1s'; }, :in(1));
    ok @c[*-1].can("cancel"), 'can we cancel (2)';
    is $tracker, '2s1s', "Cue on $name with :in *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue(
      { $tracker ~= '2s'; },
      :in(2),
      :catch({ $tracker ~= '2scatch'})
    );
    ok @c[*-1].can("cancel"), 'can we cancel (3)';
    append @c, $*SCHEDULER.cue(
      { $tracker ~= '1s'; die },
      :in(1),
      :catch({ $tracker ~= '1scatch'})
    ) // ();
    ok @c[*-1].can("cancel"), 'can we cancel (4)';
    is $tracker, '2s1s1scatch', "Cue on $name with :in/:catch *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}

{
    my Int     $count  = 0;
    my Promise $p1    .= new;
    my Promise $p2    .= new;
    my Promise $p3    .= new;

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, in => Inf);
            $p1.keep;
            pass "Passing :in as Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as Inf to CurrentThreadScheduler.cue does not hang" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "Passing :in as Inf to CurrentThreadScheduler.cue never runs the given block";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, in => -Inf);
            $p2.keep;
            pass "Passing :in as -Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as -Inf to CurrentThreadScheduler.cue does not hang" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "Passing :in as -Inf to CurrentThreadScheduler.cue instantly runs the given block";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, in => NaN);
            $p3.keep;
            pass "Passing :in as NaN to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as NaN to CurrentThreadScheduler.cue does not hang" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::AdHoc, "Passing :in as NaN to CurrentThreadScheduler.cue throws", message => "Cannot set NaN as a number of seconds";
}
