use v6;
use Test;

plan 25;

{
    my $t = Thread.start({ 1 });
    isa_ok $t, Thread;
    $t.finish;
}

{
    my $t = Thread.start({
        pass "Code in thread ran";
    });
    $t.finish;
    pass "Thread was finished";
}

{
    my $tracker;
    my $t = Thread.start({
        $tracker = "in thread,";
    });
    $t.finish;
    $tracker ~= "finished";
    is $tracker, "in thread,finished", "Thread.finish does block";
}

{
    # This test is a vulnerable to freak conditions, like closing your laptop
    # at the exact wrong time. Also, if this test file hangs for ages at exit,
    # something is probably wrong with regard to this test.
    my $start = now;
    my $alt = Thread.start({ sleep 10000 }, :app_lifetime);
    ok now - $start < 10, "Starting app_lifetime thread that sleeps won't block main thread";
}

{
    my ($a, $b);
    my $t1 = Thread.start({ $a = 21 });
    my $t2 = Thread.start({ $b = 42 });
    isnt $t1.id, 0, "Thread 1 got non-zero ID";
    isnt $t2.id, 0, "Thread 2 got non-zero ID";
    isnt $t1.id, $t2.id, "Threads got different IDs";
    $t1.finish;
    $t2.finish;
    is $a, 21, "Thread 1 actually ran";
    is $b, 42, "Thread 2 also ran";
}

{
    my $t = Thread.start(:name("My little thready"), { 1 });
    is $t.name, "My little thready", "Has correct name";
    $t.finish;
    is $t.name, "My little thready", "Name doesn't vanish after finishing";
}

{
    my $t = Thread.start({ 1 });
    is $t.name, "<anon>", "Default thread name is <anon>";
    $t.finish;
}

{
    my $t1 = Thread.start({ 1 });
    ok $t1.Str ~~ /^ Thread '<' \d+ '>' '(<anon>)' $/,
        "Correct Thread stringification (anon case)";
    $t1.finish;
    my $t2 = Thread.start(:name('Magical threader'), { 1 });
    ok $t2.Str ~~ /^ Thread '<' \d+ '>' '(Magical threader)' $/,
        "Correct Thread stringification (name case)";
    $t2.finish;
}

{
    my ($t1id, $t2id);
    my $t1 = Thread.start({ $t1id = $*THREAD.id; });
    my $t2 = Thread.start({ $t2id = $*THREAD.id; });
    sleep 2; # wait for threads to start, a little fragile, yes
    is $t1id, $t1.id, 'Correct $*THREAD instance in thread 1 before finish';
    is $t2id, $t2.id, 'Correct $*THREAD instance in thread 2 before finish';
    $t1.finish;
    $t2.finish;
    is $t1id, $t1.id, 'Correct $*THREAD instance in thread 1 after finish';
    is $t2id, $t2.id, 'Correct $*THREAD instance in thread 2 after finish';
}

{
    isa_ok $*THREAD, Thread, '$*THREAD available in initial thread';
    isnt $*THREAD.id, 0, 'Initial thread has an ID';
}

{
    my $seen    = 0;
    my $threads = 3;
    my $times   = 10000;
    my @t = (1..$threads).map: { Thread.start({ cas $seen, {.succ} for ^$times}) };
    .finish for @t;
    ok 0 <= $seen <= $threads * $times, "we didn't segfault";
}

#?rakudo.moar skip "segfaults randomly"
{
    my %seen;
    my $threads = 3;
    my $times   = 10000;
    %seen{^$times} = (0 xx $times); # prime the hash
    my @t = (1..$threads).map: { Thread.start({
        cas %seen{$_}, {.succ} for ^$times;
    }) };
    .finish for @t;
    ok 0 <= ([+] %seen.values) <= $threads * $times, "we didn't segfault";
    unless
      is +%seen.keys, $times, 'did we get all keys'
    { .say for %seen.pairs.sort }
    is +%seen.values.grep({ 1 <= $_ <= $threads }), $times,
      'are all values in range';
}
