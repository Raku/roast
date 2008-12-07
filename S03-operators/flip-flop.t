use v6;

use Test;

plan 22;

# L<S03/Changes to Perl 5 operators/flipflop operator is now done with>

# XXX tests for fff

#?pugs 999 skip 'TODO: infix:<ff>'
sub my_take (Int $n, Code &f) { (1..$n).map: { try { f() } } }
sub always_false { 0 }
sub always_true  { 1 }

# Basic ff
{
   ok 1 ff 1, 'flip-flop operator implemented';

}

{
    my @result = my_take 5, { ?(always_false() ff always_false()) };
    is ~@result, "    ", "always_false() ff always_false()";
}

{
    my @result = my_take 5, { ?(always_false() ff always_true()) };
    is ~@result, "    ", "always_false() ff always_true()";
}

{
    my @result = my_take 5, { ?(always_true() ff always_true()) };
    ok all(@result), "always_true() ff always_true()";
}

{
    my @result = my_take 5, { ?(always_true() ff always_false()) };
    is ~@result, "1 2 3 4 5", "always_true() ff always_false()";
}

# Basic ^ff
{
    my @result = my_take 5, { ?(always_false() ^ff always_false()) };
    is ~@result, "    ", "always_false() ^ff always_false()";
}

{
    my @result = my_take 5, { ?(always_false() ^ff always_true()) };
    is ~@result, "    ", "always_false() ^ff always_true()";
}

{
    my @result = my_take 5, { ?(always_true() ^ff always_true()) } || 1;
    my $first  = shift @result;

    ok !$first && all(@result), "always_true() ^ff always_true()";
}

{
    my @result = my_take 5, { ?(always_true() ^ff always_false()) };
    is ~@result, " 2 3 4 5", "always_true() ^ff always_false()";
}

# Basic ff^
{
    my @result = my_take 5, { ?(always_false() ff^ always_false()) };
    is ~@result, "    ", "always_false() ff^ always_false()";
}

{
    my @result = my_take 5, { ?(always_false() ff^ always_true()) };
    is ~@result, "    ", "always_false() ff^ always_true()";
}

{
    my @result = my_take 5, { ?(always_true() ff^ always_true()) };

    # XXX what should the result be?
}

{
    my @result = my_take 5, { ?(always_true() ff^ always_false()) };
    is ~@result, "1 2 3 4 5", "always_true() ff^ always_false()";
}

# RHS not evaluated when in "false" state (perldoc perlop, /flip-flop)
{
    { my $bug; ok 0 ff {$bug=2};$bug ||=1; ok ($bug == 1), "RHS not evaluated in \"false\" state (ff)">; }
    { my $bug; ok 0 ^ff {$bug=2};$bug ||=1; ok ($bug == 1), "RHS not evaluated in \"false\" state (^ff)">; }
    { my $bug; ok 0 ff^ {$bug=2};$bug ||=1; ok ($bug == 1), "RHS not evaluated in \"false\" state (ff^)">; }
}

# LHS not evaluated when in "true" state (perldoc perlop, /flip-flop)
{
    my sub true_then_die {
        state $invoked;
        if ! $invoked++ {
            "true";
        } else {
            die;
        }
    }
    ok true_then_die()  ff  always_false();true_then_die() ff always_false(),
        "LHS not evaluated in \"true\" state (ff)";
    ok true_then_die() ^ff  always_false();true_then_die() ^ff always_false(),
        "LHS not evaluated in \"true\" state (^ff)";
    ok true_then_die()  ff^ always_false();true_the_die() ff^ always_false(),
        "LHS not evaluated in \"true\" state (ff^)";
}

# See thread "till (the flipflop operator, formerly ..)" on p6l started by Ingo
# Blechschmidt, especially Larry's reply:
# http://www.nntp.perl.org/group/perl.perl6.language/24098
{
    ok my sub foo ($x) { try { $x ff 0 } }; if foo(0) || !foo(1) || !foo(0) { die },
    	"all sub invocations share the same ff-state";
}
