use v6;

use Test;

plan *;

# basic lvalue assignment
# L<S09/Hashes>

my %hash1;
ok(%hash1.does(Hash), '%hash1 does Hash');
%hash1{"one"} = 5;
is(%hash1{"one"}, 5, 'lvalue hash assignment works (w/ double quoted keys)');

%hash1{'one'} = 4;
is(%hash1{'one'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)');

%hash1<three> = 3;
is(%hash1<three>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)');

# basic hash creation w/ comma separated key/values

my %hash2 = ("one", 1);
ok(%hash2.does(Hash), '%hash2 does Hash');
is(%hash2{"one"}, 1, 'comma separated key/value hash creation works');
is(%hash2<one>, 1, 'unquoted <key> fetching works');

my %hash3 = ("one", 1, "two", 2);
ok(%hash3.does(Hash), '%hash3 does Hash');
is(%hash3{"one"}, 1, 'comma separated key/value hash creation works with more than one pair');
is(%hash3{"two"}, 2, 'comma separated key/value hash creation works with more than one pair');

# basic hash creation w/ => separated key/values (pairs?)

my %hash4;
ok(%hash4.does(Hash), '%hash4 does Hash');
%hash4 = ("key" => "value");
is(%hash4{"key"}, 'value', '(key => value) separated key/value has creation works');

#hash in list context
is( (map { .WHAT } , {"a"=> 1 , "b"=>2}).join(' ') , 'Pair() Pair()' , 'Hashes become pairs in list context');

# hash slicing

my %hash5 = ("one", 1, "two", 2, "three", 3);
ok(%hash5.does(Hash), '%hash5 does Hash');

{
    my @slice1 = %hash5{"one", "three"};
    is(+@slice1, 2, 'got the right amount of values from the %hash{} slice');
    is(@slice1[0], 1, '%hash{} slice successful');
    is(@slice1[1], 3, '%hash{} slice successful');

    my @slice2 = %hash5<three one>;
    is(+@slice2, 2, 'got the right amount of values from the %hash<> slice');
    is(@slice2[0], 3, '%hash<> slice was successful');
    is(@slice2[1], 1, '%hash<> slice was successful');
}

#?rakudo skip '%hash<> does not work'
{
    my @slice3 = %hash5<>.sort;
    is(+@slice3, 3, 'empty slice got all hash values');
    is(@slice3[0], 1, 'empty slice got all hash values');
    is(@slice3[1], 2, 'empty slice got all hash values');
    is(@slice3[2], 3, 'empty slice got all hash values');
}

# slice assignment
{
    %hash5{"one", "three"} = (5, 10);
    is(%hash5<one>, 5, 'value was changed successfully with slice assignment');
    is(%hash5<three>, 10, 'value was changed successfully with slice assignment');

    %hash5<one three> = (3, 1);
    is(%hash5<one>, 3, 'value was changed successfully with slice assignment');
    is(%hash5<three>, 1, 'value was changed successfully with slice assignment');

    %hash5<foo> = [3, 1];
    is(%hash5<foo>[0], 3, 'value assigned successfully with arrayref in list context');
    is(%hash5<foo>[1], 1, 'value assigned successfully with arrayref in list context');
}

# keys

my %hash6 = ("one", 1, "two", 2, "three", 3);
ok(%hash6.does(Hash), '%hash6 does Hash');

my @keys1 = (keys %hash6).sort;
is(+@keys1, 3, 'got the right number of keys');
is(@keys1[0], 'one', 'got the right key');
is(@keys1[1], 'three', 'got the right key');
is(@keys1[2], 'two', 'got the right key');

my @keys2 = %hash6.keys.sort;
is(+@keys2, 3, 'got the right number of keys');
is(@keys2[0], 'one', 'got the right key');
is(@keys2[1], 'three', 'got the right key');
is(@keys2[2], 'two', 'got the right key');

# values

my %hash7 = ("one", 1, "two", 2, "three", 3);
ok(%hash7.does(Hash), '%hash7 does Hash');

my @values1 = (values %hash7).sort;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 2, 'got the right values');
is(@values1[2], 3, 'got the right values');

@values1 = %hash7.values.sort;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 2, 'got the right values');
is(@values1[2], 3, 'got the right values');

# misc stuff ...

my %hash8;
ok(%hash8.does(Hash), '%hash8 does Hash');
%hash8 = (:one, :key<value>, :three(3));
is(%hash8{'one'}, 1, 'colonpair :one');
is(%hash8{'key'}, 'value', 'colonpair :key<value>');
is(%hash8{'three'}, 3, 'colonpair :three(3)');

# kv method

my $key;
my $val;

my %hash9;
ok(%hash9.does(Hash), '%hash9 does Hash');
%hash9{1} = 2;

for (%hash9.kv) -> $k,$v {
    $key = $k;
    $val = $v;
}

is($key, 1, '%hash.kv gave us our key');
is($val, 2, '%hash.kv gave us our val');

%hash9{2} = 3;
ok(~%hash9 ~~ m{^(1\t2\s+2\t3|2\t3\s+1\t2)\s*$}, "hash can stringify");

my %hash10 = <1 2>;
is(%hash10<1>, 2, "assignment of pointy qw to hash");

# after t/pugsbugs/unhashify.t

sub test1 {
    my %sane = hash ('a'=>'b');
    is(~%sane.WHAT,Hash,'%sane is a Hash');
}

sub test2 (%hash) {
    is(~%hash.WHAT,Hash,'%hash is a Hash');
}

my %h = hash (a => 'b');

#sanity: Hash created in a sub is a Hash
test1;

test2 %h;

# See thread "Hash creation with duplicate keys" on p6l started by Ingo
# Blechschmidt: L<"http://www.nntp.perl.org/group/perl.perl6.language/22401">
#
# 20060604: Now that defaulting works the other way around, hashes resume
# the bias-to-the-right behaviour, consistent with Perl 5.
#
#?DOES 4

my %dupl = (a => 1, b => 2, a => 3);
is %dupl<a>, 3, "hash creation with duplicate keys works correctly";

# Moved from t/xx-uncategorized/hashes-segfault.t
# Caused some versions of pugs to segfault
#?rakudo skip 'hash contextualizer on lazy list'
{
    my %hash = %('a'..'d' Z 1..4);
    my $i = %hash.elems; # segfaults
    is $i, 4, "%hash.elems works";

    $i = 0;
    $i++ for %hash; # segfaults
    is $i, 4, "for %hash works";
}

eval ' @%(a => <b>)<a> ';
ok( $!, "doesn't really make sense, but shouldn't segfault, either ($!)");

# test for RT #62730
#?rakudo todo 'RT #62730'
lives_ok { Hash.new("a" => "b") }, 'Hash.new($pair) lives';

# RT #71022
#?rakudo skip 'RT 71022: infinite loop (noauto)'
{
    my %rt71022;
    %rt71022<bughunt> = %rt71022<bughunt>;
    ok( ! defined( %rt71022<bughunt> ),
        'non-existent hash element assigned to itself is not defined, not segfault' );
}

# This test breaks all hash access after it in Rakudo, so keep it last.
# RT #71064
{
    class RT71064 {
        method postcircumfix:<{ }>($x) { 'bughunt' }
        method rt71064() {
            my %h = ( foo => 'victory' );
            return %h<foo>;
        }
    }

    is( RT71064.new.rt71064(), 'victory',
        'postcircumfix:<{ }> method does not break ordinary hash access' );
}

{
    my %h;
    my $x = %h<foo>;
    is %h.keys.elems, 0, 'merely reading a non-existing hash keys does not create it';

}

done_testing;

# vim: ft=perl6
