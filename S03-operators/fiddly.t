use v6;
use Test;
plan 1;

# RT #86340
# The [=] operator is fiddly and complier should not allow it

my $fiddly_code = 'my ($a, $b) = (1,2); my @c = [=] $a, $b;';

eval_dies_ok $fiddly_code , 'dies on fiddly code';

