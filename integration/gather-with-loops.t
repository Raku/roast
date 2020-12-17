use v6;

use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 22;

# https://github.com/rakudo/rakudo/issues/3634

## canary test to notice that bug is fixed
#?rakudo.jvm todo 'UnwindException'
is_run q[gather for ^1 { take 42; last }],
    { status => 0, err => '', out => ''},
    'golfed code does not blow up';

## last in loop
{
    my $res = gather loop { take 42; last };
    is-deeply $res, (42).Seq, 'gather/take with last in loop';

    $res = gather while 1 { take 42; last };
    is-deeply $res, (42).Seq, 'gather/take with last in while loop';

    $res = gather repeat { take 42; last } until 0;
    is-deeply $res, (42).Seq, 'gather/take with last in repeat-until loop';

    #?rakudo.jvm skip 'UnwindException'
    $res = gather for ^3 { take 42; last };
    is-deeply $res, (42).Seq, 'gather/take with last in for loop';
}

## last in loop with eager
{
    my $res = eager gather loop { take 42; last };
    is-deeply $res, (42).List, 'eager gather/take with last in loop';

    $res = eager gather while 1 { take 42; last };
    is-deeply $res, (42).List, 'eager gather/take with last in while loop';

    $res = eager gather repeat { take 42; last } until 0;
    is-deeply $res, (42).List, 'eager gather/take with last in repeat-until loop';
}

## last in for loop with eager -- separated to be able to skip for rakudo.jvm
#?rakudo.jvm skip 'UnwindException'
{
    my $res = eager gather for ^3 { take 42; last };
    is-deeply $res, (42).List, 'eager gather/take with last in for loop';
}

## next in loop
{
    my $res = gather loop { state $count = 0; last if $count == 4; next if ++$count > 1; take $count };
    is-deeply $res, (1).Seq, 'gather/take with next in loop';

    $res = gather while 1 { state $count = 0; last if $count == 4; next if ++$count > 2; take $count };
    is-deeply $res, (1, 2).Seq, 'gather/take with next in while loop';

    $res = gather repeat { state $count = 0; last if $count == 4; next if ++$count > 3; take $count } until 0;
    is-deeply $res, (1, 2, 3).Seq, 'gather/take with next in repeat-until loop';

    $res = gather for ^4 { state $count = 0; next if ++$count > 3; take $count };
    is-deeply $res, (1, 2, 3).Seq, 'gather/take with next in for loop';
}

## redo in loop
{
    my $res = gather loop { state $count = 0; last if $count == 4; redo if ++$count < 2; take $count };
    is-deeply $res, (2, 3, 4).Seq, 'gather/take with redo in loop';

    $res = gather while 1 { state $count = 0; last if $count == 4; redo if ++$count < 3; take $count };
    is-deeply $res, (3, 4).Seq, 'gather/take with redo in while loop';

    $res = gather repeat { state $count = 0; last if $count == 4; redo if ++$count < 4; take $count } until 0;
    is-deeply $res, (4).Seq, 'gather/take with redo in repeat-until loop';

    $res = gather for ^4 { state $count = 0; redo if ++$count == 2; take $count };
    is-deeply $res, (1, 3, 4, 5).Seq, 'gather/take with redo in for loop';
}

## last in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            last if ++$count_inner > 1;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-1', '2-1', '3-1').Seq, 'gather/take with last in nested for loop';
}

## next in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            next if ++$count_inner < 3;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-3', '2-3', '3-3').Seq, 'gather/take with next in nested for loop';
}

## redo in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            redo if ++$count_inner == 1;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-2', '1-3', '1-4', '2-2', '2-3', '2-4', '3-2', '3-3', '3-4').Seq, 'gather/take with redo in nested for loop';
}

## last in nested for loop with label
{
    my $res = gather {
        LABEL_OUTER:
        for ^3 {
            state $count_outer = 0;
            ++$count_outer;
            LABEL_INNER:
            for ^3 {
                state $count_inner = 0;
                last LABEL_OUTER if ++$count_inner > 1;
                take $count_outer ~ '-' ~ $count_inner;
            }
        }
    };
    is-deeply $res, ('1-1').Seq, 'gather/take with labeled last in nested for loop (1)';

    $res = gather {
        LABEL_OUTER:
        for ^3 {
            state $count_outer = 0;
            ++$count_outer;
            LABEL_INNER:
            for ^3 {
                state $count_inner = 0;
                last LABEL_INNER if ++$count_inner > 1;
                take $count_outer ~ '-' ~ $count_inner;
            }
        }
    };
    is-deeply $res, ('1-1', '2-1', '3-1').Seq, 'gather/take with labeled last in nested for loop (2)';
}

# vim: expandtab shiftwidth=4
