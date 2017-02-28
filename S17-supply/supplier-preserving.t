use Test;

plan 1;

#?rakudo.jvm todo 'only first iteration of for loop gives correct result'
subtest "No races in Supplier::Preserving", {
    my $closings = Channel.new;;
    sub make-supply() {
        my $s = Supplier::Preserving.new;
        my $done = False;
        start {
            until $done {
                $s.emit: ++$
            }
        }
        $s.Supply.on-close({ $closings.send('x'); $done = True })
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

    $closings.close;
    is $closings.list.join, 'xxxxxxxxxx', 'Close called as expected';
}
