use v6;

use Test;

# TODO: smartlink

# L<"http://use.perl.org/~autrijus/journal/25365">
# Closure composers like anonymous sub, class and module always trumps hash
# dereferences:
#
#   sub{...}
#   module{...}
#   class{...}

plan 5;

#?rakudo skip 'confused near "(sub { 42 "'
ok(sub { 42 }(), 'sub {...} works'); # TODO: clarify

#?rakudo skip 'confused near "(sub{ 42 }"'
ok(sub{ 42 }(),  'sub{...} works'); # TODO: clarify

#?rakudo todo 'unknown'
eval_dies_ok q[
    sub x { die }
    x();
], 'block parsing works with newline';

eval_dies_ok q[
    sub x { die };
    x();
], 'block parsing works with semicolon';

# RT #85844
{
    eval_dies_ok 'sub foo;', 'RT #85844'
}

done;

# vim: ft=perl6
