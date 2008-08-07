use v6;

use Test;

plan 58;

# basic lvalue assignment

my %hash1; 
isa_ok(%hash1, 'Hash');
%hash1{"one"} = 5; 
is(%hash1{"one"}, 5, 'lvalue hash assignment works (w/ double quoted keys)');

%hash1{'one'} = 4; 
is(%hash1{'one'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)');

my %hash1; 
%hash1<three> = 3; 
is(%hash1<three>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)');

# basic hash creation w/ comma seperated key/values

my %hash2 = ("one", 1);
isa_ok(%hash2, 'Hash');
is(%hash2{"one"}, 1, 'comma seperated key/value hash creation works');
is(%hash2<one>, 1, 'unquoted <key> fetching works');

my %hash3 = ("one", 1, "two", 2);
isa_ok(%hash3, 'Hash');
is(%hash3{"one"}, 1, 'comma seperated key/value hash creation works with more than one pair');
is(%hash3{"two"}, 2, 'comma seperated key/value hash creation works with more than one pair');

# basic hash creation w/ => seperated key/values (pairs?)

my %hash4;
isa_ok(%hash4, 'Hash');
%hash4 = ("key" => "value");
is(%hash4{"key"}, 'value', '(key => value) seperated key/value has creation works');

# hash slicing

my %hash5 = ("one", 1, "two", 2, "three", 3);
isa_ok(%hash5, 'Hash');

#?rakudo 10 skip "slicing not yet implemented"
my @slice1 = %hash5{"one", "three"};
is(+@slice1, 2, 'got the right amount of values from the %hash{} slice');
is(@slice1[0], 1, '%hash{} slice successfull');
is(@slice1[1], 3, '%hash{} slice successfull');

my @slice2 = %hash5<three one>;
is(+@slice2, 2, 'got the right amount of values from the %hash<> slice');
is(@slice2[0], 3, '%hash<> slice was successful');
is(@slice2[1], 1, '%hash<> slice was successful');

# slice assignment

%hash5{"one", "three"} = (5, 10);
is(%hash5<one>, 5, 'value was changed successfully with slice assignment');
is(%hash5<three>, 10, 'value was changed successfully with slice assignment');

%hash5<one three> = (3, 1);
is(%hash5<one>, 3, 'value was changed successfully with slice assignment');
is(%hash5<three>, 1, 'value was changed successfully with slice assignment');

%hash5<foo> = [3, 1];
is(%hash5<foo>[0], 3, 'value assigned successfully with arrayref in list context');
is(%hash5<foo>[1], 1, 'value assigned successfully with arrayref in list context');

# keys 

my %hash6 = ("one", 1, "two", 2, "three", 3);
isa_ok(%hash6, 'Hash');

#?rakudo 4 skip "sort keys %hash broken (method form works)"
my @keys1 = sort keys %hash6;
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
isa_ok(%hash7, 'Hash');

#?rakudo 4 skip "sort values %hash broken (method form works)"
my @values1 = sort values %hash7;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 2, 'got the right values');
is(@values1[2], 3, 'got the right values');

my @values1 = %hash7.values.sort;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 2, 'got the right values');
is(@values1[2], 3, 'got the right values');

# misc stuff ...

my %hash8;
isa_ok(%hash8, 'Hash');
%hash8 = (:one, :key<value>, :three(3));
is(%hash8{'one'}, 1, 'colonpair :one');
is(%hash8{'key'}, 'value', 'colonpair :key<value>');
is(%hash8{'three'}, 3, 'colonpair :three(3)');

# kv method

my $key;
my $val;

my %hash9; 
isa_ok(%hash9, 'Hash');
%hash9{1} = 2;

for (%hash9.kv) -> $k,$v { 
    $key = $k; 
    $val = $v; 
}

is($key, 1, '%hash.kv gave us our key');
is($val, 2, '%hash.kv gave us our val');

%hash9{2} = 3;
#?rakudo 1 skip "rx:Perl5// not implemented"
like(~%hash9, rx:Perl5/1\s+2\s+2\s+3/, "hash can stringify");

my %hash10 = <1 2>;
is(%hash10<1>, 2, "assignment of pointy qw to hash");

# after t/pugsbugs/unhashify.t

sub test1{
    my %sane = hash ('a'=>'b');
    is(%sane.WHAT,'Hash','%sane is a Hash');
}

sub test2 (Hash %hash) returns Void {
    is(%hash.WHAT,'Hash','%hash is a Hash');
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
#?rakudo skip "hash contextualizer unimplemented"
{
my %dupl = (a => 1, b => 2, a => 3);
is %dupl<a>, 3, "hash creation with duplicate keys works correctly";

# Moved from t/xx-uncategorized/hashes-segfault.t
# Caused some versions of pugs to segfault
my %hash = %(zip('a'..'d';1..4));
my $i = %hash.elems; # segfaults
is $i, 4, "%hash.elems works";

$i = 0;
$i++ for %hash; # segfaults
is $i, 4, "for %hash works";

eval ' @%(a => <b>)<a> ';
ok( $!, "doesn't really make sense, but shouldn't segfault, either ($!)");
}
