use v6;

use Test;
use lib 't/spec/packages';
use Test::Util;

plan 47;

for False, True -> $eager {
    is "a\nb\n\nc".lines(:$eager).join('|'),
      'a|b||c', 'LF .lines without trailing';
    is "a\nb\n\nc\n".lines(:$eager).join('|'),
      'a|b||c', 'LF .lines with trailing';
    is "a\nb\n\nc\n".lines(Inf,:$eager).join('|'),
      'a|b||c', 'LF .lines with Inf';
    is "a\nb\n\nc\n".lines(*,:$eager).join('|'),
      'a|b||c', 'LF .lines with *';
    is "a\nb\n\nc\n".lines(2,:$eager).join('|'),
      'a|b',    'LF .lines with limit';

    is "a\rb\r\rc".lines(:$eager).join('|'),
      'a|b||c', 'CR .lines without trailing';
    is "a\rb\r\rc\r".lines(:$eager).join('|'),
      'a|b||c', 'CR .lines with trailing';
    is "a\rb\r\rc\r".lines(Inf,:$eager).join('|'),
      'a|b||c', 'CR .lines with Inf';
    is "a\rb\r\rc\r".lines(*,:$eager).join('|'),
      'a|b||c', 'CR .lines with *';
    is "a\rb\r\rc\r".lines(2,:$eager).join('|'),
      'a|b',    'CR .lines with limit';

    is "a\r\nb\r\n\r\nc".lines(:$eager).join('|'), 'a|b||c',
      'CRLF .lines without trailing';
    is "a\r\nb\r\n\r\nc\r\n".lines(:$eager).join('|'), 'a|b||c',
      'CRLF .lines with trailing';
    is "a\r\nb\r\n\r\nc\r\n".lines(Inf,:$eager).join('|'), 'a|b||c',
      'CRLF .lines with Inf';
    is "a\r\nb\r\n\r\nc\r\n".lines(*,:$eager).join('|'), 'a|b||c',
      'CRLF .lines with *';
    is "a\r\nb\r\n\r\nc\r\n".lines(2,:$eager).join('|'), 'a|b',
      'CRLF .lines with limit';

    is "a\nb\r\rc".lines(:$eager).join('|'),
      'a|b||c', 'mixed .lines without trailing';
    is "a\nb\r\rc\r".lines(:$eager).join('|'),
      'a|b||c', 'mixed .lines with trailing';
    is "a\nb\r\rc\r".lines(Inf,:$eager).join('|'),
      'a|b||c', 'mixed .lines with Inf';
    is "a\nb\r\rc\r".lines(*,:$eager).join('|'),
      'a|b||c', 'mixed .lines with *';
    is "a\nb\r\rc\r".lines(2,:$eager).join('|'),
      'a|b',    'mixed .lines with limit';

    is lines("a\nb\nc\n",:$eager).join('|'), 'a|b|c', '&lines';
    is lines("a\nb\nc\n",2,:$eager).join('|'), 'a|b', '&lines(2)';
}

is lines("a\nb\nc\n",:count), 3, 'lines(Str, :count)';
is "a\nb\nc\n".lines(:count), 3, 'Str.lines(:count)';


# RT #115136
is_run( 'print lines[0]',
        "abcd\nefgh\nijkl\n",
        { out => "abcd", err => '', status => 0 },
        'lines returns things in lines' );                  

# vim: ft=perl6
