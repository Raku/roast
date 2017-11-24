use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 6;

isa-ok @*ARGS, Array, '@*ARGS is an Array';
is-deeply @*ARGS, [], 'by default @*ARGS is empty array';

lives-ok { @*ARGS = 1, 2 }, '@*ARGS is writable';

use Test::Util;

is_run 'print @*ARGS.join(q[, ])', :args[1, 2, "foo"],
    {
        out => '1, 2, foo',
        err => '',
        status => 0,
    }, 'providing command line arguments sets @*ARGS';

is_run 'for @*ARGS[ 1 ..^ +@*ARGS ] { .say };', :args[1, 'two', 'three'],
    {
        out => "two\nthree\n",
        err => '',
        status => 0,
    }, 'postcircumfix:<[ ]> works for @*ARGS';

is_run 'my @a = @*ARGS; for @a[ 1 ..^ +@*ARGS ] { .say };', :args[1, 'two', 'three'],
    {
        out => "two\nthree\n",
        err => '',
        status => 0,
    }, 'can copy @*ARGS to array.';
