# http://perl6advent.wordpress.com/2012/12/22/day-22-parsing-an-ipv4-address/
use v6;
use Test;

plan 6;

$_ = '1 23 456 78.9';
my @g;
@g.push(.Str) for m:g/(\d+)/;
is_deeply @g, [<1 23 456 78 9>], 'm:g';

my @global;
@global.push(.Str) for m:global/(\d+)/;
is_deeply @global, [<1 23 456 78 9>], 'm:global';

is_deeply [.comb(/\d+/)], [<1 23 456 78 9>], 'comb';

$_ = "Go 127.0.0.1, I said! He went to 173.194.32.32.";

my @ip;
@ip.push(.Str) for m:g/ (\d ** 1..3) ** 4 % '.' /;
is_deeply @ip, [<127.0.0.1 173.194.32.32>], 'm:g';

my @ip4addrs = .comb(/ (\d ** 1..3) ** 4 % '.' /);
is_deeply @ip4addrs, [<127.0.0.1 173.194.32.32>], '.comb';

@ip = ();
@ip.push(.list>>.Str.perl) for m:g/ (\d ** 1..3) ** 4 % '.' /;
#?rakudo todo 'RT121789'
is_deeply @ip, [q<("127", "0", "0", "1")>, q<("173", "194", "32", "32")>], 'integer parse';

