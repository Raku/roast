use v6;

# this tests that you can define mutators, that do more interesting
# things than merely assigning the value!

use Test;

plan 12;

our $count = 0;

class MagicVal {
    has Int $.constant;
    has Int $.varies = 0;

    method varies returns Int is rw {
        $count++;
        return Proxy.new(
            # note that FETCH and STORE cannot go through the accessors
            # of $.varies again, because that would lead to infinite
            # recursion. Use the low-level attribute here instead
            FETCH => method ()     { $!varies += 2 },
            STORE => method ($new) { $!varies = $new + 1 },
        );
    }
}

my $mv = MagicVal.new(:constant(6), :varies(6));

is($mv.constant, 6, "normal attribute");
is($mv.constant, 6, "normal attribute");
dies_ok { $mv.constant = 7 }, "can't change a non-rw attribute";
is($mv.constant, 6, "attribute didn't change value");

is($count, 0, "mutator not called yet");
#?rakudo skip "No applicable candidates found to dispatch to for 'Numeric'."
{
    is($mv.varies, 8, "mutator called during object construction");
    is($count, 1, "accessor was called");
    is($mv.varies, 10, "attribute with mutating accessor");
    is($count, 2, "accessor was called");

    $count = 0;
    $mv.varies = 13;
    is($count, 1, "mutator was called");
    is($mv.varies, 16, "attribute with overridden mutator");
    is($count, 2, "accessor and mutator were called");
}
