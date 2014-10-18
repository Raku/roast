use v6;

use Test;

plan 9;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.start({...}) }, 'can not be called as a class method';

{
    my $master = Supply.new;
    ok $master ~~ Supply, 'Did we get a master Supply?';
    my $starter = $master.start( { .sleep; $_ } );
    ok $starter ~~ Supply, 'Did we get a starter Supply?';

    my @supplies;
    my @taps;
    my @seen;
    my $tap = $starter.tap( {
        @supplies.push: $_;
        @taps.push: .tap( { @seen.push: $_ } );
    } );
    isa_ok $tap, Tap, 'Did we get a Tap';

    $master.emit(1);
    sleep 1;
    is +@supplies.grep( { $_ ~~ Supply } ), 1, 'did we get a supply?';
    is +@taps.grep(Tap),                    1, 'did we get a tap?';

    $master.emit(2);  # shall not be seen
    $master.emit(1);
    sleep 1;
    is +@supplies.grep( { $_ ~~ Supply } ), 3, 'did we get two extra supplies?';
    is +@taps.grep(Tap),                    3, 'did we get two extra taps?';
    is_deeply $@seen, [1,1], 'did we get the other original value';
}
