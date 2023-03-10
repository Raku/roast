use Test;

plan 4;

# This is a reproduction of https://github.com/rakudo/rakudo/issues/5141

my $dummy-supply = supply { };

my $side-channel = Supplier.new;

my $supply0 = supply {
    emit "foo";
}

my $s1 = supply {
    whenever $supply0 {
        start {
            $side-channel.emit: "beep";
        }
        sleep 0.1;
        emit "bar";
    }
    whenever $dummy-supply {}
}

my $s2 = supply {
    whenever $side-channel.Supply {
       sleep 0.2;
    }
    whenever $s1 {
        emit "baz";
    }
}

my $tap;
my $done;

start { $tap = $s2.tap: :done({ $done = True }) }
for ^10 {
    last if $tap;
    sleep .1
}

ok $tap, "supply setup with recursion re-entering a supply doesn't deadlock";
isa-ok $tap, Tap, "got a tap";

my $closed;
start { $side-channel.done; $closed = True }
for ^10 {
    last if $closed;
    sleep .1
}

ok $closed, "emitting done didn't hang";
ok $done, "tap closes after last emitter is done";

