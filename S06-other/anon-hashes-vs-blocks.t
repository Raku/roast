use v6;

use Test;

# L<S06/Anonymous hashes vs blocks>

plan 26;

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


# //= and the hash() contextualizer can work together
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
    ok { $^a => $^b } ~~ Block, 'placeholders force it to be a block';
    ok { $^a => 'b' } ~~ Block, '... as a key';
    ok { a => $^x }   ~~ Block, '... as a value';
    ok { b => 3, a => $^x, 4 => 5 }   ~~ Block, '... somewhere deep inside';
#?rakudo.jvm skip 'jvm chokes on compiling {;} for some reason RT #124663'
    ok {;} ~~ Block, '{;} is a Block';
}

#?niecza skip "Thinks the block is a hash"
{
    my @foo = <a b>;
    my %hash = map { (state $counter)++ => $_ }, @foo;
    is %hash<0>, 'a', 'state variable declaration certainly makes it a block (1)';
    is %hash<1>, 'b', 'state variable declaration certainly makes it a block (2)';
}

# RT #68298
#?niecza skip "Thinks the block is a hash"
is (map { $_ => $_ * $_ }, 1..3).hash<2>, 4, 'block with $_ is not a hash';

# RT #76896
{
    my %fs = ();

    %fs{ lc( 'A' ) } = &fa;
    sub fa() {
        return 'FA';
    }

    %fs{ lc( 'B' ) } = &fb;
    sub fb() {
        return 'FB'
    }

    my $fname = lc( 'A' );
    is('FA', %fs{ $fname }(), "fa has been called");
    is('FA', %fs{ lc( 'A' ) }(), "fa has been called");
    $fname = lc( 'B' );
    is('FB', %fs{ $fname }(), "fb has been called");
    is('FB', %fs{ lc( 'B' ) }(), "fb has been called");
}

# RT #114966
{
    my %*dyn = x => 42;
    ok { %*dyn } ~~ Hash, '{ %*foo } is a Hash';
    is { %*dyn }<x>, 42,  '{ %*foo } constructs correct hash';
}

# RT #123641
ok { 1 R=> "a" } ~~ Hash,  '{ 1 R=> "a" } is a Hash';
is { 1 R=> "a" }<a>, 1,    '{ 1 R=> "a" } constructs correct hash';

done;

# vim: ft=perl6
