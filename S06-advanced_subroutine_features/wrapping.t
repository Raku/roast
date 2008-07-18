use v6;

use Test;

plan 29;

# FIXME: There is probably a better way, perhapse using try/CATCH, but I was
# unable to figure out the try/CATCH syntax.
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
try{ $handle = &hi.wrap({ callsame ~ " there" }) };
nok_error( $!, "Wrapping seems to have failed." );

ok( $handle, "Recieved handle for unwrapping." );
is( hi, "Hi there", "Function produces expected output after wrapping" );

#unwrap the handle
try{ ok( $handle = &hi.unwrap( $handle ), "unwrap the function" )};
nok_error( $!, "Unwrapping seems to have failed" );

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
    try{ &levelwrap.wrap({  
        callwith( $^t++ )
    })};
    nok_error( $!, "Wrapping $num failed." );
    is( levelwrap( 1 ), 1 + $num, "Checking $num level wrapping" );
}

#TODO:
#Check removal of wrap in the middle by handle.
#nextsame
#nextwith
#temporization (end scope removal of wrapping)
#Redirecting





