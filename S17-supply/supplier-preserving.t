use Test;

plan 1;

#?rakudo.jvm todo 'only first iteration of for loop gives correct result'
subtest "No races in Supplier::Preserving", {
    my @closings;
    sub make-supply() {
        my $s = Supplier::Preserving.new;
        my $done = False;
        start {
            until $done {
                $s.emit: ++$
            }
        }
        $s.Supply.on-close({ push @closings, 'x'; $done = True })
    }

    for ^10 {
        my $s2 = make-supply;
        my @received;
        react {
            whenever $s2 -> $n {
                push @received, $n;
                done if $n >= 5;
            }
        }
        is @received, [1,2,3,4,5], "Received expected messages ($_)";
    }

    is @closings.join, 'xxxxxxxxxx', 'Close called as expected';
}
