use Test;
# L<S04/"Loop statements"/"next, last, and redo">
plan 13;

{
    my $x = 0;
    my $y = 0;
    my $t = '';
    A: while $x++ < 2 {
        $t ~= "A$x";
        B: while $y++ < 2 {
            $t ~= "B$y";
            redo A if $y++ == 1;
            last A
        }
    }
    is $t, 'A1B1A1A2', 'labeled while loops with redo and last'
}

{
    my $i = 0;
    my $t = '';
    A: for "A" {
        $t ~= $_;
        B: for "B" {
            $t ~= $_;
            redo A unless $i++
        }
    }
    is($t, 'ABAB', 'redoing outer for loop');
}

{
    my $i = 0;
    my $t = '';
    A: for "A1", "A2" {
        $t ~= $_;
        B: for "B" {
            $t ~= $_;
            C: for "C" {
                $t ~= $_;
                redo B unless $i++
            }
        }
    }
    is($t, 'A1BCBCA2BC', 'redoing outer for loop');
}

{
    my $i = 0;
    my $t = '';
    A: for "A1", "A2" {
        $t ~= $_;
        B: for "B" {
            $t ~= $_;
            C: for "C" {
                $t ~= $_;
                D: while "D" {
                    $t ~= 'D';
                    redo B unless $i++;
                    last
                }
            }
        }
    }
    is($t, 'A1BCDBCDA2BCD', 'redoing outer for loop');
}

throws-like { EVAL q[label1: say "OH HAI"; label1: say "OH NOES"] }, X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4688
{
    throws-like 'A: for 1 { for 1 { last A }; CONTROL { default { die $_ } } }', CX::Last,
        "last-ing and outer loop and catching that in a CONTROL block doesn't SEGV";
}

# https://github.com/rakudo/rakudo/issues/2699
{
    my @nexts;
    FOO: for <a b> { NEXT @nexts.push($_); next FOO }
    is @nexts, "a b", 'did the labelled NEXTs run?';

    my @lasts;
    BAR: for <a b> { LAST @lasts.push($_); last BAR }
    is @lasts, "a", 'did the labelled LASTs run?';
}

# https://github.com/rakudo/rakudo/issues/3622
# NB(bartolin) As of 2020-04-13 Rakudo has different classes for different loop
#              types. The tests resemble Rakudo's current internal structure,
#              but the code should work for all implementations.
{
    lives-ok {
        @ = (L1: while True { while True { last L1 } });
        @ = (L2: until False { until False { last L2 } });
        @ = (L3: Seq.from-loop(
            { loop { last L3 } },
            { True },
            :label(L3)
        ));
    }, 'nested loop with labeled last (1)';

    lives-ok {
        @ = (L4: Seq.from-loop(
            { loop { last L4 } },
            { True },
            :label(L4),
            :repeat(1)
        ));
    }, 'nested loop with labeled last (2)';

    lives-ok {
        @ = (L5: loop { loop { last L5 } });
        @ = (L6: Seq.from-loop(
            { loop { last L6 } },
            { True },
            { my $foo = 47 },
            :label(L6)
        ));
    }, 'nested loop with labeled last (3)';

    lives-ok {
        L7: Seq.from-loop( { loop { last L7 } }, :label(L7));
    }, 'nested loop with labeled last (4)';
}

# https://github.com/rakudo/rakudo/issues/4456
{
    my int $i;
    for ^1000 { gather L: for ^1 { $i++; next L } }
    is $i, 1000, 'did all of the gathers gather';
}

# vim: expandtab shiftwidth=4
