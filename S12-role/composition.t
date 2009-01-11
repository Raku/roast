use v6;
use Test;
plan 8;

# L<S12/Roles/"Roles may be composed into a class at compile time">

role rA {
    method mA1 {
        'mA1';
    }
    method mA2 {
        'mA2';
    }
};

role rB {
    method mB1 {
        'mB1';
    }
    method mB2 {
        'mB2';
    }
};

class C1 does rA {
    method mC1 {
        'mC1';
    }
};

my $x = C1.new();

is $x.mC1,      'mC1',      'Can call method of class with mixed in role';
is $x.mA1,      'mA1',      'Call first method from role';
is $x.mA2,      'mA2',      'Call second method from role';

class C2 does rA does rB {
    method mC2 {
        'mC2';
    }
}

my $y = C2.new();

is $y.mC2,      'mC2',      'Can call method of class with two roles mixed in';
is $y.mA1,      'mA1',      'Can call mixed in method (two roles) 1';
is $y.mA2,      'mA2',      'Can call mixed in method (two roles) 2';
is $y.mB1,      'mB1',      'Can call mixed in method (two roles) 3';
is $y.mB2,      'mB2',      'Can call mixed in method (two roles) 4';

class D1 does rA {
    method mA1 {
        'D1.mA1';
    }
}

my $z = D1.new();

is $z.mA1,      'D1.mA1',   'Can override method in a role with method in a class';

# vim: syn=perl6
