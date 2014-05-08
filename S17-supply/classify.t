use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 89;

#?rakudo.jvm todo 3 "D: doesn't work in signatures"
dies_ok { Supply.classify( {...}  ) }, 'can not be called as a class method';
dies_ok { Supply.classify( {a=>1} ) }, 'can not be called as a class method';
dies_ok { Supply.classify( [<a>]  ) }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    my %mapper is default(0) = ( 11=>1, 12=>1, 13=>1 );
    my &mapper = { $_ div 10 };
    my @mapper = (0 xx 10, 1 xx 10);
    for &mapper, $%mapper, $@mapper -> \mapper {
        my $what = mapper.WHAT.perl;
        my $s = Supply.new;
        ok $s ~~ Supply, "we got a base Supply ($what)";
        my $c = $s.classify( mapper );
        ok $s ~~ Supply, "we got a classification Supply ($what)";

        my @keys;
        my @supplies;
        isa_ok $c.tap( -> $p {
            @keys.push: $p.key;
            @supplies.push: $p.value;
        } ), Tap, "we got a tap ($what)";

        $s.more($_) for 1,2,3,11,12,13;
        is_deeply @keys, [0,1], "did we get the right keys ($what)";
        tap_ok @supplies[0], [1,2,3],   "got the 0 supply ($what)", :live;
        tap_ok @supplies[1], [11,12,13], "got the 1 supply ($what)", :live;
    }
}
