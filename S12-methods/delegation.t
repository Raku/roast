use v6;
use Test;
plan 5;

class A {
    method Str() handles 'uc' {
        'test';
    }
    method Num() handles <sqrt floor> {
        4e0;
    }

    method Int() handles 'base' {
        255
    }
}

my $a = A.new;
is        $a.uc,     'TEST',     'simple method delegation';
is_approx $a.sqrt,   2,          'delegation to multiple names (1)';
is        $a.floor,  4,          'delegation to multiple names (2)';
is        $a.base(16), 'FF',     'delegation and arguments';
is        A.base(16),  'FF',     '... same with type object invocant';
