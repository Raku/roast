
use v6;
use Test;
plan 1;

# RT122423
is (42)[*/2], 42, 'Indexing half way into one element list';
