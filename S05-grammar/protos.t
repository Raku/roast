use v6;

use Test;

plan 4;

# L<S05/Variable (non-)interpolation/Alternatively, if you predeclare a proto regex>

grammar Grammar::With::Protos {
    token TOP {
        <fred>+
    }

    proto token fred { <...> }

    token fred:sym<foo> {
        <sym> \d+
    }
    rule fred:sym<bar> {
        <sym> 'boz'+
    }
}

my $m = Grammar::With::Protos.parse("foo23bar bozboz foo42");

ok($m, 'parse succeeded');
is(~$m<fred>[0], "foo23",       "Submatch 1 correct");
is(~$m<fred>[1], "bar bozboz ", "Submatch 2 correct");
is(~$m<fred>[2], "foo42",       "Submatch 3 correct");

# vim: ft=perl6
