use v6;
use Test;

plan 2;

# RT #129227
# We don't yet choose to set a maximum number of combiners, or a minimum that
# Perl 6 implementations must support. However, we should be sure that even if
# a ridiculously huge number is given, it either works or throws a catchable
# exception. This makes sure at the very least we do not SEGV in such cases,
# which is not acceptable behavior.
lives-ok { try 7 ~ "\x[308]" x 150_000 },
    'No VM crash on enormous number of combiners';

# RT #127973
#?rakudo.jvm todo 'repeat count (4294967295) cannot be greater than max allowed number of graphemes 2147483647'
eval-lives-ok 'my str $a = "a" x 2**32-1', 'native strings can be as large as regular strings';

# vim: ft=perl6
