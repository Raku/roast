use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# Tests for tr/// transliteration operator

plan 13;

throws-like { with 'meows' { tr/eox/EOX/ } }, X::Assignment::RO,
    'tr///, read-only $_complains';

subtest 'tr///' => { plan 2;
    temp $_ = 'meows';
    is-deeply tr/eox/EOX/, StrDistance.new(:before<meows>, :after<mEOws>),
        'return value';
    is-deeply $_, 'mEOws', '$_ has updated value';
}

subtest 'tr:d///' => { plan 2;
    temp $_ = 'meows';
    is-deeply tr:d/eox/E/, StrDistance.new(:before<meows>, :after<mEws>),
        'return value';
    is-deeply $_, 'mEws', '$_ has updated value';
}

subtest 'tr:delete///' => { plan 2;
    temp $_ = 'meows';
    is-deeply tr:delete/eow/EO/, StrDistance.new(:before<meows>, :after<mEOs>),
        'return value';
    is-deeply $_, 'mEOs', '$_ has updated value';
}

subtest 'tr:c///' => { plan 2;
    temp $_ = 'meows';
    is-deeply tr:c/ew/E/, StrDistance.new(:before<meows>, :after<EeEwE>),
        'return value';
    is-deeply $_, 'EeEwE', '$_ has updated value';
}

subtest 'tr:complement///' => { plan 2;
    temp $_ = 'meows';
    is-deeply tr:complement/ew/E/,
        StrDistance.new(:before<meows>, :after<EeEwE>), 'return value';
    is-deeply $_, 'EeEwE', '$_ has updated value';
}

subtest 'tr:s///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:s/ew/E/,
        StrDistance.new(:before<meeeeooowwweeees>, :after<mEoooEs>),
        'return value';
    is-deeply $_, 'mEoooEs', '$_ has updated value';
}

subtest 'tr:squash///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:squash/ewZ/EWXY/,
        StrDistance.new(:before<meeeeooowwweeees>, :after<mEoooWEs>),
        'return value';
    is-deeply $_, 'mEoooWEs', '$_ has updated value';
}

subtest 'tr:d:c///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:d:c/ewZ//,
        StrDistance.new(:before<meeeeooowwweeees>, :after<eeeewwweeee>),
        'return value';
    is-deeply $_, 'eeeewwweeee', '$_ has updated value';
}

subtest 'tr:d:s///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:d:s/ewZ/EWXY/,
        StrDistance.new(:before<meeeeooowwweeees>, :after<mEoooWEs>),
        'return value';
    is-deeply $_, 'mEoooWEs', '$_ has updated value';
}

subtest 'tr:c:s///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:c:s/owZ/E/,
        StrDistance.new(:before<meeeeooowwweeees>, :after<EooowwwE>),
        'return value';
    is-deeply $_, 'EooowwwE', '$_ has updated value';
}

subtest 'tr:d:c:s///' => { plan 2;
    temp $_ = 'meeeeooowwweeees';
    is-deeply tr:d:c:s/ewZ//,
        StrDistance.new(:before<meeeeooowwweeees>, :after<eeeewwweeee>),
        'return value';
    is-deeply $_, 'eeeewwweeee', '$_ has updated value';
}

# Issue R#2456
subtest 'tr/// with literal \\' => { plan 2;
    temp $_ = 'a\\b';
    is-deeply tr/\\_//, StrDistance.new(:before<a\\b>, :after<ab>),
        'return value';
    is-deeply $_, 'ab', '$_ has updated value';
}

# vim: expandtab shiftwidth=4
