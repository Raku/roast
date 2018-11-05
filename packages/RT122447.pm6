use v6.d;
sub foo($bar) {
    Proxy.new( FETCH => sub (|) { }, STORE => sub (|) { } );
}
