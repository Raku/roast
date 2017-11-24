use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;
plan 6;

my $Die-Off = 'BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 0;';
my $Die-On  = 'BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;';

is_run $Die-Off ~ 'use Test; plan 3; ok 1; ok 0; ok 1;', {
    :out("1..3\nok 1 - \nnot ok 2 - \nok 3 - \n"),
    :err(/:i 'failed' .+ 'line 1' .+ 'failed 1 test of 3'/),
    :1status,
}, 'test failures without PERL6_TEST_DIE_ON_FAIL set do not die';

is_run $Die-On ~ 'use Test; plan 3; ok 1; ok 0; ok 1;', {
    :out("1..3\nok 1 - \nnot ok 2 - \n"),
    :err(/:i
        'failed' .+ 'line 1' .+
        'Stopping test suite' .+ 'PERL6_TEST_DIE_ON_FAIL' .+
        'planned 3 tests, but ran 2' .+ 'failed 1 test of 2'
    /),
    :255status,
}, 'test failures with PERL6_TEST_DIE_ON_FAIL set die';

is_run $Die-On ~ 'use Test; plan 2; todo "foo"; ok 0; ok 1, "test-ok"', {
    :out(/'test-ok'/),
    :0status,
}, 'PERL6_TEST_DIE_ON_FAIL does not exit on failed TODO tests';

# RT #129192
is_run $Die-On ~ 'use Test; plan 1; is "x", "test-ok"', {
    :err(/'test-ok'/),
    :255status,
}, 'test failure diagnostics show up when PERL6_TEST_DIE_ON_FAIL is used';

is_run $Die-On ~ 'use Test; plan 1; todo "foo"; subtest "bar", { plan 2; '
        ~ 'ok 0; subtest "ber", { ok 0 } };', {
    :0status,
}, 'PERL6_TEST_DIE_ON_FAIL does not exit in subtests that may be TODOed';

is_run $Die-On ~ 'use Test; plan 2; subtest "bar", { ok 0 }; ok 1', {
    :err(/:i
        'failed' .+
        'Stopping test suite' .+ 'PERL6_TEST_DIE_ON_FAIL'
    /),
    :255status,
}, 'PERL6_TEST_DIE_ON_FAIL exits even when failures are inside subtests';

# vim: expandtab shiftwidth=4 ft=perl6
