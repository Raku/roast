use v6;
use Test;
plan 13;

class Ap {
    has $.s;
    has @.a;
    has %.h;

    method ss($!s) { 3 }
    method sa(@!a) { 4 }
    method sh(%!h) { 5 }
    method ssa(*@!a) { 14 }
    method ssh(*%!h) { 15 }
}

my $x = Ap.new();

nok $x.s.defined, 'attribute starts undefined';
is  $x.ss('foo'), 3, 'attributive paramed method returns the right thing';
is  $x.s,         'foo', '... and it set the attribute';

nok $x.a,             'array attribute starts empty';
is  $x.sa([1, 2]), 4, 'array attributive paramed method returns the right thing';
is  $x.a.join('|'), '1|2', 'array param set correctly';

nok $x.h,             'hash attribute starts empty';
is  $x.sh({ a=> 1, b => 2}), 5, 'hash attributive paramed method returns the right thing';
#?pugs skip 'Cannot cast into Hash'
is  $x.h<b a>.join('|'), '2|1', 'hash param set correctly';

is  $x.ssa(1, 2), 14, 'slurpy array attributive paramed method returns the right thing';
is  $x.a.join('|'), '1|2', 'slurpy array param set correctly';

is  $x.ssh(a=> 1, b => 2), 15, 'slurpy hash attributive paramed method returns the right thing';
#?pugs skip 'Cannot cast into Hash'
is  $x.h<b a>.join('|'), '2|1', 'slurpy hash param set correctly';

done;

# vim: ft=perl6
