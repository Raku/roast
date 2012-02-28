use v6;
use Test;

# L<S04/Statement parsing/the hash list operator>

plan 7;

isa_ok hash('a', 1), Hash, 'hash() returns a Hash';
is hash('a', 1).keys, 'a', 'hash() with keys/values (key)';
#?pugs todo
is hash('a', 1).values, 1, 'hash() with keys/values (values)';

is hash('a' => 1).keys, 'a', 'hash() with pair (key)';
#?pugs todo
is hash('a' => 1).values, 1, 'hash() with pair (values)';

#?pugs 2 skip 'Named argument found where no matched parameter expected'
is hash(a => 1).keys, 'a', 'hash() with autoquoted pair (key)';
is hash(a => 1).values, 1, 'hash() with autoquoted pair (values)';

# vim: ft=perl6
