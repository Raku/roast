use v6;
use Test;

plan 5;

# L<S13/"Syntax"/"If you declared a state variable within the body, for instance, there would only be one of them.">

# test the general multiple signatures functionality
class Base {has $.value is rw;}
class Exponent   {has $.value is rw;}

multi sub infix:<+> (Base $b, Exponent $e) |
                    (Exponent $e, Base $b) {$b.value ** $e.value}

my $base = Base.new();
my $exp  = Exponent.new();
$base.value = 2;
$exp.value  = 5;

is($base + $exp, 32, 'First order works');
is($exp + $base, 32, 'Second order works');

# specifically make sure that there is only one state variable
# this tells us that there is only one multi sub body
multi sub postfix:<!> (Base $x) |   #OK not used
                      (Exponent $x) {state $counter = 0; return ++$counter;}   #OK not used

is($base!, 1, 'shared routine test 1');
is($exp!,  2, 'shared routine test 2');
is($base!, 3, 'shared routine test 3');

# vim: ft=perl6
