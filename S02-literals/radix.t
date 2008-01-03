use v6-alpha;
use Test;

plan 20;

# L<S02/Literals>


# L<S02/Literals/":8<177777>">
# L<S29/Conversions/"prefix:<:8>">

# 0 - 7 is the same int
is(:8(0), 0, 'got the correct int value from oct 0');
is(:8(1), 1, 'got the correct int value from oct 1');
is(:8(2), 2, 'got the correct int value from oct 2');
is(:8(3), 3, 'got the correct int value from oct 3');
is(:8(4), 4, 'got the correct int value from oct 4');
is(:8(5), 5, 'got the correct int value from oct 5');
is(:8(6), 6, 'got the correct int value from oct 6');
is(:8(7), 7, 'got the correct int value from oct 7');

# check 2 digit numbers
is(:8(10),  8, 'got the correct int value from oct 10');
is(:8(20), 16, 'got the correct int value from oct 20');
is(:8(30), 24, 'got the correct int value from oct 30');
is(:8(40), 32, 'got the correct int value from oct 40');
is(:8(50), 40, 'got the correct int value from oct 50');

# check 3 digit numbers
is(:8(100), 64, 'got the correct int value from oct 100');

# check some weird versions
is(:8("77"),      63, 'got the correct int value from oct 77');
is(:8<177777>, 65535, 'got the correct int value from oct 177777');

# L<S02/Literals/"Think of these as setting the default radix">
# setting the default radix

#?pugs: todo('feature', 4);
{
    is(:8(0b1110),  0d14, ':8(0b1110) converts from binary');
    is(:8(0x20),    0d32, ':8(0x20) converts from hexadecimal');
    is(:8(0o377),  0d255, ':8(0o255) stays octal');
    is(:8(0d37),    0d37, ':8(0d37) converts from decimal');
}
