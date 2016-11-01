use v6;
use Test;

# This stress test covers a SEGV in the following code, submitted in RT #129949.

plan 4;

sub bogosort_concurrent ( @list ) {
    my $sorted = Channel.new;

    start until $sorted.closed {
        start {
            my @guess = @list.pick(*);

            $sorted.send( @guess )
                if [!after] @guess;
        }
    }

    return $sorted.receive;
}

my @test_data = < p e r l s i x >;

for ^4 {
    is bogosort_concurrent(@test_data), [<e i l p r s x>], "Correct answer ($_)";
}
