use v6;
use Test;

plan 4;

regex t1 {
    '(' ~ ')' 'ab'
}

ok 'c(ab)d' ~~ m/<t1>/, 'Can work with ~ and constant atoms (match)';
ok 'ab)d'  !~~ m/<t1>/, '~ and constant atoms (missing opening bracket)';
ok '(a)d'  !~~ m/<t1>/, '~ and constant atoms (wrong content)';
# this shouldn't throw an exception. See here:
# http://irclog.perlgeek.de/perl6/2009-01-08#i_816425
#?rakudo skip 'should not throw exceptions'
ok 'x(ab'  !~~ m/<t1>/,  '~ and constant atoms (missing closing bracket)';
