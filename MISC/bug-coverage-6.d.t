use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 1;

throws-like ｢
    use v6.d;
    sub foo { whenever Promise.in(2) { say ‘hello’ } }; react foo
｣, X::Comp::WheneverOutOfScope, 'whenever not in lexical scope of react throws';

# vim: expandtab shiftwidth=4
