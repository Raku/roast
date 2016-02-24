use v6.c;

# this tests that you can define mutators, that do more interesting
# things than merely assigning the value!

use Test;

plan 10;

our $count = 0;

class MagicVal {
    has Int $.constant;
    has Int $.varies = 0;

    method varies is rw {
        $count++;
        return Proxy.new(
            # note that FETCH and STORE cannot go through the accessors
            # of $.varies again, because that would lead to infinite
            # recursion. Use the actual attribute here instead
            FETCH => method ()     { $!varies  },
            STORE => method ($new) { $!varies = $new + 1 },
        );
    }
}

my $mv = MagicVal.new(:constant(6), :varies(6));

is($mv.constant, 6, "normal attribute");
is($mv.constant, 6, "normal attribute");
dies-ok { $mv.constant = 7 }, "can't change a non-rw attribute";
is($mv.constant, 6, "attribute didn't change value");

is($count, 0, "mutator not called yet");
#?rakudo skip 'RT #126198'
{
    is($mv.varies, 6, "mutator called during object construction");
    is($count, 1, "accessor was called");

    $count = 0;
    $mv.varies = 13;
    is($count, 1, "mutator was called");
    is($mv.varies, 14, "attribute with overridden mutator");
    is($count, 2, "accessor and mutator were called");
}
