use Test;
plan 7;

# Basic sanity
{
    my atomicint $value = 21;
    my int $was;
    ok cas($value, { $was = $_; 2 * $_ }) == 42,
        'Looping form of CAS returns what was installed';
    ok $was == 21, 'The block was called with the original value';
    is $value, 42, 'The value was updated with the correct value';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $total = 0;
    await start {
        for 1..10000 -> $i {
            cas $total, -> $cur { $cur + $i }
        }
    } xx 4;

    is $total, 4 * [+](1..10000),
        "Block form of CAS on integer lexical works ($attempt)";
}
