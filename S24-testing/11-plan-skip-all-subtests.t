use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;
plan 4;

# `plan skip-all` returns from subtest Callables. In order to be able
# to do that right, it needs a Callable in which a `return` can be used.
# So, test that we cry about wanting a sub when skip-all is used inside
# a subtest with a Block as Callable

is_run ｢use Test; plan 1; subtest "foo" => { plan skip-all => "fail" }｣,
    {:err(/Sub/), :status(*.so)},
'trying to skip-all inside Block of 1st-level subtest';

is_run ｢use Test; plan 1; subtest "x" => sub { plan 1; ｣
        ~ ｢subtest "foo" => { plan skip-all => "fail" } }｣,
    {:err(/Sub/), :status(*.so)},
'trying to skip-all inside Block of 2nd-level subtest';

subtest "level-one subtest with skip-all" => sub {
    plan skip-all => "Testing skippage of `plan skip-all`";
    plan 1;
    flunk "`plan skip-all` did not return from subtest";
}

subtest "level-one subtest with level-two subtest with skip-all" => {
    plan 2;
    subtest "level-two subtest with skip-all" => sub {
        plan skip-all => "Testing skippage of `plan skip-all`";
        plan 1;
        flunk "`plan skip-all` did not return from subtest";
    }
    ok 1, "skip-all inside subtests does not skip outside tests";
}

# vim: expandtab shiftwidth=4 ft=perl6
