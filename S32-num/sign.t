use v6;
use Test;
plan 14;

# L<S29/Num/"=item sign">

=begin pod

Basic tests for the sign() builtin

=end pod

is(sign(0), 0, 'got the right sign for 0');
is(sign(-100), -1, 'got the right sign for -100');
is(sign(100), 1, 'got the right sign for 100');
is(sign(1.5), 1, 'got the right sign for 1.5');
is(sign(-1.5), -1, 'got the right sign for -1.5');
is(sign(-Inf),-1, 'got correct sign for -Inf');

is(sign(Inf), 1, 'got correct sign for +Inf');
is(sign(NaN),NaN, 'sign of NaN is NaN');

#?rakudo skip 'named args'
{
   is(sign(:x(0)), 0, 'got the right sign for 0');
   is(sign(:x(-100)), -1, 'got the right sign for -100');
   is(sign(:x(100)), 1, 'got the right sign for 100');
   is(sign(:x(1.5)), 1, 'got the right sign for 1.5');
   is(sign(:x(-1.5)), -1, 'got the right sign for -1.5');
}

#?rakudo todo 'feature'
dies_ok { sign(undef) }, 'sign on undefined value fails';
