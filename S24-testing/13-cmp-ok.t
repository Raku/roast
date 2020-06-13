use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

# Some things don't stringify well, so cmp-ok should show something better
# for them, like .gist or .raku:
is_run ｢use Test; cmp-ok 'foo', '~~', class {
    method raku { 'meowbar' }
    method gist { 'meowbar' }
    method Str  { die 'test failed' }
}.new｣, {:err(/meowbar/)},
'cmp-ok makes $expected more presentable than just its .Str';

cmp-ok Mu, '=:=', Mu, 'can use cmp-ok with `=:=` operator';

# vim: expandtab shiftwidth=4
