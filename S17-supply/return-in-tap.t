use Test;
plan 1;

# This test does many iterations, to catch a couple of problems that showed up
# when using code like this:
# * A GC failure due to locks being freed while still locked
# * A JIT bug

sub dying($in) {
    supply {
        whenever $in {
            die "oh no"; 
        }   
    }   
}

my $caught = 0;

sub try-it() {
    my $fake-in = Supplier.new;
    dying($fake-in.Supply).tap:
        quit => -> $exception {
            $caught++;
            return;
        };
    $fake-in.emit("XXX");
}

for ^1000 {
    try-it;
}

is $caught, 1000, 'return in a Supply quit handler works fine';
