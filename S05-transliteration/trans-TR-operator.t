use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for TR/// transliteration operator

plan 12;

subtest 'TR///, writable $_' => { plan 2;
    temp $_ = 'meows';
    is-deeply TR/eox/EOX/, 'mEOws', 'return value';
    is-deeply $_, 'meows', '$_ has original value';
}

subtest 'TR///, read-only $_' => { plan 2;
    with 'meows' {
        is-deeply TR/eox/EOX/, 'mEOws', 'return value';
        is-deeply $_, 'meows', '$_ has original value';
    }
}

subtest 'TR:d///' => { plan 2;
    with 'meows' {
        is-deeply TR:d/eox/E/, 'mEws', 'return value';
        is-deeply $_, 'meows', '$_ has original value';
    }
}

subtest 'TR:delete///' => { plan 2;
    with 'meows' {
        is-deeply TR:delete/eow/EO/, 'mEOs', 'return value';
        is-deeply $_, 'meows', '$_ has original value';
    }
}

subtest 'TR:c///' => { plan 2;
    with 'meows' {
        is-deeply TR:c/ew/E/, 'EeEwE', 'return value';
        is-deeply $_, 'meows', '$_ has original value';
    }
}

subtest 'TR:complement///' => { plan 2;
    with 'meows' {
        is-deeply TR:complement/ew/E/, 'EeEwE', 'return value';
        is-deeply $_, 'meows', '$_ has original value';
    }
}

subtest 'TR:s///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:s/ew/E/, 'mEoooEs', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

subtest 'TR:squash///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:squash/ewZ/EWXY/, 'mEoooWEs', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

subtest 'TR:d:c///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:d:c/ewZ//, 'eeeewwweeee', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

subtest 'TR:d:s///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:d:s/ewZ/EWXY/, 'mEoooWEs', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

subtest 'TR:c:s///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:c:s/owZ/E/, 'EooowwwE', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

subtest 'TR:d:c:s///' => { plan 2;
    with 'meeeeooowwweeees' {
        is-deeply TR:d:c:s/ewZ//, 'eeeewwweeee', 'return value';
        is-deeply $_, 'meeeeooowwweeees', '$_ has original value';
    }
}

# vim: expandtab shiftwidth=4
