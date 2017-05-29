use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 50;

##############################################################
####
#### XXX TODO .lines does not take an $eager param so these
#### tests needs to stop testing using it
####
##############################################################

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

    #?rakudo.jvm 5 todo '\r\n not yet handled as grapheme'
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
#?rakudo.jvm todo 'Type check failed in binding to parameter $bin; expected Bool but got Int (0)'
is_run( 'print lines[0]',
        "abcd\nefgh\nijkl\n",
        { out => "abcd", err => '', status => 0 },
        'lines returns things in lines' );

# RT #126270 [BUG] Something fishy with lines() and looping over two items at a time in Rakudo
{
    my $expected = "A, then B\nC, then D\n";
    my $result;

    # This used to fail, saying "Too few positionals passed; expected 2 arguments but got 0"
    for "A\nB\nC\nD".lines() -> $x, $y { $result ~= "$x, then $y\n" }

    is $result, $expected, 'lines iterates correctly with for block taking two arguments at a time';
}

# RT #130430
is-deeply "a\nb\nc".lines(2000), ('a', 'b', 'c'),
    'we stop when data ends, even if limit has not been reached yet';

# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.lines: |<bunch of incorrect args> },
    'no infinite loop when given wrong args to Cool.lines';

# vim: ft=perl6
