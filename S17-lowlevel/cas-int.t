use Test;
plan 24;

# Basic sanity
{
    my atomicint $value = 21;
    ok cas($value, 21, 42) == 21, 'CAS of one integer to another returns seen value';
    is $value, 42, 'When expected value is seen then new value put in place';
    ok cas($value, 21, 100) == 42, 'CAS returns seen value when it is not the expected one';
    is $value, 42, 'Value not changed when no match';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my atomicint $value = 0;
    await start {
        for 1..10000 -> int $i {
            loop {
                my int $orig = $value;
                last if cas($value, $orig, $orig + $i) == $orig;
            }
        }
    } xx 4;

    is $value, 4 * [+](1..10000),
        "Integer CAS on lexical value with competing threads works ($attempt)";
}

# Test it works for an integer attribute.
for 1..4 -> $attempt {
    my class IntegerHolder {
        has atomicint $.value = 0;
        method add-a-lot() {
            for 1..10000 -> int $i {
                loop {
                    my int $orig = $!value;
                    last if cas($!value, $orig, $orig + $i) == $orig;
                }
            }
        }
    }

    my $obj = IntegerHolder.new;
    await start { $obj.add-a-lot() } xx 4;
    is $obj.value, 4 * [+](1..10000),
        "CAS on integer attribute with competing threads works ($attempt)";
}

# Test it works for an integer array element (single-dimension dynamic).
for 1..4 -> $attempt {
    my atomicint @values;
    @values[0] = 0;
    await start {
        for 1..10000 -> int $i {
            loop {
                my int $orig = @values[0];
                last if cas(@values[0], $orig, $orig + $i) == $orig;
            }
        }
    } xx 4;

    is @values[0], 4 * [+](1..10000),
        "CAS on integer resizable array with competing threads works ($attempt)";
}

# Test it works for an integer array element (single-dimension fixed).
for 1..4 -> $attempt {
    my atomicint @values[1];
    @values[0] = 0;
    await start {
        for 1..10000 -> int $i {
            loop {
                my int $orig = @values[0];
                last if cas(@values[0], $orig, $orig + $i) == $orig;
            }
        }
    } xx 4;

    is @values[0], 4 * [+](1..10000),
        "CAS on integer fixed 1-dim array with competing threads works ($attempt)";
}

# Test it works for an integer array element (multi-dimensional).
for 1..4 -> $attempt {
    my atomicint @values[2;2];
    @values[1;1] = 0;
    await start {
        for 1..10000 -> int $i {
            loop {
                my int $orig = @values[1;1];
                last if cas(@values[1;1], $orig, $orig + $i) == $orig;
            }
        }
    } xx 4;

    is @values[1;1], 4 * [+](1..10000),
        "CAS on integer 2-dim array with competing threads works ($attempt)";
}
