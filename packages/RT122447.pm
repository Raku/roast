use v6.c;
sub foo($bar) {
    Proxy.new( FETCH => sub (|) { }, STORE => sub (|) { } );
}
