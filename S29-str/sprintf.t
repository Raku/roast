use v6;

use Test;

plan 12;

# L<S29/Str/"identical to" "C library sprintf">

#?rakudo: 12 skip 'not yet implemented'
is sprintf("Hi"),                 "Hi",     "sprintf() works with zero args";
is sprintf("%03d",      3),       "003",    "sprintf() works with one arg";
is sprintf("%03d %02d", 3, 1),    "003 01", "sprintf() works with two args";
is sprintf("%d %d %d",  3,1,4),   "3 1 4",  "sprintf() works with three args";
is sprintf("%d%d%d%d",  3,1,4,1), "3141",   "sprintf() works with four args";

ok(eval('sprintf("%b",1)'),                  'eval of sprintf() with %b');

is sprintf("%04b",3),             '0011',   '0-padded sprintf() with %b';
is sprintf("%4b",3),              '  11',   '" "-padded sprintf() with %b';
is sprintf("%b",30),              '11110',  'longer string, no padding';
is sprintf("%2b",30),             '11110',  'padding specified, not needed';
is sprintf("%03b",7),             '111',    '0 padding, longer string';
is sprintf("%b %b",3,3),          '11 11',  'two args %b';
