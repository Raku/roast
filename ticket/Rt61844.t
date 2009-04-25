use v6;

use Test;
plan 2;
    
my $slice_res;
eval_lives_ok '(0,1)[ * .. * ]', 'RT 61844 two Whatever stars slice should live';
is eval('$slice_res = (0,1)[ * .. * ]'), '0 1', 'RT 61844 two Whatever stars slice';

