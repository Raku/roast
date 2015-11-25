use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 33;

dies-ok { Supply.classify( {...}  ) }, 'can not be called as a class method';
dies-ok { Supply.classify( {a=>1} ) }, 'can not be called as a class method';
dies-ok { Supply.classify( [<a>]  ) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    my %mapper is default(0) = ( 11=>1, 12=>1, 13=>1 );
    my &mapper = { $_ div 10 };
    my @mapper = 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1;
    for &mapper, %mapper, @mapper -> \mapper {
        diag "mapping {mapper.^name} now";
        my $what = mapper.WHAT.perl;
        my $s = Supplier.new;
        my $c = $s.Supply.classify( mapper );
        ok $c ~~ Supply, "we got a classification Supply ($what)";

        my @keys;
        my @supplies;
        isa-ok $c.tap( -> $p {
            @keys.push: $p.key;
            @supplies.push: $p.value;
        } ), Tap, "we got a tap ($what)";

        $s.emit($_) for 1,2,3,11,12,13;
        is-deeply @keys, [0,1], "did we get the right keys ($what)";
        tap-ok @supplies[0], [1,2,3],   "got the 0 supply ($what)", :live;
        tap-ok @supplies[1], [11,12,13], "got the 1 supply ($what)", :live;
    }
}
