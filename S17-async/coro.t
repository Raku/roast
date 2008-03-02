use v6-alpha;
use Test;

plan 8;

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

#L<S17/Co-Routines>
# more than one yield test
coro do_it_again {
    yield 3;
    yield 2;
    yield 1;
    yield 'meins';
}
is( do_it_again(),3,'first yield reached');
is( do_it_again(),2,'second yield reached');
is( do_it_again(),1,'count down reached');
is( do_it_again(),'meins','... now you\'ve got it');
is( do_it_again(),3,'first yield reached');

# test from spec
#L<S17/Co-Routines>
coro dbl { yield $_ * 2; yield $_;  };
#?pugs todo :by<6.2.14>
is( ~((1..4).map:{ dbl() }),'2 2 6 4','core as function');

