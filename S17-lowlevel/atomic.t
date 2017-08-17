use Test;
plan 33;

# Full memory barrier sanity check.
lives-ok { full-barrier() },
    'Doing a full memory barrier lives';

# Atomic Scalar fetch/assign sanity check.
{
    my Int $test-cont = 42;
    is atomic-fetch($test-cont), 42,
        'Can do an atomic fetch from a Scalar container';
    is atomic-assign($test-cont, 101), 101,
        'Can do an atomic assign to a Scalar container; returns new value';
    is atomic-fetch($test-cont), 101,
        'Atomic fetch after atomic assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
    throws-like { atomic-assign($test-cont, 'foo') },
        X::TypeCheck::Assignment,
        'Cannot atomic assign value of the wrong type';
}

# Atomic Scalar with subset type
{
    my subset Even of Int where * %% 2;
    my Even $i = 2;
    is atomic-assign($i, 6), 6,
        'Can atomic assign to a Scalar container with a subset type if value matches';
    throws-like { atomic-assign($i, 3) },
        X::TypeCheck::Assignment,
        'Cannot atomic assign value failing to meet subset type';
    is atomic-fetch($i), 6, 'Correct value is in the container';
}

# Ensure that atomic Scalar fetch isn't wrongly lifted by an optimizer that
# isn't as smart as it thinks it is.
{
    my Bool $set = False;
    start { atomic-assign($set, True) };
    until atomic-fetch($set) { }
    pass "No hang due to incorrect lifting of atomic fetch out of loop";
}

# Atomic int fetch/assign sanity check.
{
    my atomicint $test-cont = 42;
    is atomic-fetch($test-cont), 42,
        'Can do an atomic fetch from an int container';
    is atomic-assign($test-cont, 101), 101,
        'Can do an atomic assign to an int container; returns new value';
    is atomic-fetch($test-cont), 101,
        'Atomic int fetch after atomic int assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
}

# Ensure that atomic int fetch isn't wrongly lifted either.
{
    my atomicint $set = 0;
    start { atomic-assign($set, 1) };
    until atomic-fetch($set) { }
    pass "No hang due to incorrect lifting of atomic int fetch out of loop";
}

# Return values of atomic int math subs.
{
    my atomicint $test-cont = 10;
    is atomic-inc($test-cont), 10, 'atomic-inc returns value before incrementing (1)';
    is atomic-inc($test-cont), 11, 'atomic-inc returns value before incrementing (1)';
    is atomic-dec($test-cont), 12, 'atomic-dec returns value before decrementing (1)';
    is atomic-dec($test-cont), 11, 'atomic-dec returns value before decrementing (2)';
    is atomic-add($test-cont, 10), 10, 'atomic-add returns value before adding (1)';
    is atomic-add($test-cont, 10), 20, 'atomic-add returns value before adding (2)';
}

# Atomic integer increment (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 0;
    await start {
        for ^20000 {
            atomic-inc($i);
        }
    } xx 4;
    is atomic-fetch($i), 4 * 20000, "Atomic increment of lexical works ($attempt)"; 
}

# Atomic integer decrement (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            atomic-dec($i);
        }
    } xx 4;
    is atomic-fetch($i), 100000 - 4 * 20000, "Atomic decrement of lexical works ($attempt)"; 
}

# Atomic integer add (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            atomic-add($i, 4);
        }
    } xx 4;
    is atomic-fetch($i), 100000 + 4 * 4 * 20000, "Atomic add of lexical works ($attempt)"; 
}
