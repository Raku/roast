use v6;
use Test;

plan 12;

# L<S02/Immutable types/'term now'>

{
    my $i = now;
    isa_ok $i, Instant, 'now returns an Instant';
    isa_ok 5 + $i, Instant, 'Int + Instant ~~ Instant';
    isa_ok $i - 1/3, Instant, 'Instant - Rat ~~ Instant';
}

isa_ok eval('now +300'), Instant, 'now is a term, not a function';

# L<S02/Immutable types/'you may not add two instants'>

{
    my $t0 = Instant.from-posix(1295002122);

    my $t1 = Instant.from-posix(1303059935);

    my $d = $t1 - $t0;

    ok $t0 < $t1, 'later Instants are greater';
    dies_ok { $t0 + $t1 }, 'Instant + Instant is illegal';
    isa_ok $d, Duration, 'Instant - Instant ~~ Duration';
    ok $d ~~ Real, 'Durations are Real';
    isa_ok $d + $t0, Instant, 'Instant + Duration ~~ Instant';
    isa_ok $d + $t0, Instant, 'Duration + Instant ~~ Instant';
    isa_ok $t0 - $d, Instant, 'Instant - Duration ~~ Instant';
    #?rakudo todo 'nom regression'
    is $t0 + ($t1 - $t0), $t1, 'Instant A + (Instant B - Instant A) == Instant B';
}

done;

# See S32-temporal/DateTime-Instant-Duration.t for more.

# vim: ft=perl6
