use v6;

use Test;

plan 4;

is "a\nb\n\nc".lines.join('|'),   'a|b||c', '.lines without trailing \n';
is "a\nb\n\nc\n".lines.join('|'), 'a|b||c', '.lines with trailing \n';
is "a\nb\n\nc\n".lines(2).join('|'), 'a|b', '.lines with limit';
is lines("a\nb\nc\n").join('|'), 'a|b|c',   '&lines';

# vim: ft=perl6
