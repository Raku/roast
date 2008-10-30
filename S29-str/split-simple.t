use v6;
use Test;

plan 32;

=begin description

The tests in split.t are rather inaccessible for new implementations, so
here is a start from scratch that should be easier to run.

=end description

#?DOES 2
sub split_test(@splitted, @expected, Str $desc) {
    ok @splitted.elems ==  @expected.elems, 
       "split created the correct value amount for: $desc";
    is @splitted.join('|-|'), @expected.join('|-|'),
       "values matched for: $desc"
}

split_test 'a1b24f'.split(/\d+/),  <a b f>, 'Str.split(/regex/) works';
split_test split(/\d+/, 'a1b24f'), <a b f>, 'split(/regex/, Str) works';
split_test 'a1b'.split(1),         <a b>,   'Str.split(Any) works (with Str semantics';    
{
    split_test 123.split(2),           <1 3>,   'Int.split(Int) works';
    split_test split(2, 123),          <1 3>,   'split(Int, Int) works';
}

split_test '1234'.split(/X/),          <1234>,  'Non-matching regex returns whole string';
split_test '1234'.split('X'),          <1234>,  'Non-matching string returns whole string';
split_test 'abcb'.split(/b/),   ('a', 'c', ''), 'trailing matches leave an empty string';

# Limit tests
#?DOES 4
{
split_test 'theXbigXbang'.split(/X/, -1), <>, 'Negative limit returns empty List';
split_test 'theXbigXbang'.split(/X/, 0),  <>, 'Zero limit returns empty List';
}
split_test 'ab1cd12ef'.split(/\d+/, 1), <ab1cd12ef>, 'Limit of 1 returns a 1 element List (with identical string)';
split_test '102030405'.split(0, 3),  <1 2 30405>, 'Split on an Integer with limit parameter works';
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

# zero-width assertions shouldn't loop
# with additional spaces
# a b 3 4 d 5 z    split on <before \d>
#    ^ ^   ^   
#  => result: 'ab', '3', '4d', '5z'
#  (confirmed by perl 5)

split_test 'ab34d5z'.split(/<before \d>/), <ab 3 4d 5z>, 'split with zero-width assertions';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

ok (''.split('')).elems == 0, q{''.split('') returns empty list};
ok (split('', '')).elems == 0, q{''.split('') returns empty list};

# vim: ft=perl6
