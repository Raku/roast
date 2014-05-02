use v6;
use lib 't/spec/packages';

use Test;

plan 5;

{
    my $master = Supply.new;
    ok $master ~~ Supply, 'Did we get a Supply?';
    my $migrate = $master.migrate;
    ok $migrate ~~ Supply, 'Did we get a Supply?';

    my $s1 = Supply.new;
    ok $s1 ~~ Supply, 'Did we get a Supply?';
    $master.more($s1);

    my @seen;
    my $tap = $migrate.tap( { .say; @seen.push: $_ } );
    isa_ok $tap, Tap, 'Did we get a Tap';

    $s1.more(1);
    is +@seen, 1, 'did we get this?';
}
