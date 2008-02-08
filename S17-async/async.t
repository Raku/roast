use v6-alpha;
use Test;



plan 8;

# try to stop duration of a simple async call
my $timestamp = time;

# L<S17/Threads>
async {
    ok 1, 'async call started';
};

my $async_duration = time - $timestamp;

# now if the follwing call is really asynchron, next time stop should
# be smaller than C<$async_duration + .5>

$timestamp = time;
my $thr = async {
    sleep 1;
};

ok time - $timestamp  < $async_duration + .5, "yes, 'Im out of sync!";

#?pugs todo :by<6.2.14>
ok $thr, 'stringify a thread';

#?pugs todo :by<6.2.14>
ok int $thr, 'numerify a thread should be the thread id';

isnt int $thr, $*PID, 'childs id is not parents thread id';

$thr.join;

# try two async calls to something
sub do_something_very_important {
    return 1;
}

async { ok do_something_very_important(),'very important: first try' };
async { ok do_something_very_important(),'very important: second try' };

# try to construct race condition
# see Stevens 'UNIX network programming' 23.17
my $counter = 0;
sub doit {
    my $val = $counter; sleep .0001; $counter = $val + 1;
}

loop (my $i = 0; $i < 500; $i++) {

    async { doit(); };
    async { doit(); };

}

ok $counter < 1000, 'the race condition strikes back';

#diag( $counter );
