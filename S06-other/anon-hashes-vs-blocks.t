use v6;

use Test;

# L<S06/Anonymous hashes vs blocks>

plan 15;

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
    is(%hash<foo>.WHAT.gist, ::Hash.gist, "Parses as two items");
    is(%hash<bar>.WHAT.gist, ::Hash.gist, "Parens do not help");
    is($h_ref.WHAT.gist,     ::Hash.gist, "It is not limited to hash values");
}

{
    ok {; a => 1 } ~~ Block, '{; ... } is a Block';
    ok {  a => 1 } ~~ Hash,  '{ a => 1} is a Hash';
    #?pugs 4 skip "Missing required parameters"
    ok { $^a => $^b } ~~ Block, 'placeholders force it to be a block';
    ok { $^a => 'b' } ~~ Block, '... as a key';
    ok { a => $^x }   ~~ Block, '... as a value';
    ok { b => 3, a => $^x, 4 => 5 }   ~~ Block, '... somewhere deep inside';
    ok {;} ~~ Block, '{;} is a Block';
}

done;

# vim: ft=perl6
