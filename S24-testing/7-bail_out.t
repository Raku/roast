use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;
plan 4;

is_run 'use Test; ok 1, "test runs"; bail-out; done-testing',
    { :out("ok 1 - test runs\nBail out!\n"), :err(''), :255status },
    'bail out without a description or plan';

is_run 'use Test; plan 2; ok 1, "test runs"; bail-out; ok 1, "no test";',
    { :out("1..2\nok 1 - test runs\nBail out!\n"), :err(''), :255status },
    'no more tests run after bailing out';

is_run 'use Test; ok 1, "test runs"; bail-out "some reason";',
    { :out("ok 1 - test runs\nBail out! some reason\n"), :err(''), :255status },
    'bail out with description';

# RT#131408
is_run 'use Test; bail-out', { :err(''), :out("Bail out!\n"), :255status },
    'immediate bail out does not crash';

# vim: expandtab shiftwidth=4 ft=perl6
