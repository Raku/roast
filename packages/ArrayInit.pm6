use v6.d;
unit module ArrayInit;

# used by S10-packages/basic.t

sub array_init() is export {
    my @array;
    push @array, 'just one element';
    return ~@array;
}
