use v6;
use Test;

# L<S32::Str/Str/"=item split">
plan 30;

=begin description

The tests in split.t are rather inaccessible for new implementations, so
here is a start from scratch that should be easier to run.

=end description

sub split_test(@splitted, @expected, Str $desc) {
    subtest {
        plan 2;
        ok @splitted.elems ==  @expected.elems,
           "split created the correct number of elements for: $desc";
        is @splitted.join('|-|'), @expected.join('|-|'),
           "values matched for: $desc"
    }, $desc;
}

split_test 'a1b24f'.split(/\d+/),  <a b f>, 'Str.split(/regex/)';
split_test split(/\d+/, 'a1b24f'), <a b f>, 'split(/regex/, Str)';
split_test 'a1b'.split(1),         <a b>,   'Str.split(Any) (with Str semantics';

split_test 'a1b24f'.split(/\d+/, *),  <a b f>, 'Str.split(/regex/) (with * limit)';
split_test split(/\d+/, 'a1b24f', *), <a b f>, 'split(/regex/, Str) (with * limit)';
split_test 'a1b'.split(1, *),         <a b>,   'Str.split(Any) (with Str semantics (with * limit)';

{
    split_test 123.split(2),           <1 3>,   'Int.split(Int)';
    split_test split(2, 123),          <1 3>,   'split(Int, Int)';
}

split_test '1234'.split(/X/),          @(<1234>),  'Non-matching regex returns whole string';
split_test '1234'.split('X'),          @(<1234>),  'Non-matching string returns whole string';
split_test 'abcb'.split(/b/),   ('a', 'c', ''), 'trailing matches leave an empty string';

# Limit tests
{
split_test 'theXbigXbang'.split(/X/, -1), (), 'Negative limit returns empty List';
split_test @('theXbigXbang'.split(/X/, 0)),  (), 'Zero limit returns empty List';
}
split_test 'ab1cd12ef'.split(/\d+/, 1), @(<ab1cd12ef>), 'Limit of 1 returns a 1 element List (with identical string)';
split_test '102030405'.split(0, 3),  <1 2 30405>, 'Split on an Integer with limit parameter works';
#?DOES 1
split_test(
    '<tag>soup</tag>'.split(/\<\/?.*?\>/, 3),
    ('','soup',''),
    'Limit of 3 returns 3 element List including empty Strings'
);
split_test(
    'ab1cd12ef'.split(/\d+/, 10),
    <ab cd ef>,
    'Limit larger than number of split values doesn\'t return extranuous elements'
);

{
split_test
    'abcdefg'.split('', 3),
    ('', 'a', 'bcdefg'),
    'split into characters respects limit (1)';

# catch possible off-by-one errors
split_test
    'abc'.split('', 3),
    ( '', 'a', 'bc'),
    'split into characters respects limit (2)';
}

# zero-width assertions shouldn't loop
# with additional spaces
# a b 3 4 d 5 z    split on <before \d>
#    ^ ^   ^
#  => result: 'ab', '3', '4d', '5z'
#  (confirmed by Perl)

split_test 'ab34d5z'.split(/<.before \d>/), <ab 3 4d 5z>, 'split with zero-width assertions';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

ok (''.split('')).elems == 0, q{''.split('') returns empty list};
ok (split('', '')).elems == 0, q{''.split('') returns empty list};

# split with :v should return capture
# also RT #126679
{
    my @split = 'abc def ghi'.split(/(\s+)/, :v);
    ok @split.elems == 5, q{split returns captured delimiter} ;
    ok @split[1] eq ' ', q{split captured single space};
    ok @split[3] eq ' ', q{split captured multiple spaces};
}

# also RT #126679
{
    my @split = split(/\d+/, 'a4b5', :v);
    is @split.elems, 5, 'split() with :v and trailing delimiter (count)';
    is @split.join('|'), 'a|4|b|5|',
       'split(:v) and trailing delimiter (values)';
}

# RT #112868
{
    my $rt112868 = 'splitting on empty';
    ok $rt112868.split('').elems > 0, q<.split('') does something>;
    is $rt112868.split(''), $rt112868.split(/''/),
       q<.split('') does the same thing as .split(/''/) (RT #112868)>;
}

# RT #128034
subtest 'split with NaN limit throws (RT #128034)', {
    plan 3;
    throws-like { split 'o',        'o', NaN }, X::TypeCheck;
    throws-like { split /o/,        'o', NaN }, X::TypeCheck;
    throws-like { split @(1, 2, 3), 'o', NaN }, X::TypeCheck;
}

# vim: ft=perl6
