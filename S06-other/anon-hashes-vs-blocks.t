use v6;

use Test;

=begin pod

The parser has difficulties with nested hash refs.
my $hash = {
   '1' =>  { '2' => 3,  '4' => 5}
   };
 
say "Perl: ", $hash.perl;
say "Ref: ", $hash.WHAT;
say '$hash<1>.WHAT = ', $hash<1>.perl;
say '$hash<1><2>.WHAT = ', $hash<1><2>.WHAT;
say '$hash<1><4>.WHAT = ', $hash<1><4>.WHAT;
say '$hash<1><4>.WHAT = ', $hash<1><4>.perl;

Also with array refs nested in hash refs.

=end pod

# L<S06/Anonymous hashes vs blocks>

plan 8;

my $hash = {
   '1' => { '2' => 3, '4' => 5 },
};


is( $hash<1><2>, '3', 'First nested element.');
is( $hash<1><4>, '5', 'Second nested element.');

my $h2 = {
   x => [2,3]
};
is( $h2<x>[0], '2', 'First nested element.');
is( $h2<x>[1], '3', 'Second nested element.');

my %foo = (1 => 2);
my $bar = { %foo };

ok $bar ~~ Hash, '%foo in a block causes hash composing';


# pugs had problems with //= and the hash() contextualizer
{
    my %hash;
    %hash<foo> //= hash();
    %hash<bar> //= hash;
    my $h_ref;
    $h_ref  //= hash();
    is(%hash<foo>.WHAT, ::Hash, "Parses as two items");
    is(%hash<bar>.WHAT, ::Hash, "Parens do not help");
    is($h_ref.WHAT,     ::Hash, "It is not limited to hash values");
}

# vim: ft=perl6
