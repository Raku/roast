use v6;

use Test;

=kwid

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped by Pugs.

=cut

plan 4;

my $ref = { val => 42 };
isa_ok($ref, 'Hash');
lives_ok( { $ref[0] }, 'Accessing a hash as a list of pairs is fine');

$ref = [ 42 ];
isa_ok($ref, 'Array');
dies_ok( { $ref<0> }, 'Accessing an array as a hash dies');
