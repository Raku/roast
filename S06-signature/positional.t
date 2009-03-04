use v6;
use Test;
plan 3;

sub my_first  ($x, $,  $ ) { $x };
sub my_second ($,  $x, $ ) { $x };
sub my_third  ($,  $,  $x) { $x };

is my_first( 4, 5, 6), 4, '($x, $, $) works as a signature';
is my_second(4, 5, 6), 5, '($, $x, $) works as a signature';
is my_third( 4, 5, 6), 6, '($, $, $x) works as a signature';

# vim: ft=perl6
