use v6;

use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped by Pugs.

=end description

plan 4;

my $ref = { val => 42 };
isa_ok($ref, Hash);
#?rakudo skip "unspecced (if specced please add smartlink)"
lives_ok( { $ref[0] }, 'Accessing a hash as a list of pairs is fine');

$ref = [ 42 ];
isa_ok($ref, Array);
dies_ok( { $ref<0> }, 'Accessing an array as a hash dies');
