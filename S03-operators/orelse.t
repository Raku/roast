use v6;
use Test;

is (1 orelse 2), 1, 'orelse basics';
is (1 orelse 2 orelse 3), 1, 'orelse chained';
is (Any orelse Int orelse 3), 3, 'orelse chained';
is (1 orelse 0), 1, 'definedness, not truthness';
ok 1 === (1 orelse Any), 'first defined value (1)';
ok 2 === (Any orelse 2), 'first defined value (2)';
my $tracker = 0;
ok (1 orelse ($tracker = 1)), 'sanity';
nok $tracker, 'orelse thunks';

#?rakudo todo "orelse exception semantics"
{
    try {
        die "oh noes!" orelse pass("orelse continues after an exception");
        CATCH { flunk "orelse shouldn't rethrow exceptions" }
    }
}

#?rakudo todo "orelse exception semantics"
{
    try {
        die "oh noes!" orelse ok(~$! eq "oh noes!", "orelse sets $! after an exception");
        CATCH { flunk "orelse shouldn't rethrow exceptions" }
    }
}

#?rakudo todo "orelse exception semantics"
{
    try {
        die "oh noes!" orelse -> $foo {
            ok ~$foo eq "oh noes!", "orelse passes $! to one argument after an exception";
        };
        CATCH { flunk "orelse shouldn't rethrow exceptions" }
    }
}

#?rakudo todo "orelse exception semantics"
{
    try {
        die "oh noes!" orelse -> $foo, $bar {
            ok ~$foo eq "oh noes!" && ~$bar eq "oh noes!", "orelse passes $! to two arguments after an exception";
        };
        CATCH { flunk "orelse shouldn't rethrow exceptions" }
    }
}


done;
