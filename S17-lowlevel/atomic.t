use Test;
plan 10;

# Full memory barrier sanity check.
lives-ok { Atomic.full-barrier() },
    'Doing a full memory barrier lives';

# Atomic fetch/assign sanity check.
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

# Ensure that atomic fetch isn't wrongly lifted by an optimizer that isn't as
# smart as it thinks it is.
{
    my Bool $set = False;
    start { Atomic.assign($set, True) };
    until Atomic.fetch($set) { }
    pass "No hang due to incorrect lifting of atomic fetch out of loop";
}
