use v6-alpha;
use Test;

plan 2;

#L<S17/Co-Routines>
# play ping pong
my $matchreport = '';
coro ping {
    state $call_counter;
    return $matchreport if ++$call_counter > 2;
    $matchreport ~= 'ping';
    yield pong();
}

coro pong {
    $matchreport ~= 'pong';
    yield ping();
}
is( ping(),'pingpongpingpong','playing ping pong');

# example from wikipedia
# http://en.wikipedia.org/wiki/Coroutines
my @queue;
my @done;
my $full = 3;

coro produce {
    state $call_counter;
    return @done if ++$call_counter == $full;
    while +@queue != $full {
        @queue.push('task' ~ int rand 7 );
    }
    yield consume;
}

coro consume {
    while +@queue {
         @done.push( @queue.pop() );
    }
    yield produce;
}
is( +produce(),6,'producer/consumer');

