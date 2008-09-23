use v6;

use Test;

# L<S29/Str/=item pos>

plan 2;

my $str = 'moose';
$str ~~ m/oo/;
eval_dies_ok('$str.pos', 'Str.pos superseeded by $/.to');

#?rakudo todo '$/.to'
is($/.to, 2, '$/.to works');
