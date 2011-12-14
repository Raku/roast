use v6;
use Test;
plan 35;

# L<S32::Numeric/Real/"=item sign">

=begin pod

Basic tests for the sign() builtin

=end pod

is(0.sign, 0, 'got the right sign for 0');
is(-100.sign, -1, 'got the right sign for -100');
is(100.sign, 1, 'got the right sign for 100');
is((3/2).sign, 1, 'got the right sign for 3/2');
is((-3/2).sign, -1, 'got the right sign for -3/2');
is(1.5e0.sign, 1, 'got the right sign for 1.5e1');
is(-1.5e0.sign, -1, 'got the right sign for -1.5e1');

isa_ok(0.sign, Int, 'got the right type for 0');
isa_ok(-100.sign, Int, 'got the right type for -100');
isa_ok(100.sign, Int, 'got the right type for 100');
isa_ok((3/2).sign, Int, 'got the right type for 3/2');
isa_ok((-3/2).sign, Int, 'got the right type for -3/2');
isa_ok(1.5e0.sign, Int, 'got the right type for 1.5e1');
isa_ok(-1.5e0.sign, Int, 'got the right type for -1.5e1');

is(sign(0), 0, 'got the right sign for 0');
is(sign(-100), -1, 'got the right sign for -100');
is(sign(100), 1, 'got the right sign for 100');
is(sign(1.5), 1, 'got the right sign for 1.5');
is(sign(-1.5), -1, 'got the right sign for -1.5');
is(sign(1.5e1), 1, 'got the right sign for 1.5e1');
is(sign(-1.5e1), -1, 'got the right sign for -1.5e1');

isa_ok(sign(0), Int, 'got the right type for 0');
isa_ok(sign(-100), Int, 'got the right type for -100');
isa_ok(sign(100), Int, 'got the right type for 100');
isa_ok(sign(1.5), Int, 'got the right type for 1.5');
isa_ok(sign(-1.5), Int, 'got the right type for -1.5');
isa_ok(sign(1.5e1), Int, 'got the right type for 1.5e1');
isa_ok(sign(-1.5e1), Int, 'got the right type for -1.5e1');

is(sign(Inf), 1, 'got correct sign for +Inf');
is(sign(-Inf), -1, 'got correct sign for -Inf');
isa_ok(sign(Inf), Int, 'got correct type for +Inf');
isa_ok(sign(-Inf), Int, 'got correct type for -Inf');
#?rakudo todo "Nom does not yet have a NaN framework in place"
#?niecza todo
is(sign(NaN),NaN, 'sign of NaN is NaN');

#?niecza todo
nok sign(Int).defined, 'sign(Int) is undefined';
#?rakudo skip "Test is kind of doubtful IMO -- colomon"
#?niecza skip '#90'
nok sign(3+4i).defined, 'sign(Complex) fails';

done;

# vim: ft=perl6
