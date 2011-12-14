use v6;

# this tests that you can define mutators, that do more interesting
# things than merely assigning the value!

use Test;

plan 25;

class LValueMutator {
    has Int $.foo;
    has Int $!bar;

    method foo is rw {
        return $!bar;
    }
    method get_foo is rw {
        return $.foo;
    }
}

my $lvm = LValueMutator.new(:foo(3));
#?pugs todo 'oo'
# XXX is this correct? .new calls BUILD, which in turn calls bless,
# which in turns initializes the attributes directly
#?rakudo todo 'OO (test needs review)'
is($lvm.foo, 3, "constructor uses lvalue accessor method");
nok($lvm.get_foo.defined, "constructor doesn't simply set attributes");

lives_ok { $lvm.get_foo = 6 }, "lvalue accessors seem to work";
is($lvm.get_foo, 6, "lvalue accessors work");

lives_ok { $lvm.foo = 5 }, "lvalue accessors work still";
is($lvm.foo, 5, "mutator seems to work");

our $count = 0;

class MagicVal {
    has Int $.constant;
    has Int $.varies is rw;

    method varies returns Int is rw {
    $count++;
    my $var is Proxy( :for($.varies),
                :FETCH{ $.varies += 2 },
                :STORE{ $.varies = $_ + 1 },
                    );
    return $var;
    }
}

my $mv = MagicVal.new(:constant(6), :varies(6));

is($mv.constant, 6, "normal attribute");
is($mv.constant, 6, "normal attribute");
dies_ok { $mv.constant = 7 }, "can't change a non-rw attribute";
is($mv.constant, 6, "attribute didn't change value");

#?rakudo todo 'overring mutators'
is($count, 2, "mutator was called");
#?rakudo skip 'oo: mutators'
{
    is($mv.varies, 9, "mutator called during object construction");
    is($count, 3, "accessor was called");
    is($mv.varies, 11, "attribute with mutating accessor");
    is($count, 4, "accessor was called");

    $count = 0;
    $mv.varies = 13;
    is($count, 2, "mutator was called");
    is($mv.varies, 16, "attribute with overridden mutator");
    is($count, 3, "accessor and mutator were called");
}

# test interface tentatively not entirely disapproved of by
# all(@Larry) at L<"http://xrl.us/gnxp">
#?rakudo skip 'class Proxy'
{
    class MagicSub {
        has Int $.constant;
        has Int $.varies is rw;

        method varies returns Int is rw {
            return Proxy.new( 
                    :FETCH{ $.varies += 2 },
                    :STORE{ $.varies = $^v + 1 }
            );
        }
    }

    my $mv = MagicVal.new(:constant(6), :varies(6));

    is($mv.constant, 6, "normal attribute");
    is($mv.constant, 6, "normal attribute");
    dies_ok { $mv.constant = 7 }, "can't change a non-rw attribute";
    is($mv.constant, 6, "attribute didn't change value");

    is($mv.varies, 9, "mutator called during object construction");
    is($mv.varies, 11, "attribute with mutating accessor");

    $mv.varies = 13;
    is($mv.varies, 16, "attribute with overridden mutator");
}

# vim: ft=perl6
