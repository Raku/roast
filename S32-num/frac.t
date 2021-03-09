use v6;
use Test;

plan 42;

# L<S32::Numeric/Real/"=item frac">

=begin pod

Basic tests for the frac() builtin

=end pod

is(0.frac, 0, 'got the right frac result for 0');
is(-100.frac, 0, 'got the right frac result for -100');
is(100.frac, 0, 'got the right frac result for 100');
is((3/2).frac, 0.5, 'got the right frac result for 3/2');
is((-3/2).frac, 0.5, 'got the right frac result for -3/2');
is(1.5e0.frac, 0.5, 'got the right frac result for 1.5e0');
# note the space in the test below is needed due to precedence of '-' over the method
is(-1.5e0 .frac, 0.5, 'got the right frac result for -1.5e0');

isa-ok(0.frac, Real, 'got the right type for 0');
isa-ok(-100.frac, Real, 'got the right type for -100');
isa-ok(100.frac, Real, 'got the right type for 100');
isa-ok((3/2).frac, Real, 'got the right type for 3/2');
isa-ok((-3/2).frac, Real, 'got the right type for -3/2');
isa-ok(1.5e0.frac, Real, 'got the right type for 1.5e0');
isa-ok(-1.5e0.frac, Real, 'got the right type for -1.5e0');

is(frac(0), 0, 'got the right frac result for 0');
is(frac(-100), 0, 'got the right frac result for -100');
is(frac(100), 0, 'got the right frac result for 100');
is(frac(1.5), 0.5, 'got the right frac result for 1.5');
is(frac(-1.5), 0.5, 'got the right frac result for -1.5');
is(frac(1.5e0), 0.5, 'got the right frac result for 1.5e0');
is(frac(-1.5e0), 0.5, 'got the right frac result for -1.5e0');

isa-ok(frac(0), Real, 'got the right type for 0');
isa-ok(frac(-100), Real, 'got the right type for -100');
isa-ok(frac(100), Real, 'got the right type for 100');
isa-ok(frac(1.5), Real, 'got the right type for 1.5');
isa-ok(frac(-1.5), Real, 'got the right type for -1.5');
isa-ok(frac(1.5e0), Real, 'got the right type for 1.5e0');
isa-ok(frac(-1.5e0), Real, 'got the right type for -1.5e0');

throws-like { frac(Int) }, Exception;
throws-like { frac(NaN) }, Exception;
throws-like { frac(Int) }, Exception;

is frac(1.5), 0.5; 
is frac(2), 0; 
is frac(1.4999), 0.4999;
is frac(-0.1), 0.1; 
is frac(-1), 0; 
is frac(-5.9), 0.9;
is frac(-0.5), 0.5; 
is frac(-0.499), 0.499; 
is frac(-5.499), 0.499;
is frac(2), 0;
is frac(1.23456), 0.23456;

# vim: expandtab shiftwidth=4
