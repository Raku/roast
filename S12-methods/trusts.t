use v6.c;
use Test;

plan 4;

class Trustee { ... }
class Truster {
    trusts Trustee;
    has $.x;
    method !get-x-priv {
        $!x;
    }
}

class ChildTruster is Truster { };

class Trustee {
    method x($truster) {
        $truster!Truster::get-x-priv();
    }
}

throws-like 'Truster.new()!Truster::get-x-priv', X::Method::Private::Permission,
    'can not access private method without a trust';
is Trustee.x(Truster.new(x => 5)), 5, 'can access private method with trust';
is Trustee.x(ChildTruster.new(x => 5)), 5, 'can access private method with trust + subclass';
throws-like q[class ChildTrustee is Trustee { method x($t) { $t!Truster::get-x-priv()} }],
    X::Method::Private::Permission,
    'trust relation does not extend to child classes of the trustee'


# vim: ft=perl6
