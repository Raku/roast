use v6;

use Test;

# L<S29/Str/=item pos>

plan 1;

my $str = 'moose';
$str ~~ m/oo/;
dies_ok($str.pos, 'Str.pos not implemented');
