sub foo($bar) {
    Proxy.new( FETCH => sub (|) { }, STORE => sub (|) { } );
}
