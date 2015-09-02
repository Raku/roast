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
@ip.push(.list>>.Str[0].perl) for m:g/ (\d ** 1..3) ** 4 % '.' /;
# RT #121789'
is-deeply @ip, [q<["127", "0", "0", "1"]>, q<["173", "194", "32", "32"]>], 'integer parse';

