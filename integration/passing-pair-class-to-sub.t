use v6.c;
use Test;

# L<S02/Mutable types/A single key-to-value association>
# There ought to be a better reference for this.
# And this test is also a candidate to be moved with other subroutine tests.


plan 2;

{
    my sub foo ($x) { $x.perl }

    my $pair = (a => 1);
    my $Pair = $pair.WHAT;

    lives-ok { foo($Pair) }, "passing ::Pair to a sub works";
}

{
    my sub foo ($x) { $x.perl }

    my $int = 42;
    my $Int = $int.WHAT;

    lives-ok { foo($Int) }, "passing ::Int to a sub works";
}

# vim: ft=perl6
