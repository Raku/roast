use v6-alpha;
use Test;

plan 7;

coro starter ( @x ) {
    my @y = @x;
    yield @y.shift;
}

#L<S17/"Coroutine methods"/"=item start">
#?pugs todo 'unimpl'
flunk("Implement I<start> method for coroutines");
#ok my &f = &starter.start( 1,2 );'set coderef to starter start';

#?pugs todo 'unimpl'
flunk("Implement I<start> method for coroutines");
#is f(),1,'first call';

#?pugs todo 'unimpl'
flunk("Implement I<start> method for coroutines");
#is f(),2,'second call';

# from original docs/Perl6/Spec/Concurrency.pod
coro foo ( $x ){ yield $x; yield $x+1; yield $x+2; }
#?pugs todo 'unimpl'
flunk("Implement I<start> method for coroutines");
#&foo_continued := &foo.start(10);
#&foo.start(20);

is foo(10), 10,"new coro instance ignoring I<start> call";

ok !eval( 'foo()'),"insufficient param error"; # or just return 11?
#?pugs todo 'bug'
is foo(20),21,'yield preserved, but new parameter used';
