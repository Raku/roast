use v6;
use Test;
plan 7;

# L<S13/Type Casting/"whose name is a declared type, it is taken as a coercion
# to that type">

class CoercionTest {
    method Str  { "foo" };
    method Num  { 1.2   };
}

my $o = CoercionTest.new();
is ~$o, 'foo', 'method Str takes care of correct stringification';
ok +$o == 1.2, 'method Num takes care of correct numification';

# RT #69378
{
    class RT69378 {
        has $.x = 'working';
        method Str() { $.x }
    }
    is RT69378.new.Str, 'working', 'call to .Str works';

    class RT69378str is Str {
        has $.a = 'RT #69378';
        method Str() { $.a }
    }
    #?rakudo 2 todo 'RT 69378'
    is RT69378str.new.a, 'RT #69378', 'call to RT69378str.new properly initializes $.a';
    is RT69378str.new.Str, 'RT #69378', 'call to .Str works on "class is Str"';
}

is 1.Str.Str, "1", ".Str can be called on Str";
is "hello".Str, "hello", ".Str can be called on Str";

# vim: ft=perl6
