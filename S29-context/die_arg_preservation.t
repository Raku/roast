use v6;
use Test;
plan 10;

# L<S29/Context/"=item die">

=begin pod

Tests that die() preserves the data type of its argument, 
and does not cast its argument as a Str.

=end pod


try {
    my Bool $foo = Bool::True;
    is( $foo.WHAT, Bool, 'arg to be given as die() arg contains a Bool value' );
    die $foo;
};
is( $!.WHAT, Bool, 'following try { die() } with Bool arg, $! contains a Bool value' );

try {
    my Int $foo = 42;
    is( $foo.WHAT, Int, 'arg to be given as die() arg contains a Int value' );
    die $foo;
};
is( $!.WHAT, Int, 'following try { die() } with Int arg, $! contains a Int value' );

try {
    my Str $foo = 'hello world';
    is( $foo.WHAT, 'Str', 'arg to be given as die() arg contains a Str value' );
    die $foo;
};
is( $!.WHAT, Str, 'following try { die() } with Str arg, $! contains a Str value' );

try {
    my Pair $foo = ('question' => 'answer');
    is( $foo.WHAT, Pair, 'arg to be given as die() arg contains a Pair value' );
    die $foo;
};
#?pugs todo 'bug'
is( $!.WHAT, Pair, 'following try { die() } with Pair arg, $! contains a Pair value');

try {
    my Object $foo .= new();
    is( $foo.WHAT, Object, 'arg to be given as die() arg contains a Object value' );
    die $foo;
};
is( $!.WHAT, Object, 'following try { die() } with Object arg, $! contains a Object value' );
