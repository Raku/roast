# http://perl6advent.wordpress.com/2009/12/20/day-20-little-big-things/

use v6;
use Test;

plan 21;

sub foo (Int $i, @stuff, $blah = 5) { ... }   #OK not used
is &foo.name, 'foo', 'Introspecting subroutine name';

my $bar = &foo;
is $bar.name, 'foo', 'Introspecting subroutine for a sub assigned to a scalar';

is &foo.signature.perl, ':(Int $i, @stuff, $blah = { ... })', 'Introspecting and stringification of subroutine signature';

# Not sure if this is an appropriate test - as this code doesn't exist in the Advent Calendar
my @sig-info = \(name => '$i',     type => 'Int'),
               \(name => '@stuff', type => 'Positional'),
               \(name => '$blah',  type => 'Any');

for &foo.signature.params Z @sig-info -> $param, $param-info {
    is $param.name, $param-info<name>, 'Name matches ' ~ $param-info<name>;
    is $param.type.perl, $param-info<type>, 'Type matches ' ~ $param-info<type>;
}

is &foo.count, 3, 'Introspecting number of arguments';
is &foo.arity, 2, 'Introspecting arity, i.e. number of required arguments';

eval_lives_ok 'map -> $x, $y { ... }, 1..6', 'mapping two at a time';
eval_lives_ok 'map -> $x, $y, $z { ... }, 1..6', 'mapping three at a time';

class Person {
    has $.name;
    has $.karma;

    method Str { return "$.name ($.karma)" }  # for pretty stringy output
}

my @names = <Jonathan Larry Scott Patrick Carl Moritz Will Stephen>;

my @people = map { Person.new(name => $_, karma => (rand * 20).Int) }, @names;
is @people.elems, @names.elems, 'List of people objects is the same length of names';

my @a = @people.sort: { $^a.karma <=> $^b.karma };
my @b = @people.sort: { $^a.karma };
is @a, @b, 'Can use two placeholders, or just one and get an equivalent free Schwartzian Transform';

@b = @people.sort: { .karma };
is @a, @b, 'Can eliminate the auto-declared placeholder, and sorting is still equivalent';

is @b, (@people.sort: { +.karma }), 'Sort explicitly numerically';
# TODO - need another test to explicitly test correct numerical sorting
ok ([<=] @b>>.karma), 'proper numeric sorting';

# numerical sort isn't always the same as stringy sorting, so
# this test randomly fails.
# isnt @b, (@people.sort: { ~.karma }), "Sort numerically is different to stringily";

{
    is @b, (@people.sort: *.karma), 'Using a Whatever to sort numerically (be default)';
    is (@people.min: { +.karma }), (@people.min: +*.karma), 'Explicit numeric comparison is equivalent to numeric comparison with a Whatever';
    is (@people.max: { ~.name }), (@people.max: ~*.name), 'Explicit string comparison is equivalent to a string comparison with a Whatever';
}

done;
