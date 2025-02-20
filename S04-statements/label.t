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
#              Please note that each type of loop comes in two versions: not
#              within parens and within parens. Accordings to the old design
#              documents the second version should be lazy:
#              https://github.com/Raku/old-design-docs/blob/a4c36c683d/S04-control.pod#loops-at-the-statementlist-level-vs-the-statement-level
#              The tests explicitly don't test this aspect. They are about the
#              crash described in the mentioned bug report.
{
    my $ignore;
    my @res;
    sub while-loop() {
        L: while True { while True { @res.push: 1; last L } }
    }
    sub while-loop-in-parens() {
        (L: while True { while True { @res.push: 3; last L } })
    }
    sub until-loop() {
        L: until False { until False { @res.push: 5; last L } }
    }
    sub until-loop-in-parens() {
        (L: until False { until False { @res.push: 7; last L } })
    }
    # Make sure that loops are run (in case they are lazy).
    $ignore = while-loop()[2];
    $ignore = while-loop-in-parens()[2];
    $ignore = until-loop()[2];
    $ignore = until-loop-in-parens()[2];
    is-deeply @res, [1, 3, 5, 7], 'no crash: nested loops and labeled last (1)';

    @res = [];
    sub seq-from-loop-while() {
        L: Seq.from-loop(
            { loop { @res.push: 9; last L } },
            { True },
            :label(L)
        )
    }
    sub seq-from-loop-while-in-parens() {
        (L: Seq.from-loop(
            { loop { @res.push: 11; last L } },
            { True },
            :label(L)
        ))
    }
    sub seq-from-loop-repeat() {
        L: Seq.from-loop(
            { loop { @res.push: 13; last L } },
            { True },
            :label(L),
            :repeat(1)
        )
    }
    sub seq-from-loop-repeat-in-parens() {
        (L: Seq.from-loop(
            { loop { @res.push: 15; last L } },
            { True },
            :label(L),
            :repeat(1)
        ))
    }
    # Make sure that loops are run (in case they are lazy).
    $ignore = seq-from-loop-while()[0];
    $ignore = seq-from-loop-while-in-parens()[0];
    $ignore = seq-from-loop-repeat()[0];
    $ignore = seq-from-loop-repeat-in-parens()[0];
    is-deeply @res, [9, 11, 13, 15], 'no crash: nested loops and labeled last (2)';

    @res = [];
    sub c-style-loop() {
        L: loop { loop { @res.push: 0; last L } }
    }
    sub c-style-loop-in-parens() {
        (L: loop { loop { @res.push: 2; last L } })
    }
    sub seq-from-loop-c-style() {
        L: Seq.from-loop(
            { loop { @res.push: 4; last L } },
            { True },
            { my $foo = 47 },
            :label(L)
        )
    }
    sub seq-from-loop-c-style-in-parens() {
        (L: Seq.from-loop(
            { loop { @res.push: 6; last L } },
            { True },
            { my $foo = 47 },
            :label(L)
        ))
    }
    # Make sure that loops are run (in case they are lazy).
    $ignore = c-style-loop()[0];
    $ignore = c-style-loop-in-parens()[0];
    $ignore = seq-from-loop-c-style()[0];
    $ignore = seq-from-loop-c-style-in-parens()[0];
    is-deeply @res, [0, 2, 4, 6], 'no crash: nested loops and labeled last (3)';

    @res = [];
    sub seq-from-loop-plain() {
        L: Seq.from-loop(
            { loop { @res.push: 8; last L } },
            :label(L)
        )
    }
    sub seq-from-loop-plain-in-parens() {
        (L: Seq.from-loop(
            { loop { @res.push: 10; last L } },
            :label(L)
        ))
    }
    # Make sure that loops are run (in case they are lazy).
    $ignore = seq-from-loop-plain()[0];
    $ignore = seq-from-loop-plain-in-parens()[0];
    is-deeply @res, [8, 10], 'no crash: nested loops and labeled last (4)';
}

# https://github.com/rakudo/rakudo/issues/4456
{
    my int $i;
    for ^1000 { gather L: for ^1 { $i++; next L } }
    is $i, 1000, 'did all of the gathers gather';
}

# vim: expandtab shiftwidth=4
