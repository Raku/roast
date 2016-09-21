use v6;
use Test;
plan 20;

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
is  $x.h<b a>.join('|'), '2|1', 'hash param set correctly';

is  $x.ssa(1, 2), 14, 'slurpy array attributive paramed method returns the right thing';
is  $x.a.join('|'), '1|2', 'slurpy array param set correctly';

is  $x.ssh(a=> 1, b => 2), 15, 'slurpy hash attributive paramed method returns the right thing';
is  $x.h<b a>.join('|'), '2|1', 'slurpy hash param set correctly';

# RT #125591
throws-like 'my class C { has $.x; submethod BUILD(:$.x) {} }',
    X::Syntax::VirtualCall, call => '$.x';

throws-like 'sub optimal($.x) { }', X::Syntax::NoSelf, variable => '$.x';
throws-like 'sub optimal($!x) { }', X::Syntax::NoSelf, variable => '$!x';

# RT #129278
{
    my class C {
        has int $!i;
        method xi($!i) {}
        method yi() { $!i }

        has num $!n;
        method xn($!n) {}
        method yn() { $!n }
    }
    my $o = C.new;
    $o.xi: 42;
    $o.xn: 1.5e0;
    is $o.yi, 42, 'Can use attributive binding on a native attribute (int, positional)';
    is $o.yn, 1.5e0, 'Can use attributive binding on a native attribute (num, positional)';
}
{
    my class C {
        has int $!i;
        method xi(:$!i) {}
        method yi() { $!i }

        has num $!n;
        method xn(:$!n) {}
        method yn() { $!n }
    }
    my $o = C.new;
    $o.xi: i => 69;
    $o.xn: n => 2.5e0;
    is $o.yi, 69, 'Can use attributive binding on a native attribute (int, named)';
    is $o.yn, 2.5e0, 'Can use attributive binding on a native attribute (num, named)';
}

# vim: ft=perl6
