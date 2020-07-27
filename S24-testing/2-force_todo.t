use v6;
use Test;

plan 12;

#?rakudo eval "Module Test doesn't implement force_todo yet"
{
    force_todo(1, 3, 5, 7 .. 9, 11);

    flunk("This will fail, but will be forced-TODO by force_todo()");
    pass("This will pass normally");
    flunk("This will fail, but will be forced-TODO by force_todo()");
    pass("This will pass normally");
    flunk("This will TODO fail, and will be forced-TODO by force_todo()", :todo(1));
    pass("This will pass normally");
    flunk("This will fail, and will be forced-TODO by force_todo()");
    flunk("This will fail, and will be forced-TODO by force_todo()");
    flunk("This will fail, and will be forced-TODO by force_todo()");
    pass("This will pass normally");
    flunk("This will fail, and will be forced-TODO by force_todo()");
}

# XXX When this test passes it is likely the time to remove it and unfudge the main test body.
#?rakudo todo "Canary test for &Test::force_todo"
eval-lives-ok 'force_todo(12); flunk("failing on purpose")', "force_todo is implemented";

# vim: expandtab shiftwidth=4
