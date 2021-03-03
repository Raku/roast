use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 100;

# basic lvalue assignment
# L<S09/Hashes>

my %hash1;
does-ok %hash1, Hash, '%hash1 does Hash';
%hash1{"one"} = 5;
is(%hash1{"one"}, 5, 'lvalue hash assignment works (w/ double quoted keys)');

%hash1{'one'} = 4;
is(%hash1{'one'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)');

%hash1<three> = 3;
is(%hash1<three>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)');

# basic hash creation w/ comma separated key/values

my %hash2 = ("one", 1);
does-ok %hash2, Hash, '%hash2 does Hash';
is(%hash2{"one"}, 1, 'comma separated key/value hash creation works');
is(%hash2<one>, 1, 'unquoted <key> fetching works');

my %hash3 = ("one", 1, "two", 2);
does-ok %hash3, Hash, '%hash3 does Hash';
is(%hash3{"one"}, 1, 'comma separated key/value hash creation works with more than one pair');
is(%hash3{"two"}, 2, 'comma separated key/value hash creation works with more than one pair');

# basic hash creation w/ => separated key/values (pairs?)

my %hash4;
does-ok %hash4, Hash, '%hash4 does Hash';
%hash4 = ("key" => "value");
is(%hash4{"key"}, 'value', '(key => value) separated key/value has creation works');

is( (map { .WHAT.gist } , ${"a"=> 1 , "b"=>2}).join(' ') , Hash.gist , 'Non flattening Hashes do not become Pairs when passed to map');
my $does_not_flatten= {"a"=> 1 , "b"=>2};
is( (map { .WHAT.gist } , $does_not_flatten).join(' ') , Hash.gist , 'Non flattening Hashes do not become Pairs when passed to map');
my %flattens= ("a"=> 1 , "b"=>2);
is( (map { .WHAT.gist } , %flattens).join(' ') , Pair.gist ~ ' ' ~ Pair.gist, 'Flattening Hashes become Pairs when passed to map');

# hash slicing

my %hash5 = ("one", 1, "two", 2, "three", 3);
does-ok %hash5, Hash, '%hash5 does Hash';

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

{
    my @slice3 = %hash5<>.sort(*.value);
    is(+@slice3, 3, 'empty slice got all hash pairs');
    is(@slice3[0], "one" => 1, 'empty slice got all hash pairs');
    is(@slice3[1], "two" => 2, 'empty slice got all hash pairs');
    is(@slice3[2], "three" =>  3, 'empty slice got all hash pairs');
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
    is(%hash5<foo>[0], 3, 'value assigned successfully with arrayitem in list context');
    is(%hash5<foo>[1], 1, 'value assigned successfully with arrayitem in list context');
}

# keys

my %hash6 = ("one", 1, "two", 2, "three", 3);
does-ok %hash6, Hash, '%hash6 does Hash';

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
does-ok %hash7, Hash, '%hash7 does Hash';

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
does-ok %hash8, Hash, '%hash8 does Hash';
%hash8 = (:one, :key<value>, :three(3));
ok(%hash8{'one'} === True, 'colonpair :one');
is(%hash8{'key'}, 'value', 'colonpair :key<value>');
is(%hash8{'three'}, 3, 'colonpair :three(3)');

# kv method

my $key;
my $val;

my %hash9;
does-ok %hash9, Hash, '%hash9 does Hash';
%hash9{1} = 2;

for (%hash9.kv) -> $k,$v {
    $key = $k;
    $val = $v;
}

is($key, 1, '%hash.kv gave us our key');
is($val, 2, '%hash.kv gave us our val');

%hash9{2} = 3;
ok(~%hash9 ~~ /^(1\t2\s+2\t3|2\t3\s+1\t2)\s*$/, "hash can stringify");

my %hash10 = <1 2>;
is(%hash10<1>, 2, "assignment of pointy qw to hash");

sub test1() is test-assertion {
    my %sane = hash ('a'=>'b');
    is(%sane.WHAT.gist,Hash.gist,'%sane is a Hash');
}

sub test2(%hash) is test-assertion {
    is(%hash.WHAT.gist,Hash.gist,'%hash is a Hash');
}

my %h = hash (a => 'b');

#sanity: Hash created in a sub is a Hash
test1;

test2 %h;

# See thread "Hash creation with duplicate keys" on p6l started by Ingo
# Blechschmidt: L<"http://www.nntp.perl.org/group/perl.perl6.language/22401">
#
# 20060604: Now that defaulting works the other way around, hashes resume
# the bias-to-the-right behaviour, consistent with Perl.
#

my %dupl = (a => 1, b => 2, a => 3);
is %dupl<a>, 3, "hash creation with duplicate keys works correctly";

{
    my %hash = %(flat 'a'..'d' Z 1..4);
    my $i = %hash.elems;
    is $i, 4, "%hash.elems works";

    $i = 0;
    $i++ for %hash; # segfaults
    is $i, 4, "for %hash works";
}

{
    throws-like { EVAL ' @%(a => <b>)<a>' },
      Exception,
      "doesn't really make sense, but shouldn't segfault, either ($!)";
}

# https://github.com/Raku/old-issue-tracker/issues/650
lives-ok { Hash.new("a" => "b") }, 'Hash.new($pair) lives';

# https://github.com/Raku/old-issue-tracker/issues/1421
{
    my %rt71022;
    %rt71022<bughunt> = %rt71022<bughunt>;
    ok( ! defined( %rt71022<bughunt> ),
        'non-existent hash element assigned to itself is not defined, not segfault' );
}

# https://github.com/Raku/old-issue-tracker/issues/1426
{
    class RT71064 {
        method postcircumfix:<{ }>($x) { 'bughunt' }    #OK not used
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
    is %h.elems, 0, 'merely reading a non-existing hash keys does not create it';
    my $y = %h<foo><bar>;
    is %h.elems, 0, 'reading multi-level non-existing hash keys does not create it';
    %h<foo><bar> = "baz";
    is %h.elems, 1, 'multi-level auto-vivify number of elements';
    is-deeply %h<foo>, (bar => "baz").hash, "multi-level auto-vivify";
} #4

# https://github.com/Raku/old-issue-tracker/issues/1960
{
    my %h = statement => 3;
    is %h.keys.[0], 'statement',
        '"statement" autoquoted hash key does not collide with "state"';
}

# https://github.com/Raku/old-issue-tracker/issues/282
# By collective knowledge of #perl6 and @larry, .{ } is actually defined in
# Any
{
    my $x;
    lives-ok { $x{'a'} }, 'can index a variable that defaults to Any';
    nok $x{'a'}.defined, '... and the result is not defined';
    throws-like-any { Mu.{'a'} },
      [X::Multi::NoMatch, X::TypeCheck::Binding::Parameter],
      'no .{ } in Mu';
}

# Whatever/Zen slices work on hashes too
{
    my %h = a => 1, b => 2, c => 3;
    is %h{*}.join('|'), %h.values.join('|'), '{*} whatever slice';
    is %h{}.join('|'),  %h.join('|'),        '{} zen slice';

    my $h := { a => 1, b => 2, c => 3 }; say $h{}[0].WHAT.gist;
    my @result;
    @result.push($_) for $h{};
    is @result.elems, 3,        '{} zen slice decontainerizes';
} #2

# https://github.com/Raku/old-issue-tracker/issues/1855
{
    my %h = (ab => 'x', 'a' => 'y');
    'abc' ~~ /^(.)./;
    is %h{$/}, 'x', 'can use $/ as hash key';
    is %h{$0}, 'y', 'can use $0 as hash key';

}

# https://github.com/Raku/old-issue-tracker/issues/492
{
    my %hash;
    %hash<foo> := 'bar';
    is %hash<foo>, 'bar', 'binding hash value works';
}

# https://github.com/Raku/old-issue-tracker/issues/3190
{
    my %hash;
    %hash<bar><baz> := 'zoom';
    is %hash<bar><baz>, 'zoom', 'binding on auto-vivified hash value works';
    my $b := %hash<foo><baz>;
    $b = 42;   # vivifies
    is %hash<foo><baz>, 42, 'did the assignment vivify';
}

# https://github.com/Raku/old-issue-tracker/issues/1829
eval-lives-ok('my $rt75694 = { has-b => 42 }', "can have a bareword key starting with 'has-' in a hash");

# https://github.com/Raku/old-issue-tracker/issues/2479
{
    eval-lives-ok 'my $rt = { grammar => 5 }',
                  "can have a bareword 'grammar' as a hash key";
}

# https://github.com/Raku/old-issue-tracker/issues/2179
{
    my $h = Hash.new(a => 3);
    $h<a> = 5;
    is $h<a>, 5, 'can normally modify items created from Hash.new';
}

# https://github.com/Raku/old-issue-tracker/issues/2112
{
    isa-ok {}[*-1], Failure, 'array-indexing a hash with a negative index is Failure';
}

# https://github.com/Raku/old-issue-tracker/issues/1564
{
    my Hash $RT73230;
    $RT73230[1];
    is($RT73230.raku, 'Hash', 'test for positional (.[]) indexing on a Hash');
}

# https://github.com/Raku/old-issue-tracker/issues/3096
{
    my %hash = a => 1;
    is item(%hash).raku, (${ a => 1 }).raku, 'item(%hash) is equivalent to ${%hash}';
}

# https://github.com/Raku/old-issue-tracker/issues/2106
{
    throws-like { ~[]<c> }, Exception,
        message => 'Type Array does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .<> (1)';

    throws-like { ~5<c> }, Exception,
        message => 'Type Int does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .<> (2)';

    throws-like { ~5{'c'} }, Exception,
        message => 'Type Int does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .{}';
}

# https://github.com/Raku/old-issue-tracker/issues/3571
{
    my %hash = not => 42;
    is %hash<not>, 42, "can use bare 'not' as hash key";
}

# https://github.com/rakudo/rakudo/issues/1344
{
    my %h = :42foo;
    cmp-ok %h.list,  'eqv', (:42foo,), 'Hash.list  returns a List';
    cmp-ok %h.cache, 'eqv', (:42foo,), 'Hash.cache returns a List';

    my %m := Map.new: (:42foo);
    cmp-ok %m.list,  'eqv', (:42foo,), 'Map.list   returns a List';
    cmp-ok %m.cache, 'eqv', (:42foo,), 'Map.cache  returns a List';
}

{
    is Hash.of.^name, 'Mu', 'does Hash type object return proper type';
    is Hash.new.of.^name, 'Mu', 'does Hash object return proper type';
}

# vim: expandtab shiftwidth=4
