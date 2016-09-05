use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;
plan 3;

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

is_run 'BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;'
        ~ 'use Test; plan 2; todo "foo"; ok 0; ok 0, "test-ok"', {
    :out(/'test-ok'/),
    :1status,
}, 'PERL6_TEST_DIE_ON_FAIL does not exit on failed TODO tests';


#      got status: 1
#      got out: "1..2\nnot ok 1 - # TODO foo\n\n# Failed test at getout-21997-614887.code line 1\n# expected: '72'\n#      got: '42'\nnot ok 2 - test-ok\n"
# expected out: "1..3\nok 1 - \nnot ok 2 - \n"
#      got err: "\n# Failed test 'test-ok'\n# at getout-21997-614887.code line 1\n# expected: '72'\n#      got: '42'\n# Test failed. Stopping test suite, because PERL6_TEST_DIE_ON_FAIL environmental variable is set to a true value.\n# Looks like you failed 1 test of 2\n"


# vim: expandtab shiftwidth=4 ft=perl6
