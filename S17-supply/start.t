use v6;

use Test;

plan 9;

dies-ok { Supply.start({...}) }, 'can not be called as a class method';

{
    my $master = Supply.new;
    ok $master ~~ Supply, 'Did we get a master Supply?';
    my @promises = Promise.new xx 3;
    my $starter = $master.start( {
            if $_ == 1 {
                await @promises[$_];
            }
            else {
                @promises[$_].keep($_);
            }
            $_
        }
    );
    ok $starter ~~ Supply, 'Did we get a starter Supply?';

    my @supplies;
    my @taps;
    my $seen = Channel.new;
    my $tap = $starter.tap( {
        @supplies.push: $_;
        @taps.push: .tap( { $seen.send: $_ } );
    } );
    isa-ok $tap, Tap, 'Did we get a Tap';

    $master.emit(0);
    await @promises[0];
    sleep 0.1;

    is +@supplies.grep( { $_ ~~ Supply } ), 1, 'did we get a supply?';
    is +@taps.grep(Tap),                    1, 'did we get a tap?';

    $master.emit(1);  # shall not be seen
    $master.emit(2);
    await @promises[2];
    my @seen = $seen.receive() xx 2;

    is +@supplies.grep( { $_ ~~ Supply } ), 3, 'did we get two extra supplies?';
    is +@taps.grep(Tap),                    3, 'did we get two extra taps?';
    is @seen.join('|'), '0|2', 'did we get the other original value';
    @promises[1].keep(2);
    $master.done;
}
