use v6;
unit module ArrayInit;

# used by t/spec/S10-packages/basic.t

sub array_init() is export {
    my @array;
    push @array, 'just one element';
    return ~@array;
}
