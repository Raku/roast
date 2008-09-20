use v6;
use Test;

plan 16;

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
#?rakudo skip 'Int.split(Int)'
#?DOES 4
{
    split_test 123.split(2),           <1 3>,   'Int.split(Int) works';
    split_test split(2, 123),          <1 3>,   'split(Int, Int) works';
}

split_test '1234'.split(/X/),          <1234>,  'Non-matching regex returns whole string';
split_test '1234'.split('X'),          <1234>,  'Non-matching string returns whole string';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

ok (''.split('')).elems == 0, q{''.split('') returns empty list};
ok (split('', '')).elems == 0, q{''.split('') returns empty list};

# vim: ft=perl6
