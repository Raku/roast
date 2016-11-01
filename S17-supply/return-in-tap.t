use Test;
plan 1;

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

for ^200 {
    try-it;
}

is $caught, 200, 'return in a Supply quit handler works fine';
