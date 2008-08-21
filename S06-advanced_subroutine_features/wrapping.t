use v6;

use Test;

plan 39;

# FIXME: There is probably a better way, perhapse using try/CATCH, but I was
# unable to figure out the try/CATCH syntax.
# All these tests should be re-written in terms of lives_ok();
sub nok_error( $error, $message? ) {
    if ( $error ) {
        say( $error );
        ok( 0, $message );
    }
}

#First level wrapping
sub hi { "Hi" };
is( hi, "Hi", "Basic sub." );
my $handle;
lives_ok( { $handle = &hi.wrap({ callsame ~ " there" }) }, 
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

try{ is( &levelwrap.callwith( 1 ), 1, "Check that functions have a 'callwith' that works. " )};
nok_error( $!, "callwith does not seem to work." );

for (1..10) -> $num {
    try{
        ok( 
            &levelwrap.wrap({ 
                callwith( $^t++ );
            }),
            " Wrapping #$num"
        )
    };
    nok_error( $!, "Wrapping $num failed." );
    is( levelwrap( 1 ), 1 + $num, "Checking $num level wrapping" );
}

#Check removal of wrap in the middle by handle.
sub functionA {
    return 'z';
}
is( functionA, 'z', "Sanity." );
my $middle;
try { ok( $middle = &functionA.wrap({ return 'y' ~ callsame }))};
nok_error( $!, "Wrapping failed." );
is( functionA, "yz", "Middle wrapper sanity." );
try { ok( &functionA.wrap({ return 'x' ~ callsame }))};
nok_error( $!, "Wrapping failed." );
is( functionA, "xyz", "three wrappers sanity." );
try { ok( &functionA.unwrap( $middle ))};
nok_error( $!, "Failed to unwrap the middle wrapper." );
is( functionA, "xz", "First wrapper and final function only, middle removed." );

#temporization (end scope removal of wrapping)
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


#TODO:
#nextsame
#nextwith
#Redirecting

