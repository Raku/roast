use v6;

use Test;

plan 20;

# L<S04/The Relationship of Blocks and Declarations/There is a new state declarator that introduces>

# state() inside subs
{
    sub inc () {
        state $svar;
        $svar++;
        return $svar;
    };

    is(inc(), 1, "state() works inside subs (#1)");
    is(inc(), 2, "state() works inside subs (#2)");
    is(inc(), 3, "state() works inside subs (#3)");
}

# state() inside coderefs
# L<S04/Closure traits/"semantics to any initializer, so this also works">
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

# state will first {...}
#?pugs eval "parse error"
{
    my ($a, $b);
    my $gen = {
        state $svar will first { 42 };
        -> { $svar++ };
    }
    $a = $gen();    # $svar == 42
    $a(); $a();     # $svar == 44
    $b = $gen()();  # $svar == 44

    is $b, 44, 'state will first {...} works';
}

# Return of a reference to a state() var
{
    my $gen = {
        state $svar = 42;
        \$svar;
    };

    my $svar_ref = $gen();
    $$svar_ref++; $$svar_ref++;

    my $svar_ref = $gen();
    #?pugs todo "state bug"
    is $$svar_ref, 44, "reference to a state() var";
}

# Anonymous state vars
# L<http://groups.google.de/group/perl.perl6.language/msg/07aefb88f5fc8429>
#?pugs todo 'anonymous state vars'
{
    # XXX -- currently this is parsed as \&state()
    my $gen = eval '{ try { \state } }';
    $gen //= sub { my $x; \$x };

    my $svar_ref = $gen();               # $svar == 0
    try { $$svar_ref++; $$svar_ref++ };  # $svar == 2

    my $svar_ref = $gen();               # $svar == 2
    is try { $$svar_ref }, 2, "anonymous state() vars";
}

# L<http://www.nntp.perl.org/group/perl.perl6.language/20888>
# ("Re: Declaration and definition of state() vars" from Larry)
#?pugs eval 'Parse error'
{
    my ($a, $b);
    my $gen = {
        (state $svar) = 42;
        my $ret = { $svar++ };
    };

    $a = $gen();        # $svar == 42
    $a(); $a();         # $svar == 44
    $b = $gen()();      # $svar == 42
    is $b, 42, "state() and parens"; # svar == 43
}

# state() inside regular expressions
{
    my $str = "abc";

    my $re  = {
    # Perl 5 RE, as we don't want to force people to install Parrot ATM. (The
    # test passes when using the Perl 6 RE, too.)
    $str ~~ s:Perl5/^(.)/{
      state $svar;
      ++$svar;
    }/;
    };
    $re();
    $re();
    $re();
    is +$str, 3, "state() inside regular expressions works";
}

# state() inside subs, chained declaration
{
    sub step () {
        state $svar = state $svar2 = 42;
        try {
            $svar++;
            $svar2--;
            return (+$svar, +$svar2);
        }
    };

    is(step().perl, "(43, 41)", "chained state (#1)");
    is(step().perl, "(44, 40)", "chained state (#2)");
}

# state in cloned closures
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

# recursive state with list assignment initialization happens only first time
{
    my $seensize;
    my sub fib (UInt $n) {
	state @seen = 0,1,1;
	$seensize = +@seen;
	@seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "fib 1 works";
    is $seensize, 11, "list assignment state in fib memoizes";
}

# recursive state with [list] assignment initialization happens only first time
{
    my $seensize;
    my sub fib (UInt $n) {
	state $seen = [0,1,1];
	$seensize = +@$seen;
	$seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "fib 2 works";
    is $seensize, 11, "[list] assignment state in fib memoizes";
}
