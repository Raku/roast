use v6.d.PREVIEW;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 1;

# RT#130774
# Note: outside `eval-lives-ok`, the failure seems to occurs much rarer and
#       requires use of ^20000 iterations or so. Keep that in mind if changing.
eval-lives-ok ｢
    for ^200 {
        await ^5 .map: { start {
            my $r := ½ + rand.ceiling/2;
            my $at := now + .003;
            await Promise.at($at).then({
                    $r.nude;
                    $r.numerator == $r.denominator == 1
                      or die "Not right [1] ($r.Capture())";
                }),
                Promise.at($at).then({
                    my $r2 := $r + ½;
                    $r2.numerator == 3 and $r2.denominator == 2
                      or die "Not right [2] ($r2.Capture())";
                })
        }}
    }
｣, 'Rationals are immutable'
or diag ｢
    NOTE IF THIS TEST FLOPS. LIKELY THE BUG STILL EXISTS.
    BUMP THE LOOP COUNTER TO ^20000 to make the failure more likely to occur.
｣;


# vim: expandtab shiftwidth=4 ft=perl6
