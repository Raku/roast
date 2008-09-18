use v6;
use Test;
plan 2;

# TODO: smartlink

our $collector = 2;
sub to_be_called($x) {
    $collector += $x;
}

sub tester(&my_sub) {
    my_sub(4);
}

tester(&to_be_called);
ok $collector == 6, 'Can call my_sub() if &my_sub was a parameter';

tester(sub ($x) { $collector = 3 * $x });
ok $collector == 12, 'same with anonymous sub';

# vim: ft=perl6
