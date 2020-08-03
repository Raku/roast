use v6;

use Test;
use experimental :macros;

plan 1;

# L<S06/Macros>
# XXX This test is likely to be reconsidered after the release of RakuAST

macro postfix:<!> (Int $n) {
    my $factorial = [*] 1..$n;
    return "$factorial + 0";
}

is 3!, 6, "macro postfix:<!> works";

# vim: expandtab shiftwidth=4
