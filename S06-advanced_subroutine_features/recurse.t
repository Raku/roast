use v6;

use Test;

plan 13;

# Mostly copied from Perl 5.8.4 s t/op/recurse.t

sub gcd {
    return gcd(@_[0] - @_[1], @_[1]) if (@_[0] > @_[1]);
    return gcd(@_[0], @_[1] - @_[0]) if (@_[0] < @_[1]);
    @_[0];
}

sub factorial {
    @_[0] < 2 ?? 1 !! @_[0] * factorial(@_[0] - 1);
}

sub fibonacci {
    @_[0] < 2 ?? 1 !! &?ROUTINE(@_[0] - 2) + &?ROUTINE(@_[0] - 1);
}

# Highly recursive, highly aggressive.
# Kids, do not try this at home.
#
# For example ackermann(4,1) will take quite a long time.
# It will simply eat away your memory. Trust me.

sub ackermann {
    return @_[1] + 1               if (@_[0] == 0);
    return ackermann(@_[0] - 1, 1) if (@_[1] == 0);
    ackermann(@_[0] - 1, ackermann(@_[0], @_[1] - 1));
}

# Highly recursive, highly boring.

sub takeuchi {
    # for the script failure here, see Parser.hs:589
    @_[1] < @_[0] ??
        takeuchi(takeuchi(@_[0] - 1, @_[1], @_[2]),
                 takeuchi(@_[1] - 1, @_[2], @_[0]),
                 takeuchi(@_[2] - 1, @_[0], @_[1]))
            !! @_[2];
}

is(gcd(1147, 1271), 31, 'gcd 1');
is(gcd(1908, 2016),  36, 'gcd 2');
ok(factorial(10) == 3628800, 'simple factorial');
is(factorial(factorial(3)), 720, 'nested factorial');
is(fibonacci(10), 89, 'recursion via &?ROUTINE');

# ok(fibonacci(fibonacci(7)) == 17711);
# takes too long
# skip("Takes too long to wait for");

# dunno if these could use some shorter/simpler sub names, but I'm not
# thinking of anything offhand.

# what the silly sub names mean:
#  - 'mod' means it makes a local copy of the variable, modified as
#    necessary
#  - 'nomod' means it passes the modified value directly to the next call
#  - 'named' means it uses named parameters
#  - 'unnamed' means it uses @_ for parameters

sub countup_nomod_unnamed {
    my $num = @_.shift;
    return $num if $num <= 0;
    return countup_nomod_unnamed($num-1), $num;
}

sub countdown_nomod_unnamed {
    my $num = @_.shift;
    return $num if $num <= 0;
    return $num, countdown_nomod_unnamed($num-1);
}

sub countup_nomod_named ($num) {
    return $num if $num <= 0;
    return countup_nomod_named($num-1), $num;
}

sub countdown_nomod_named ($num) {
    return $num if $num <= 0;
    return $num, countdown_nomod_named($num-1);
}

sub countup_mod_unnamed {
    my $num = @_.shift;
    my $n = $num - 1;
    return $num if $num <= 0;
    return countup_mod_unnamed($n), $num;
}

sub countdown_mod_unnamed {
    my $num = @_.shift;
    my $n = $num - 1;
    return $num if $num <= 0;
    return $num, countdown_mod_unnamed($n);
}

sub countup_mod_named ($num) {
    my $n = $num - 1;
    return $num if $num <= 0;
    return countup_mod_named($n), $num;
}

sub countdown_mod_named ($num) {
    my $n = $num - 1;
    return $num if $num <= 0;
    return $num, countdown_mod_named($n);
}


is(  countup_nomod_named(5).join,   "012345", "recursive count up: named param, no modified value");
is(countdown_nomod_named(5).join,   "543210", "recursive count down: named param, no modified value");
is(  countup_nomod_unnamed(5).join, "012345", "recursive count up: unnamed param, no modified value");
is(countdown_nomod_unnamed(5).join, "543210", "recursive count down: unnamed param, no modified value");
is(  countup_mod_named(5).join,     "012345", "recursive count up: named param, modified value");
is(countdown_mod_named(5).join,     "543210", "recursive count down: named param, modified value");
is(  countup_mod_unnamed(5).join,   "012345", "recursive count up: unnamed param, modified value");
is(countdown_mod_unnamed(5).join,   "543210", "recursive count down: unnamed param, modified value");

# vim: ft=perl6
