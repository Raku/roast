use v6;

use Test;
use lib 't/spec/packages';
use Test::Util;

plan 5;

is "a\nb\n\nc".lines.join('|'),   'a|b||c', '.lines without trailing \n';
is "a\nb\n\nc\n".lines.join('|'), 'a|b||c', '.lines with trailing \n';
is "a\nb\n\nc\n".lines(2).join('|'), 'a|b', '.lines with limit';
is lines("a\nb\nc\n").join('|'), 'a|b|c',   '&lines';

# RT #115136
is_run( 'print lines[0]',
        "abcd\nefgh\nijkl\n",
        { out => "abcd", err => '', status => 0 },
        'lines returns things in lines' );                  

# vim: ft=perl6
