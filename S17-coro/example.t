use v6-alpha;
use Test;

plan 16;

# test from spec
#L<S17/"Coroutine examples"/"=item Coro as function used in a builtin">
coro dbl { yield $_ * 2; yield $_;  };
# coro should be callable inside a builtin function
# see also t/spec/S29-list/map_function.t
#?pugs todo 'unimpl' 
is ~((1..4).map:{ dbl($_) }),'2 2 6 4','coro as function';
is ~((1..4).map:{ $_*2 }),'2 4 6 8','this is how function works';



#L<S17/"Coroutine examples"/"=item Coro as function used in a builtin">
coro perm ( @x is copy ) {
    while @x {
        @x.splice($_,1).yield;
    }
}
# I'm not sure that this behaviour is right...
# but this is the way currently it does
my $p1 = perm(1..10);
is $p1,1, "first indirect perm call";
is $p1,1, "second indirect perm call do the same (?)";

my $p2 = perm(1..20);
is $p2,2, "second instance first call";

is perm(1..10), 3, 'third call with parameter';


#L<S17/"Coroutine examples"/"=item Coro as function used in a builtin">

# If you don't want your variables to get rebound, use "is copy":
coro sugar ($x is copy) {
    yield ++$x;
}
# which is sugar for
coro without_sugar ($x) {
    my $y = $x;
    yield ++$y;
    # Further calls of &without_sugar rebound $OUTER::x, not $x.
}

my $outer = 1;
is sugar($outer),2,'I<sugar> does his work...';
is $outer,1,'... and outer variable stays tough';
is without_sugar($outer),2,'I<_without_sugar> does the same';
is $outer,1,'again outer variable stays tough';


#L<S17/"Coroutine examples"/"=item Constant coro">
coro foo { yield 42 };
is foo(), 42, "the anser is...";
is foo(), 42, "... always 42";


#L<S17/"Coroutine examples"/"=item Yield and return">
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


