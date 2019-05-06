use v6;
use Test;

plan 26;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2s'} }, :at(now + 2));
    isa-ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1s'} }, :at(now + 1));
    isa-ok @c[*-1], Cancellation;
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
    isa-ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1s'} },
      :at(now + 1),
      :catch({ cas $tracker, {$_ ~ '1scatch'} })
    );
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "Cue on $name with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $tracker, "1s2s2scatch", "Timer tasks on $name :at/:catch ran in right order";
    LEAVE @c>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => Inf);
    }, "Can pass :at as Inf to ThreadPoolScheduler.cue without throwing";

    sleep 3;
    is $count, 0, "Passing :at as Inf to ThreadPoolScheduler.cue never runs the given block";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => -Inf);
    }, "Can pass :at as -Inf to ThreadPoolScheduler.cue without throwing";

    sleep 3;
    is $count, 1, "Passing :at as -Inf to ThreadPoolScheduler.cue instantly runs the given block";

    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::AdHoc, "Passing :at as NaN to ThreadPoolScheduler.cue throws", message => "Cannot set NaN as a number of seconds";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ $tracker ~= '2s'; }, :at(now + 2));
    ok @c && @c[*-1].can("cancel"), 'can we cancel (1)';
    push @c, $*SCHEDULER.cue({ $tracker ~= '1s'; }, :at(now + 1));
    ok @c && @c[*-1].can("cancel"), 'can we cancel (2)';
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
    ok @c && @c[*-1].can("cancel"), 'can we cancel (3)';
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '1s'; },
      :at(now + 1),
      :catch({ $tracker ~= '1scatch'})
    );
    ok @c && @c[*-1].can("cancel"), 'can we cancel (4)';
    is $tracker, '2s2scatch1s', "Cue on $name with :at/:catch *DOES* schedule immediately";
    LEAVE @c>>.cancel;
}

{
    my Int     $count  = 0;
    my Promise $p1    .= new;
    my Promise $p2    .= new;
    my Promise $p3    .= new;

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, at => Inf);
            $p1.keep;
            pass "Passing :at as Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as Inf to CurrentThreadScheduler.cue does not hang" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "Passing :at as Inf to CurrentThreadScheduler.cue never runs the given block";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, at => -Inf);
            $p2.keep;
            pass "Passing :at as -Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as -Inf to CurrentThreadScheduler.cue does not hang" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "Passing :at as -Inf to CurrentThreadScheduler.cue instantly runs the given block";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, at => NaN);
            $p3.keep;
            pass "Passing :at as NaN to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as NaN to CurrentThreadScheduler.cue does not hang" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::AdHoc, "Passing :at as NaN to CurrentThreadScheduler.cue throws", message => "Cannot set NaN as a number of seconds";
}
