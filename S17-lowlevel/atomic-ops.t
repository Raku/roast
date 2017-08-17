use Test;
plan 28;

# Scalar atomic fetch (⚛) and atomic assign (⚛=) ops.
{
    my Int $test-cont = 42;
    is ⚛$test-cont, 42,
        'Can do an atomic fetch from a Scalar container';
    is ($test-cont ⚛= 101), 101,
        'Can do an atomic assign to a Scalar container; returns new value';
    is ⚛$test-cont, 101,
        'Atomic fetch after atomic assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
    throws-like { $test-cont ⚛= 'foo' },
        X::TypeCheck::Assignment,
        'Cannot atomic assign value of the wrong type';
}

# Ensure that atomic atomic fetch op isn't wrongly lifted by an optimizer that
# isn't as smart as it thinks it is.
{
    my Bool $set = False;
    start { $set ⚛= True };
    until ⚛$set { }
    pass "No hang due to incorrect lifting of atomic fetch out of loop";
}

# Atomic int fetch/assign sanity check.
{
    my atomicint $test-cont = 42;
    is ⚛$test-cont, 42,
        'Can do an atomic fetch from an int container';
    is ($test-cont ⚛= 101), 101,
        'Can do an atomic assign to an int container; returns new value';
    is ⚛$test-cont, 101,
        'Atomic int fetch after atomic int assign shows latest value';
    is $test-cont, 101, 'Updated value seen by non-atomic too';
}

# Ensure that atomic int fetch op isn't wrongly lifted either.
{
    my atomicint $set = 0;
    start { $set ⚛= 1 };
    until ⚛$set { }
    pass "No hang due to incorrect lifting of atomic int fetch out of loop";
}

# Return values of atomic int math ops.
{
    my atomicint $test-cont = 10;
    is $test-cont⚛++, 10, 'postfix ⚛++ returns value before incrementing';
    is ++⚛$test-cont, 12, 'prefix ⚛++ returns value after incremenitng';
    is $test-cont⚛--, 12, 'postfix ⚛-- returns value before decrementing';
    is --⚛$test-cont, 10, 'prefix ⚛-- returns value after decremenitng';
    is ($test-cont ⚛+= 10), 20, '⚛+= returns value after addition';
}

# Atomic integer post-increment stress
for 1..4 -> $attempt {
    my atomicint $i = 0;
    await start {
        for ^20000 {
            $i⚛++;
        }
    } xx 4;
    is atomic-fetch($i), 4 * 20000, "Atomic increment of lexical works ($attempt)"; 
}

# Atomic integer post-decrement stress
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            $i⚛--;
        }
    } xx 4;
    is atomic-fetch($i), 100000 - 4 * 20000, "Atomic decrement of lexical works ($attempt)"; 
}

# Atomic integer add stress.
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            $i ⚛+= 4;
        }
    } xx 4;
    is ⚛$i, 100000 + 4 * 4 * 20000, "Atomic add of lexical works ($attempt)"; 
}
