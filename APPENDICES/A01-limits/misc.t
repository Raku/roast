use v6;
use Test;

plan 1;

# RT #129227
# We don't yet choose to set a maximum number of combiners, or a minimum that
# Perl 6 implementations must support. However, we should be sure that even if
# a ridiculously huge number is given, it either works or throws a catchable
# exception. This makes sure at the very least we do not SEGV in such cases,
# which is not acceptable behavior.
lives-ok { try 7 ~ "\x[308]" x 150_000 },
    'No VM crash on enormous number of combiners';

# vim: ft=perl6
