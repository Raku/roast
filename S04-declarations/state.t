use v6;

use Test;

plan 47;

# L<S04/The Relationship of Blocks and Declarations/There is a new state declarator that introduces>

# RT #67040 -- state initialized with //= instead of =
# (I've put this test here since it gets buggered by later tests
#  unless RT #67058 has been fixed.)
{
    sub rt67040 {
        state $x //= 17;
        $x++;
        return $x;
    }

    is rt67040(), 18, 'Assignment to state variable with //= works.';
    is rt67040(), 19, 'Assignment to state variable with //= happens once.';
}

# state() inside subs
{
    sub inc () {
        state $svar;
        $svar++;
        return $svar;
    };

    is(inc(), 1, "state() works inside subs (first)");
    is(inc(), 2, "state() works inside subs (second)");
    is(inc(), 3, "state() works inside subs (#3)");
}

# state() inside coderefs
# L<S04/Phasers/"semantics to any initializer, so this also works">
#?DOES 1
{
    my $gen = {
        # Note: The following line is only executed once, because it's equivalent
        # to
        #   state $svar will first { 42 };
        state $svar = 42;
        my $ret = { $svar++ };
    };

    my $a = $gen(); # $svar == 42
    $a(); $a();     # $svar == 44
    my $b = $gen(); # $svar == 44

    is $b(), 44, "state() works inside coderefs";
}

# state() inside for-loops
{
    for 1,2,3 -> $val {
        state $svar;
        $svar++;

        # Only check on last run
        if $val == 3 {
            is $svar, 3, "state() works inside for-loops";
        }
    }
}

# state with arrays.
{
    my @bar = 1,2,3;
    sub swatest {
        state (@foo) = @bar;
        my $x = @foo.join('|');
        @foo[0]++;
        return $x
    }
    is swatest(), '1|2|3', 'array state initialized correctly';
    is swatest(), '2|2|3', 'array state retained between calls';
}

# state with arrays.
{
    sub swainit_sub { 1,2,3 }
    sub swatest2 {
        state (@foo) = swainit_sub();
        my $x = @foo.join('|');
        @foo[0]++;
        return $x
    }
    is swatest2(), '1|2|3', 'array state initialized from call correctly';
    is swatest2(), '2|2|3', 'array state retained between calls';
}

# (state @foo) = @bar differs from state @foo = @bar
{
   my @bar = 1,2,3;
   sub swatest3 {
       (state @foo) = @bar;
       my $x = @foo.join('|');
       @foo[0]++;
       return $x
   }
   is swatest3(), '1|2|3', '(state @foo) = @bar is not state @foo = @bar';
   is swatest3(), '1|2|3', '(state @foo) = @bar is not state @foo = @bar';
}

# RHS of state is only run once per init
{
    my $rhs_calls = 0;
    sub impure_rhs {
        state $x = do { $rhs_calls++ }    #OK not used
    }
    impure_rhs() for 1..3;
    is $rhs_calls, 1, 'RHS of state $x = ... only called once';
}

# L<http://www.nntp.perl.org/group/perl.perl6.language/20888>
# ("Re: Declaration and definition of state() vars" from Larry)
{
    my ($a, $b);
    my $gen = {
        (state $svar) = 42;
        -> { $svar++ };
    };

    $a = $gen();        # $svar == 42
    $a(); $a();         # $svar == 44
    $b = $gen()();      # $svar == 42
    is $b, 42, "state() and parens"; # svar == 43
}

# state() inside regular expressions
#?DOES 1
{
    my $str = "abc";
    my $re  = {
        state $a = 0;
        $str ~~ s:Perl5/^(.)/{ $a++ }/;
    };
    $re();
    $re();
    $re();
    is $str, "2bc", "state() variable referenced from regex replacement part works";
}

# state() inside subs, chained declaration
{
    sub step () {
        state $svar = state $svar2 = 42;
        $svar++;
        $svar2--;
        return (+$svar, +$svar2);
    };

    is(step().join('|'), "43|41", "chained state (1)");
    is(step().join('|'), "44|40", "chained state (2)");
}

# state in cloned closures
#?DOES 4
{
    for <first second> {
        my $code = {
            state $foo = 42;
            ++$foo;
        };

        is $code(), 43, "state was initialized properly ($_ time)";
        is $code(), 44, "state keeps its value across calls ($_ time)";
    }
}

# state with multiple explicit calls to clone - a little bit subtle
#?DOES 3
{
    my $i = 0;
    my $func = { state $x = $i++; $x };
    my ($a, $b) = $func.clone, $func.clone; 
    is $a(), 0, 'state was initialized correctly for clone 1';
    is $b(), 1, 'state was initialized correctly for clone 2';
    is $a(), 0, 'state between clones is independent';
}

# recursive state with list assignment initialization happens only first time
#?DOES 2
{
    my $seensize;
    my sub fib (Int $n) {
        state @seen = 0,1,1;
        $seensize = +@seen;
        @seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "fib 10 works";
    is $seensize, 10, "list assignment state in fib memoizes";
}

# recursive state with [list] assignment initialization happens only first time
#?DOES 2
{
    my $seensize;
    my sub fib (Int $n) {
        state $seen = [0,1,1];
        $seensize = +@$seen;
        $seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "fib 2 works";
    is $seensize, 10, "[list] assignment state in fib memoizes";
}

{
    # now we're just being plain evil:
    subset A of Int where { $_ < state $x++ };
    my A $y = -4;
    # the compiler could have done some checks somehwere, so
    # pick a reasonably high number
    dies-ok { $y = 900000 }, 'growing subset types rejects too high values';
    lives-ok { $y = 1 }, 'the state variable in subset types works (1)';
    lives-ok { $y = 2 }, 'the state variable in subset types works (2)';
    lives-ok { $y = 3 }, 'the state variable in subset types works (3)';
}

# Test for RT #67058
sub bughunt1 { (state $svar) }    #OK not used
{
    sub bughunt2 { state $x //= 17; ++$x }
    is bughunt2(), 18,
       'a state variable in parens works with a state variable with //= init';
}

# RT #115614
{
    lives-ok { state $i++ }, 'can parse "state $i++"';
}

#?DOES 1
{
    # http://irclog.perlgeek.de/perl6/2010-04-27#i_2269848
    my @tracker;
    for (1..3) {
        my $x = sub { state $s++; @tracker.push: $s }
        $x();
    };
    is @tracker.join('|'), '1|1|1',
        'state var in anonymous closure in loop is not shared';
}

# niecza regression: state not working at top level
eval-lives-ok 'state $x; $x', 'state outside control structure';

# RT #102994
{
    sub f($x) {
        return if $x;
        state $y = 5;
        $y;
    }
    f(1);
    is f(0), 5, 'initialization not reached on first run of the functions';

    my @a = do for ^3 { f(1); f(0) };
    is-deeply @a, [5, 5, 5], 'initialization not reached on first run of the functions; multiple clones';
}
{
    sub f($x) {
        return if $x < 2;
        state $a = 5;
        return if $x < 3;
        state $b = 10;
        return if $x < 4;
        state $c = 15;

        ( $a, $b, $c )
    }
    f($_) for (1..3);
    is-deeply f(4), (5, 10, 15), 'initialization not reached on first run of the functions; multiple statevars';

    my @a = do for ^3 { f($_) for (1..3); f(4) };
    is-deeply @a, [(5, 10, 15), (5, 10, 15), (5, 10, 15)], 'initialization not reached on first run of the functions; multiple statevars and clones';
}


{
    sub r {
        state ($a, $b) = (5, 42);
        $a++; $b--;
        "$a $b"
    }
    r();
    is r(), '7 40', 'state vars and list assignment mixes';
}

{
    my $x = 1;
    sub foo() { state $ = $x++ };
    is foo(), 1, 'anonymous state variable (1)';
    is foo(), 1, 'anonymous state variable (2)';
}

# RT #130855
lives-ok { sub foo () {$ = 42}; for ^2000000 { $ = foo } },
    'Intensive use of state variable in inline-friendly sub does not hit problems';

# [Github Issue #1341](https://github.com/rakudo/rakudo/issues/1341)
{
	my @arr = do loop { state $x = 0; last if ++$x > 2; $x };
	is-deeply @arr, [1, 2], 'Statevars work in block following "do" statement prefix';
}

# RT #129114
{
    my @arr = ();
    for ^2 { for ^2 { @arr.push( "{ (state $a)++ }") } };
    is-deeply @arr, ["0", "0", "0", "0"], 'Statevar uses the correct scope';
}

# vim: ft=perl6
