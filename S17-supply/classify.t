use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 61;

#?rakudo.jvm todo 3 "D: doesn't work in signatures"
dies_ok { Supply.classify( {...}  ) }, 'can not be called as a class method';
dies_ok { Supply.classify( {a=>1} ) }, 'can not be called as a class method';
dies_ok { Supply.classify( [<a>]  ) }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    my %mapper is default(Int) = ( a=>Str, b=>Str, c=>Str );
    my &mapper = {.WHAT};
    for &mapper, $%mapper -> \mapper {
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

        $s.more($_) for 1,2,3,<a b c>;
        is_deeply @keys, [Int, Str], "did we get the right keys ($what)";
        tap_ok @supplies[0], [1,2,3],   "got the Int supply ($what)", :live;
        tap_ok @supplies[1], [<a b c>], "got the Str supply ($what)", :live;
    }
}
