use v6;
use Test;

my @tests = 4, '5', 6e0, 7.0, DateTime.now, Duration.new(42), now,
    Date.today, '.'.IO, class Foo {}.new;

plan 2 + 2*@tests;

for @tests {
    is-deeply .minpairs, (0 => $_,).Seq, .^name ~ '.minpairs';
    is-deeply .maxpairs, (0 => $_,).Seq, .^name ~ '.maxpairs';
}

is-deeply (<a b c>, 4e0, '5', 6.0).maxpairs,
    (0 => ("a", "b", "c"),).Seq, 'maxpairs on a List of mixed types';
is-deeply (<a b c>, 4e0, '5', 6.0).minpairs,
    (1 => 4e0,).Seq, 'minpairs on a List of mixed types';

# vim: ft=perl6
