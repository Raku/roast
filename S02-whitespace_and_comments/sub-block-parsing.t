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

plan 2;

ok(sub { 42 }(), 'sub {...} works'); # TODO: clarify
ok(sub{ 42 }(),  'sub{...} works'); # TODO: clarify

# vim: ft=perl6
