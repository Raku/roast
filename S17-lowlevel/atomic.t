use Test;
plan 27;

# Full memory barrier sanity check.
lives-ok { full-barrier() },
    'Doing a full memory barrier lives';

# Atomic Scalar fetch/assign sanity check.
{
    my Int $test-cont = 42;
    is Atomic.fetch($test-cont), 42,
        'Can do an atomic fetch from a Scalar container';
    is Atomic.assign($test-cont, 101), 101,
        'Can do an atomic assign to a Scalar container; returns new value';
    is Atomic.fetch($test-cont), 101,
        'Atomic fetch after atomic assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
    throws-like { Atomic.assign($test-cont, 'foo') },
        X::TypeCheck::Assignment,
        'Cannot atomic assign value of the wrong type';
}

# Atomic Scalar with subset type
{
    my subset Even of Int where * %% 2;
    my Even $i = 2;
    is Atomic.assign($i, 6), 6,
        'Can atomic assign to a Scalar container with a subset type if value matches';
    throws-like { Atomic.assign($i, 3) },
        X::TypeCheck::Assignment,
        'Cannot atomic assign value failing to meet subset type';
    is Atomic.fetch($i), 6, 'Correct value is in the container';
}

# Ensure that atomic Scalar fetch isn't wrongly lifted by an optimizer that
# isn't as smart as it thinks it is.
{
    my Bool $set = False;
    start { Atomic.assign($set, True) };
    until Atomic.fetch($set) { }
    pass "No hang due to incorrect lifting of atomic fetch out of loop";
}

# Atomic int fetch/assign sanity check.
{
    my atomicint $test-cont = 42;
    is Atomic.fetch($test-cont), 42,
        'Can do an atomic fetch from an int container';
    is Atomic.assign($test-cont, 101), 101,
        'Can do an atomic assign to an int container; returns new value';
    is Atomic.fetch($test-cont), 101,
        'Atomic int fetch after atomic int assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
}

# Ensure that atomic int fetch isn't wrongly lifted either.
{
    my atomicint $set = 0;
    start { Atomic.assign($set, 1) };
    until Atomic.fetch($set) { }
    pass "No hang due to incorrect lifting of atomic int fetch out of loop";
}

# Atomic integer increment (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 0;
    await start {
        for ^20000 {
            Atomic.inc($i);
        }
    } xx 4;
    is Atomic.fetch($i), 4 * 20000, "Atomic increment of lexical works ($attempt)"; 
}

# Atomic integer decrement (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            Atomic.dec($i);
        }
    } xx 4;
    is Atomic.fetch($i), 100000 - 4 * 20000, "Atomic decrement of lexical works ($attempt)"; 
}

# Atomic integer add (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            Atomic.add($i, 4);
        }
    } xx 4;
    is Atomic.fetch($i), 100000 + 4 * 4 * 20000, "Atomic add of lexical works ($attempt)"; 
}
