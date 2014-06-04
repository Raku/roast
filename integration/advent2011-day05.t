#! http://perl6advent.wordpress.com/2011/12/05/the-flip-flop-operator/

use v6;
use Test;
plan 5;

is_deeply [gather for 1..20 { .take if $_ == 9  ff  $_ == 13; }], [9, 10, 11, 12, 13];
is_deeply [gather for 1..20 { .take if $_ == 9  ff^ $_ == 13; }], [9, 10, 11, 12];
is_deeply [gather for 1..20 { .take if $_ == 9 ^ff  $_ == 13; }], [10, 11, 12, 13];
is_deeply [gather for 1..20 { .take if $_ == 9 ^ff^ $_ == 13; }], [10, 11, 12];
is_deeply [gather for 1..20 { .take if $_ == 15 ff *; }], [15, 16, 17, 18, 19, 20];
