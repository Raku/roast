use v6;

use Test;

plan 2;

is "a\nb\n\nc".lines.join('|'),   'a|b||c', '.lines without trailing \n';
is "a\nb\n\nc\n".lines.join('|'), 'a|b||c', '.lines with trailing \n';

# vim: ft=perl6
