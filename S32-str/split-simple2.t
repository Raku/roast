use v6;
use Test;

# L<S32::Str/Str/"=item split">
plan 41;

=begin description

The tests in split.t are rather inaccessible for new implementations, so
here is a start from scratch that should be easier to run.

=end description

#?DOES 2
sub split_test(@splitted, @expected, $desc) {
    say "jj";
    ok @splitted.elems ==  @expected.elems,
       "split created the correct number of elements for: $desc";
    say "jk";
    is @splitted.join('|-|'), @expected.join('|-|'),
       "values matched for: $desc";
    say "hj";
}

is 'abcdefg'.split('').elems, 7, 'split into characters';
is 'abcdefg'.split('').Str, "a b c d e f g", 'split into characters';

is 'a1b24f'.split(/\d+/).elems, 3, 'Str.split(/regex/)';
is 'a1b24f'.split(/\d+/).Str, "a b f", 'Str.split(/regex/)';

# split_test split(/\d+/, 'a1b24f'), <a b f>, 'split(/regex/, Str)';
# split_test 'a1b'.split(1),         <a b>,   'Str.split(Any) (with Str semantics';
is 'theXXbigXXbang'.split('XX').elems, 3, 'Str.split(Str)';
is 'theXXbigXXbang'.split('XX').Str, 'the big bang', 'Str.split(Str)';
is 'XXtheXXbigXXbang'.split('XX').elems, 4, 'Str.split(Str)';
is 'XXtheXXbigXXbang'.split('XX').Str, ' the big bang', 'Str.split(Str)';

is 'a1b24f'.split(/\d+/, *).elems, 3, 'Str.split(/regex/) (with * limit)';
is 'a1b24f'.split(/\d+/, *).Str, "a b f", 'Str.split(/regex/) (with * limit)';
# split_test split(/\d+/, 'a1b24f', *), <a b f>, 'split(/regex/, Str) (with * limit)';
# split_test 'a1b'.split(1, *),         <a b>,   'Str.split(Any) (with Str semantics (with * limit)';
is 'theXXbigXXbang'.split('XX', *).elems, 3, 'Str.split(Str) (with * limit)';
is 'theXXbigXXbang'.split('XX', *).Str, 'the big bang', 'Str.split(Str) (with * limit)';

# {
#     split_test 123.split(2),           <1 3>,   'Int.split(Int)';
#     split_test split(2, 123),          <1 3>,   'split(Int, Int)';
# }

is '1234'.split(/X/).elems, 1,  'Non-matching regex returns whole string';
is '1234'.split(/X/).Str, "1234",  'Non-matching regex returns whole string';
is '1234'.split('X').elems, 1,  'Non-matching string returns whole string';
is '1234'.split('X').Str, "1234",  'Non-matching string returns whole string';
is 'abcb'.split(/b/).elems, 3, 'trailing matches leave an empty string';
is 'abcb'.split(/b/).Str, "a c ", 'trailing matches leave an empty string';

# Limit tests
is 'theXbigXbang'.split(/X/, -1).elems, 0, 'Negative limit returns empty List';
is 'theXbigXbang'.split(/X/, 0).elems, 0, 'Zero limit returns empty List';
is 'theXbigXbang'.split('X', -1).elems, 0, 'Negative limit returns empty List';
is 'theXbigXbang'.split('X', 0).elems, 0, 'Zero limit returns empty List';

is 'ab1cd12ef'.split(/\d+/, 1).elems, 1, 'Limit of 1 returns a 1 element List (with identical string)';
is 'ab1cd12ef'.split(/\d+/, 1)[0], 'ab1cd12ef', 'Limit of 1 returns a 1 element List (with identical string)';
is 'ab1cd12ef'.split('\d+', 1).elems, 1, 'Limit of 1 returns a 1 element List (with identical string)';
is 'ab1cd12ef'.split('\d+', 1)[0], 'ab1cd12ef', 'Limit of 1 returns a 1 element List (with identical string)';

# split_test '102030405'.split(0, 3),  <1 2 30405>, 'Split on an Integer with limit parameter works';

is '<tag>soup</tag>'.split(/\<\/?.*?\>/, 3).elems, 3,
   'Limit of 3 returns 3 element List including empty Strings';
is '<tag>soup</tag>'.split(/\<\/?.*?\>/, 3).Str, " soup ",
    'Limit of 3 returns 3 element List including empty Strings';

is 'ab1cd12ef'.split(/\d+/, 10).elems, 3, 
   'Limit larger than number of split values doesn\'t return extranuous elements';
is 'ab1cd12ef'.split(/\d+/, 10).Str, "ab cd ef", 
   'Limit larger than number of split values doesn\'t return extranuous elements';

is 'aZbZcZdZeZfZg'.split(/Z/, 3).elems, 3, 'split respects limit (1)';
is 'aZbZcZdZeZfZg'.split(/Z/, 3).Str, "a b cZdZeZfZg", 'split respects limit (1)';
is 'a,b,c,d,e,f,g'.split(',', 3).elems, 3, 'split respects limit (2)';
is 'a,b,c,d,e,f,g'.split(',', 3).Str, "a b c,d,e,f,g", 'split respects limit (2)';

is 'abcdefg'.split('', 3).elems, 3, 'split into characters respects limit (1)';
is 'abcdefg'.split('', 3).Str, "a b cdefg", 'split into characters respects limit (1)';

# catch possible off-by-one errors
is 'abc'.split('', 3).elems, 3, 'split into characters respects limit (2)';
is 'abc'.split('', 3).Str, "a b c", 'split into characters respects limit (2)';

# zero-width assertions shouldn't loop
# with additional spaces
# a b 3 4 d 5 z    split on <before \d>
#    ^ ^   ^
#  => result: 'ab', '3', '4d', '5z'
#  (confirmed by perl 5)

# split_test 'ab34d5z'.split(/<.before \d>/), <ab 3 4d 5z>, 'split with zero-width assertions';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

# ok (''.split('')).elems == 0, q{''.split('') returns empty list};
# ok (split('', '')).elems == 0, q{''.split('') returns empty list};

# split with :all should return capture
{
    my @split = 'abc def ghi'.split(/(\s+)/, :all);
    ok @split.elems == 5, q{split returns captured delimiter} ;
    ok @split[1] eq ' ', q{split captured single space};
    ok @split[3] eq ' ', q{split captured multiple spaces};
}

# {
#     my @split = split(/\d+/, 'a4b5', :all);
#     is @split.elems, 5, 'split() with :all and trailing delimiter (count)';
#     is @split.join('|'), 'a|4|b|5|',
#        'split(:all) and trailing delimiter (values)';
# }

done_testing;

# vim: ft=perl6
