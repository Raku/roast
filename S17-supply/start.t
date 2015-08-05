use v6;

use Test;

plan 9;

dies-ok { Supply.start({...}) }, 'can not be called as a class method';

{
    my $master = Supply.new;
    ok $master ~~ Supply, 'Did we get a master Supply?';
    my @promises = Promise.new xx 3;
    my $starter = $master.start( {
            sleep $_ - 1;
            state $counter = 0;
            @promises[$counter++].keep($_);
            $_
        }
    );
    ok $starter ~~ Supply, 'Did we get a starter Supply?';

    my @supplies;
    my @taps;
    my @seen;
    my $tap = $starter.tap( {
        @supplies.push: $_;
        @taps.push: .tap( { @seen.push: $_ } );
    } );
    isa-ok $tap, Tap, 'Did we get a Tap';

    $master.emit(1);
    await @promises[0];
    is +@supplies.grep( { $_ ~~ Supply } ), 1, 'did we get a supply?';
    is +@taps.grep(Tap),                    1, 'did we get a tap?';

    $master.emit(2);  # shall not be seen
    $master.emit(1);
    await @promises[2];
    is +@supplies.grep( { $_ ~~ Supply } ), 3, 'did we get two extra supplies?';
    is +@taps.grep(Tap),                    3, 'did we get two extra taps?';
    is @seen.join('|').substr(0, 3), '1|1', 'did we get the other original value';
}
