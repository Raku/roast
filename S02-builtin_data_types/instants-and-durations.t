use v6;
use Test;

plan *;

# L<S02/Immutable types/'term now'>

{
    my $i = now;
    isa_ok $i, Instant, 'now returns an Instant';
    ok $i ~~ Real, 'Instants are Real';
    isa_ok 5 + $i, Instant, 'Int + Instant ~~ Instant';
    isa_ok $i - 1/3, Instant, 'Instant - Rat ~~ Instant';
}

isa_ok eval('now +300'), Instant, 'now is a term, not a function';

# L<S02/Immutable types/'you may not add two instants'>

{
    my $t0 = now;
    sleep 2;
    my $t1 = now;
    my $d = $t1 - $t0;

    dies_ok { $t0 + $t1 }, 'Instant + Instant is illegal';
    isa_ok $d, Duration, 'Instant - Instant ~~ Duration';
    ok $d ~~ Real, 'Durations are Real';
    ok 1 < +$d < 3, 'Instant subtraction yields sane results';
    isa_ok $d + $t0, Instant, 'Instant + Duration ~~ Instant';
    isa_ok $d + $t0, Instant, 'Duration + Instant ~~ Instant';
    isa_ok $t0 - $d, Instant, 'Instant - Duration ~~ Instant';
    is $t0 + ($t1 - $t0), $t1, 'Instant A + (Instant B - Instant A) == Instant A';
    dies_ok { $d * $d }, 'Duration * Duration is illegal';
    isa_ok 2 * $d, Duration, 'Int * Duration ~~ Duration';
    isa_ok $d / (2/3), Duration, 'Duration / Rat ~~ Duration';
}

done_testing;

# vim: ft=perl6
