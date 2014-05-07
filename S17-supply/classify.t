use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 33;

#?rakudo.jvm todo 3 "D: doesn't work in signatures"
dies_ok { Supply.classify( {...}  ) }, 'can not be called as a class method';
dies_ok { Supply.classify( {a=>1} ) }, 'can not be called as a class method';
dies_ok { Supply.classify( [<a>]  ) }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s = Supply.new;
        ok $s ~~ Supply, 'we got a base Supply';
        my $c = $s.classify( {.WHAT} );
        ok $s ~~ Supply, 'we got a classification Supply';

        my @keys;
        my @supplies;
        isa_ok $c.tap( -> $p {
            @keys.push: $p.key;
            @supplies.push: $p.value;
        } ), Tap, 'we got a tap';

        $s.more($_) for 1,2,3,<a b c>;
        is_deeply @keys, [Int, Str], 'did we get the right keys';
        tap_ok @supplies[0], [1,2,3],   'got the Int supply', :live;
        tap_ok @supplies[1], [<a b c>], 'got the Str supply', :live;
    }
}
