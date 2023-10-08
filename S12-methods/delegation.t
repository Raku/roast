use Test;
plan 9;

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
is-approx $a.sqrt,   2,          'delegation to multiple names (1)';
is        $a.floor,  4,          'delegation to multiple names (2)';
is        $a.base(16), 'FF',     'delegation and arguments';
is        A.base(16),  'FF',     '... same with type object invocant';

{
    role R {
        method foo { self.bar(42) };
        method bar($x) { $x };
    };

    class C does R {
        method foo { self.R::foo };
    };

    is C.new.foo, 42, 'role method calls works through role delegation independent of declaration order.';

    role Rr {
        method bar($x) { $x };
        method foo { self.bar(42) };
    };

    class Cc does Rr {
        method foo { self.Rr::foo };
    };

    is Cc.new.foo, 42, 'role method calls works through role delegation independent of declaration order.';
}

# https://github.com/Raku/old-issue-tracker/issues/3721
{
    role R3721 {
        method foo () handles 'uc' { 'foo' }
    }

    my $r = R3721.new;
    is $r.foo, 'foo', 'method delegation works in roles (1)';
    is $r.uc, 'FOO', 'method delegation works in roles (2)';
}

# vim: expandtab shiftwidth=4
