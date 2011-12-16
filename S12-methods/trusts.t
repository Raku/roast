use v6;
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

eval_dies_ok 'Truster.new()!Truster::get-x-priv',
    'can not access private method without a trust';
is Trustee.x(Truster.new(x => 5)), 5, 'can access private method with trust';
is Trustee.x(ChildTruster.new(x => 5)), 5, 'can access private method with trust + subclass';
eval_dies_ok q[class ChildTrustee { method x($t) { $t!Truster>>get-x-priv()} }],
    'trust relation does not extend to child classes of the trustee'


# vim: ft=perl6
