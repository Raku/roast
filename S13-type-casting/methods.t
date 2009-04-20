use v6;
use Test;
plan 2;

# L<S13/Type Casting/"whose name is a declared type, it is taken as a coercion
# to that type">

class CoercionTest {
    method Str  { "foo" };
    method Num  { 1.2   };
}

my $o = CoercionTest.new();
is ~$o, 'foo', 'method Str takes care of correct stringification';
ok +$o == 1.2, 'method Num takes care of correct numification';

# vim: ft=perl6
