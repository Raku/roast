use v6;

use Test;

plan 39;

#First level wrapping
sub hi { "Hi" };
is( hi, "Hi", "Basic sub." );
my $handle;
lives_ok( { $handle = &hi.wrap({ callsame() ~ " there" }) }, 
        "Basic wrapping works ");

ok( $handle, "Recieved handle for unwrapping." );
is( hi, "Hi there", "Function produces expected output after wrapping" );

#unwrap the handle
lives_ok { $handle = &hi.unwrap( $handle )}, "unwrap the function";

is( hi, "Hi", "Function is no longer wrapped." );

#Check 10 levels of wrapping
#useless function.
sub levelwrap($n) {
    return $n;
}

# Make sure useless function does it's job.
is( levelwrap( 1 ), 1, "Sanity test." );
is( levelwrap( 2 ), 2, "Sanity test." );

lives_ok { &levelwrap.callwith( 1 )},
    "Check that functions have a 'callwith' that works. ";

#?DOES 20
#?rakudo skip 'multiple wrapping'
{
    for (1..10) -> $num {
        lives_ok {
                &levelwrap.wrap({ 
                    callwith( $^t + 1 );
                }),
                " Wrapping #$num"
        }, "wrapping $num";
        is( levelwrap( 1 ), 1 + $num, "Checking $num level wrapping" );
    }
}

#Check removal of wrap in the middle by handle.
sub functionA {
    return 'z';
}
is( functionA(), 'z', "Sanity." );
my $middle;
lives_ok { $middle = &functionA.wrap(sub { return 'y' ~ callsame })}, 
        "First wrapping lived";
is( functionA(), "yz", "Middle wrapper sanity." );
lives_ok { &functionA.wrap(sub { return 'x' ~ callsame })}, 
         'Second wraping lived';
is( functionA(), "xyz", "three wrappers sanity." );
lives_ok { &functionA.unwrap( $middle )}, 'unwrap the middle wrapper.';
is( functionA(), "xz", "First wrapper and final function only, middle removed." );

#temporization (end scope removal of wrapping)
#?rakudo skip 'temp and wrap'
{
    sub functionB {
        return 'xxx';
    }
    is( functionB, "xxx", "Sanity" );
    {
        try {
            temp &functionB.wrap({ return 'yyy' });
        };
        is( functionB, 'yyy', 'Check that function is wrapped.' );
    }
    is( functionB, 'xxx', "Wrap is now out of scope, should be back to normal." );
}

#TODO:
#nextsame
#nextwith
#Redirecting

