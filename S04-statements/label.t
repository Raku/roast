use v6;

use Test;
# L<S04/"Loop statements"/"next, last, and redo">
plan 8;

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

# RT #126490
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
