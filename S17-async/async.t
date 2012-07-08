use v6;
use Test;

plan 17;

# L<S17/Threads>
# try to stop duration of a simple async call
my $timestamp = time;

async {
    ok 1, 'async call started';
};

my $async_duration = time - $timestamp;

# now if the follwing call is really asynchron, next time stop should
# be smaller than C<$async_duration + .5>

$timestamp = time;
my $thr = async {
    sleep .1;
};

ok time - $timestamp  < $async_duration + .5, "yes, 'Im out of sync!";

ok ~$thr, 'stringify a thread';

ok +$thr, 'numerify a thread should be the thread id';

isnt +$thr, $*PID, 'childs id is not parents thread id';

ok $thr.join, 'thread now joined and back home';

# L<S17/"Thread methods"/"=item join">
# two async calls should do something important
sub do_something_very_important {
    return 1;
}

my @threads;
@threads[0] = async { ok do_something_very_important(),'very important things from first thread' };
@threads[1] = async { ok do_something_very_important(),'very important things from second thread' };


ok  @threads[0].join,'first thread joined';
ok  @threads[1].join,'second thread joined';
# currently a second join on a joined thread waits forever; not good
#?pugs todo 'unimpl'
ok  eval q{#!@threads[1].join},'second thread not joinable again';

# L<S17/"Thread methods"/"=item detach">
#?pugs todo 'unimpl'
@threads[2] = async { ok do_something_very_important(),'again start a thread' };
ok eval q{threads[2].detach},'detach a thread';
#?pugs todo 'unimpl'
ok !@threads[2].join,'could not join a detached thread';

# L<S17/"Thread methods"/"=item suspend">
#?pugs skip 'unimpl'
@threads[3] = async { ok do_something_very_important(),'another thread' };
#?pugs todo 'unimpl'
ok eval q{@threads[3].suspend},' send him back to a waiting room..';

# L<S17/"Thread methods"/"=item resume">
#?pugs todo 'unimpl'
ok eval q{@threads[3].resume},'... now he is back';


# vim: ft=perl6
