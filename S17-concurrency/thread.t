use v6;
use Test;

plan 19;

{
    my $t = Thread.start({ 1 });
    isa_ok $t, Thread;
    $t.join();
}

{
    my $t = Thread.start({
        pass "Code in thread ran";
    });
    $t.join();
    pass "Thread was joined";
}

{
    my $tracker;
    my $t = Thread.start({
        $tracker = "in thread,";
    });
    $t.join();
    $tracker ~= "joined";
    is $tracker, "in thread,joined", "Thread.join does block";
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
    $t1.join();
    $t2.join();
    is $a, 21, "Thread 1 actually ran";
    is $b, 42, "Thread 2 also ran";
}

{
    my $t = Thread.start(:name("My little thready"), { 1 });
    is $t.name, "My little thready", "Has correct name";
    $t.join();
    is $t.name, "My little thready", "Name doesn't vanish after joining";
}

{
    my $t = Thread.start({ 1 });
    is $t.name, "<anon>", "Default thread name is <anon>";
    $t.join();
}

{
    my $t1 = Thread.start({ 1 });
    ok $t1.Str ~~ /^ Thread '<' \d+ '>' '(<anon>)' $/,
        "Correct Thread stringification (anon case)";
    $t1.join();
    my $t2 = Thread.start(:name('Magical threader'), { 1 });
    ok $t2.Str ~~ /^ Thread '<' \d+ '>' '(Magical threader)' $/,
        "Correct Thread stringification (name case)";
    $t2.join();
}

{
    my ($t1id, $t2id);
    my $t1 = Thread.start({ $t1id = $*THREAD.id; });
    my $t2 = Thread.start({ $t2id = $*THREAD.id; });
    $t1.join();
    $t2.join();
    is $t1id, $t1.id, 'Correct $*THREAD instance in thread 1';
    is $t2id, $t2.id, 'Correct $*THREAD instance in thread 2';
}

{
    isa_ok $*THREAD, Thread, '$*THREAD available in initial thread';
    isnt $*THREAD.id, 0, 'Initial thread has an ID';
}
