use v6;
use Test;

# Test may seem weird, but Rakudo JVM fails it catastrophically at the moment.

plan 3;

my $i = 42;
do for <a b> -> $j {
    is $i, 42, '$i has proper value in loop';
}

is $i, 42, '$i still has proper value';

# vim: ft=perl6
