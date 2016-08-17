use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;
plan 2;

is_run 'use Test; plan 3; ok 1; ok 0; ok 1;', {
    :out("1..3\nok 1 - \nnot ok 2 - \nok 3 - \n"),
    :err(/:i 'failed' .+ 'line 1' .+ 'failed 1 test of 3'/),
    :1status,
}, 'test failures without PERL6_TEST_DIE_ON_FAIL set do not die';

is_run 'BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;'
        ~ 'use Test; plan 3; ok 1; ok 0; ok 1;', {
    :out("1..3\nok 1 - \nnot ok 2 - \n"),
    :err(/:i
        'failed' .+ 'line 1' .+
        'Stopping test suite' .+ 'PERL6_TEST_DIE_ON_FAIL' .+
        'planned 3 tests, but ran 2' .+ 'failed 1 test of 2'
    /),
    :255status,
}, 'test failures with PERL6_TEST_DIE_ON_FAIL set die';

# vim: expandtab shiftwidth=4 ft=perl6
