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

plan *;

#?rakudo skip 'confused near "(sub { 42 "'
ok(sub { 42 }(), 'sub {...} works'); # TODO: clarify

#?rakudo skip 'confused near "(sub{ 42 }"'
ok(sub{ 42 }(),  'sub{...} works'); # TODO: clarify

#?rakudo todo 'block parsing problem'
eval_dies_ok q[
    sub x { die }
    x();
], 'block parsing works with newline';

eval_dies_ok q[
    sub x { die };
    x();
], 'block parsing works with semicolon';

done_testing;

# vim: ft=perl6
