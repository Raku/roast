use v6;
use Test;

plan 113;

# L<S02/Immutable types/'term now'>

{
    my $i = now;
    isa-ok $i, Instant, 'now returns an Instant';
    isa-ok 5 + $i, Instant, 'Int + Instant ~~ Instant';
    isa-ok $i - 1/3, Instant, 'Instant - Rat ~~ Instant';
    my $later = now;
    is-approx $i, $later, 'now and just now are close';
    ok $later >= $i, 'time does not move backwards';
}

isa-ok EVAL('now +300'), Instant, 'now is a term, not a function';

# L<S02/Immutable types/'must be explicitly created via any of'>
throws-like { Instant.new(123) }, X::Cannot::New, 'Instant.new is illegal';

# L<S02/Immutable types/'you may not add two instants'>

{
    my $t0 = Instant.from-posix(1295002122);

    my $t1 = Instant.from-posix(1303059935);

    my $d = $t1 - $t0;

    ok $t0 < $t1, 'later Instants are greater';
    throws-like { $t0 + $t1 },
      X::Multi::Ambiguous,
      'Instant + Instant is illegal';
    isa-ok $d, Duration, 'Instant - Instant ~~ Duration';
    ok $d ~~ Real, 'Durations are Real';
    isa-ok $d + $t0, Instant, 'Instant + Duration ~~ Instant';
    isa-ok $d + $t0, Instant, 'Duration + Instant ~~ Instant';
    isa-ok $t0 - $d, Instant, 'Instant - Duration ~~ Instant';
    is $t0 + ($t1 - $t0), $t1, 'Instant A + (Instant B - Instant A) == Instant B';
}

{
    for (-2**63, -400.2, -33/7, -1, 0, 1, 33/7, 400.2, 2**32, 915148800) -> $e {
        for (True, False) -> $prefer-leap {
            my $i = Instant.from-posix($e, $prefer-leap);
            is $i.perl.EVAL, $i, 'Instant round trips properly';
        }
    }
}

# L<S02/Immutable types/'these types behave like values'>

{
    my ($i1, $i2) = Instant.from-posix(500000.0e0), Instant.from-posix(1000000/2);
    my ($d1, $d2) = Duration.new(500000.0e0), Duration.new(1000000/2);
    for < eq == eqv === > -> $op {
        cmp-ok $i1, $op, $i2, "Instant A $op Instant B";
        cmp-ok $d1, $op, $d2, "Duration A $op Duration B";
    }
    cmp-ok $i1.WHICH, '===', $i2.WHICH, "InstantA.WHICH === InstantB.WHICH";
    cmp-ok $d1.WHICH, '===', $d2.WHICH, "DurationA.WHICH === DurationB.WHICH";
}

# L<S02/Immutable types/'In numeric context a Duration happily returns a Rat'>

{
    my ($d1, $d2) = Duration.new(Int(5000000)), Duration.new(10000000e0/2);
    cmp-ok  $d1, '~~', Numeric,   "Duration.new(__) ~~ Numeric";
    cmp-ok  $d2, '~~', Numeric,   "Duration.new(__) ~~ Numeric";
    cmp-ok  $d1, '~~', Real,      "Duration.new(__) ~~ Real";
    cmp-ok  $d2, '~~', Real,      "Duration.new(__) ~~ Real";
    cmp-ok +$d1, '~~', Rational, "+Duration.new(__) ~~ Rational";
    cmp-ok +$d2, '~~', Rational, "+Duration.new(__) ~~ Rational";
}

# L<S02/Immutable types/'Numeric operations on durations return'>
# #127339
{
    my (Duration $d1, Duration $d2, Int $i1, Int $i2) =
        Duration.new(97), Duration.new(23), 97, 23;
    my (Duration $d3, Duration $d4, Num $n3, Num $n4) =
        Duration.new(97.67), Duration.new(23.73), 97.67e0, 23.73e0;

    isa-ok $d1 + $i2, Duration, "Duration + Int ~~ Duration";
    isa-ok $i1 + $d2, Duration, "Int + Duration ~~ Duration";
    isa-ok $d1 + $d2, Duration, "Duration + Duration ~~ Duration";
    isa-ok $d4 + $n4, Duration, "Duration + Num ~~ Duration";
    isa-ok $n3 + $d4, Duration, "Num + Duration ~~ Duration";
    isa-ok $d3 + $d4, Duration, "Duration + Duration ~~ Duration";

    isa-ok $d1 - $i2, Duration, "Duration - Int ~~ Duration";
    isa-ok $i1 - $d2, Duration, "Int - Duration ~~ Duration";
    isa-ok $d1 - $d2, Duration, "Duration - Duration ~~ Duration";
    isa-ok $d4 - $n4, Duration, "Duration - Num ~~ Duration";
    isa-ok $n3 - $d4, Duration, "Num - Duration ~~ Duration";
    isa-ok $d3 - $d4, Duration, "Duration - Duration ~~ Duration";

    isa-ok $d1 * $i2, Duration, "Duration * Int ~~ Duration";
    isa-ok $i1 * $d2, Duration, "Int * Duration ~~ Duration";
    isa-ok $d1 * $d2, Duration, "Duration * Duration ~~ Duration";
    isa-ok $d4 * $n4, Duration, "Duration * Num ~~ Duration";
    isa-ok $n3 * $d4, Duration, "Num * Duration ~~ Duration";
    isa-ok $d3 * $d4, Duration, "Duration * Duration ~~ Duration";

    isa-ok $d1 / $i2, Duration, "Duration / Int ~~ Duration";
    isa-ok $i1 / $d2, Duration, "Int / Duration ~~ Duration";
    isa-ok $d3 / $n4, Duration, "Duration / Num ~~ Duration";
    isa-ok $n3 / $d4, Duration, "Num / Duration ~~ Duration";
    does-ok $d1 / $d2, Real,            "Duration / Duration ~~ Real";
    cmp-ok  $d1 / $d2, '!~~', Duration, "Duration / Duration !~~ Duration";
    does-ok $d3 / $d4, Real,            "Duration / Duration ~~ Real";
    cmp-ok  $d3 / $d4, '!~~', Duration, "Duration / Duration !~~ Duration";

    isa-ok $d1 % $i2, Duration, "Duration % Int ~~ Duration";
    isa-ok $i1 % $d2, Duration, "Int % Duration ~~ Duration";
    isa-ok $d1 % $d2, Duration, "Duration % Duration ~~ Duration";
    isa-ok $d3 % $n4, Duration, "Duration % Num ~~ Duration";
    isa-ok $n3 % $d4, Duration, "Num % Duration ~~ Duration";
    isa-ok $d3 % $d4, Duration, "Duration % Duration ~~ Duration";


    cmp-ok $d1 + $i2, '==', 120,    "Duration + Int == ?";
    cmp-ok $i1 + $d2, '==', 120,    "Int + Duration == ?";
    cmp-ok $d1 + $d2, '==', 120,    "Duration + Duration == ?";
    cmp-ok $d3 + $n4, '==', 121.40, "Duration + Num == ?";
    cmp-ok $n3 + $d4, '==', 121.40, "Num + Duration == ?";
    cmp-ok $d3 + $d4, '==', 121.40, "Duration + Duration == ?";

    cmp-ok $d1 - $i2, '==', 74,     "Duration - Int == ?";
    cmp-ok $i1 - $d2, '==', 74,     "Int - Duration == ?";
    cmp-ok $d1 - $d2, '==', 74,     "Duration - Duration == ?";
    cmp-ok $d3 - $n4, '==', 73.940, "Duration - Num == ?";
    cmp-ok $n3 - $d4, '==', 73.940, "Num - Duration == ?";
    cmp-ok $d3 - $d4, '==', 73.940, "Duration - Duration == ?";

    cmp-ok    $d1 * $i2, '==', 2231, "Duration * Int == ?";
    cmp-ok    $i1 * $d2, '==', 2231, "Int * Duration == ?";
    cmp-ok    $d1 * $d2, '==', 2231, "Duration * Duration == ?";
    is-approx $d3 * $n4,       2317.70910000, "Duration * Num == ?";
    is-approx $n3 * $d4,       2317.70910000, "Num * Duration == ?";
    cmp-ok    $d3 * $d4, '==', 2317.70910000, "Duration * Duration == ?";

    is-approx  $d1 / $i2, 4.21739130, "Duration / Int == ?";
    is-approx  $i1 / $d2, 4.21739130, "Int / Duration == ?";
    is-approx  $d1 / $d2, 4.21739130, "Duration / Duration == ?";
    is-approx  $d3 / $n4, 4.11588706, "Duration / Num == ?";
    is-approx  $n3 / $d4, 4.11588706, "Num / Duration == ?";
    is-approx  $d3 / $d4, 4.11588706, "Duration / Duration == ?";

    cmp-ok $d1 % $i2, '==', 5, "Duration % Int == ?";
    cmp-ok $i1 % $d2, '==', 5, "Int % Duration == ?";
    cmp-ok $d1 % $d2, '==', 5, "Duration % Duration == ?";
    cmp-ok $d3 % $n4, '==', 2.75, "Duration % Num == ?";
    cmp-ok $n3 % $d4, '==', 2.75, "Num % Duration == ?";
    cmp-ok $d3 % $d4, '==', 2.75, "Duration % Duration == ?";
}

# See S32-temporal/DateTime-Instant-Duration.t for more.

# vim: ft=perl6
