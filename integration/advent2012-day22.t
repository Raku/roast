# http://perl6advent.wordpress.com/2012/12/22/day-22-parsing-an-ipv4-address/
use v6;
use Test;

plan 6;

$_ = '1 23 456 78.9';
my @g;
@g.push(.Str) for m:g/(\d+)/;
is-deeply @g, [<1 23 456 78 9>».Str], 'm:g';

my @global;
@global.push(.Str) for m:global/(\d+)/;
is-deeply @global, [<1 23 456 78 9>».Str], 'm:global';

is-deeply [.comb(/\d+/)], [<1 23 456 78 9>».Str], 'comb';

$_ = "Go 127.0.0.1, I said! He went to 173.194.32.32.";

my @ip;
@ip.push(.Str) for m:g/ (\d ** 1..3) ** 4 % '.' /;
is-deeply @ip, [<127.0.0.1 173.194.32.32>], 'm:g';

my @ip4addrs = .comb(/ (\d ** 1..3) ** 4 % '.' /);
is-deeply @ip4addrs, [<127.0.0.1 173.194.32.32>], '.comb';

@ip = ();
@ip.push(.list) for m:g/ (\d ** 1..3) ** 4 % '.' /;
# https://github.com/Raku/old-issue-tracker/issues/3377
subtest 'integer parse' => {
    plan 11;

    is +@ip, 2, "did we get two top level matches";
    if @ip[0][0] -> $first {
        is $first, "127 0 0 1", 'first IP number';
        is $first[0], 127;
        is $first[1],   0;
        is $first[2],   0;
        is $first[3],   1;
    }
    if @ip[1][0] -> $second {
        is $second, "173 194 32 32", 'second IP number';
        is $second[0], 173;
        is $second[1], 194;
        is $second[2],  32;
        is $second[3],  32;
    }
}

# vim: expandtab shiftwidth=4
