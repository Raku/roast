use v6;
use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/6131
lives-ok {
    await Promise.allof((^3).map: {
        start {
            for ^200 {
                EVAL "True";
            }
        }
    });
}, 'Simple EVAL in a loop does not crash';

# vim: expandtab shiftwidth=4
