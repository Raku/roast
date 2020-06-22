use v6;
use Test;

plan 2;

# L<S13/"Fallbacks"/"is also generated for you (unless you define it yourself).">

class Base {has $.value is rw;}
class Exponent {has $.value is rw;}

multi sub infix:<+> (Base $b, Exponent $e) is deep {$b.value ** $e.value}

my $base = Base.new();
my $exp  = Exponent.new();
$base.value = 2;
$exp.value  = 5;

is($base + $exp, 32, 'defining infix:<+> works');

$base += $exp;
is($base, 32, 'is deep generates infix:<+=> on infix:<+>');

# vim: expandtab shiftwidth=4
