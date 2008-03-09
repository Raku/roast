use v6-alpha;
use Test;

plan 10;

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

# two async calls should do something important
sub do_something_very_important {
    return 1;
}

my @threads;
@threads[0] = async { ok do_something_very_important(),'very important things from first thread' };
@threads[1] = async { ok do_something_very_important(),'very important things from second thread' };


ok  @threads[0].join,'first thread joined';
ok  @threads[1].join,'second thread joined';
# race condition test moved to L<content.t>
