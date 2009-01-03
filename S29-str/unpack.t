use v6;
use Test;

# L<S29/Str/"=item unpack">

plan 3;

# Simple use

is(unpack("A2", "Hello World"), "He", "A2, at beginning");
is_deeply(unpack("A2 A3", "Hello World"), ("He", "llo"), "A2 A3");
is_deeply(unpack("A2 x4 A3", "Hello World"), ("He", "Wor"), "A2 A3");
