use v6-alpha;
use Test;

# from original docs/Perl6/Spec/Concurrency.pod
# &foo.finished; # true on return() and false on midway yield()

plan 2;

coro finisher {
    yield 1;
    return 2;
}

#L<S17/"Coroutine attributes"/"=item finished">
#?pugs todo 'unimpl'
flunk("Implement I<finished> attribute");
#ok !finisher().finished,'first call, yield is reached, not finished';
#?pugs todo 'unimpl'
flunk("Implement I<finished> attribute");
#ok finisher().finished,'second call, return reached, finished';
