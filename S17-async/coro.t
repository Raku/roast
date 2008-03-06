use v6-alpha;
use Test;

plan 14;

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

is ping(),'pingpongpingpong','playing ping pong';

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
is +produce(),6,'producer/consumer';

#L<S17/Co-Routines>
# more than one yield test
coro do_it_again {
    yield 3;
    yield 2;
    yield 1;
    yield 'meins';
}
is do_it_again(),3,'first yield reached';
is do_it_again(),2,'second yield reached';
is do_it_again(),1,'count down reached';
is do_it_again(),'meins','... now you\'ve got it';
is do_it_again(),3,'first yield reached';

# test from spec
#L<S17/Examples/"=item Coro as function used in a builtin">
coro dbl { yield $_ * 2; yield $_;  };
# coro should be callable inside a builtin function
# see also t/spec/S29-list/map_function.t
#?pugs todo 'unimpl' 
is ~((1..4).map:{ dbl($_) }),'2 2 6 4','coro as function';


#L<S17/Examples/"=item Constant coro">
coro foo { yield 42 };
is foo(), 42, "the anser is...";
is foo(), 42, "... always 42";


#L<S17/Examples/"=item Yield and return">
coro return_coro ($x) {
    yield $x;
    # this point with $x bound to 10
    yield $x+1;
    return 5;
    ... # this is never reached, I think we all agree
}

is return_coro(3),3,"first yield";
is return_coro(3),4,"next...";
is return_coro(3),5,"return";
is return_coro(3),3,"first yield back again";
