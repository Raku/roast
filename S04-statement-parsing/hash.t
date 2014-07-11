use v6;
use Test;

# L<S04/Statement parsing/the hash list operator>

plan 8;

isa_ok hash('a', 1), Hash, 'hash() returns a Hash';
is hash('a', 1).keys, 'a', 'hash() with keys/values (key)';
is hash('a', 1).values, 1, 'hash() with keys/values (values)';

is hash('a' => 1).keys, 'a', 'hash() with pair (key)';
is hash('a' => 1).values, 1, 'hash() with pair (values)';

is hash(a => 1).keys, 'a', 'hash() with autoquoted pair (key)';
is hash(a => 1).values, 1, 'hash() with autoquoted pair (values)';

#RT #78096
{
    lives_ok { my @r=2..10,<j q k a>;my %v=j=>10,q=>10,k=>10,a=>1|11;},
        "q => doesn't trigger quoting construct";
}

# vim: ft=perl6
