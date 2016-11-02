use v6;
use Test;

plan 5;

# This covers RT #127960, which crashed over GCing a locked mutex due to some bug.
{
	sub sleep_sort (*@list where .all >= 0) {
		my $channel = Channel.new;

		await @list.map: -> $delay {
		  Promise.start({
			sleep $delay / 1000;
			$channel.send($delay);
		  });
		};

		$channel.close;

		return $channel.list;
	}

	my @a = sleep_sort(3,2,1,5,4) xx 1000;
	ok all(@a).elems == 5, 'Sleep sort code produced correct lists on all runs';
}

# This stress test covers a SEGV in the following code, submitted in RT #129949.
{
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
}
