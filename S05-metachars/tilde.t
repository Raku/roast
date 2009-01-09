use v6;
use Test;

plan 22;

# L<S05/New metacharacters/"The ~ operator is a helper for matching
# nested subrules with a specific terminator">

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

#?rakudo skip 'parse errors'
{
    regex recursive {
        '(' ~ ')' [ 'a'* <recursive>* ]
    };

    ok '()'     ~~ m/^ <recursive> $/, 'recursive "()"';
    ok '(a)'    ~~ m/^ <recursive> $/, 'recursive "(a)"';
    ok '(aa)'   ~~ m/^ <recursive> $/, 'recursive "(aa)"';
    ok '(a(a))' ~~ m/^ <recursive> $/, 'recursive "(a(a))"';
    ok '(()())' ~~ m/^ <recursive> $/, 'recursive "(()())"';
    ok '('     !~~ m/^ <recursive> $/, '"(" is not matched';
    ok '(()'   !~~ m/^ <recursive> $/, '"(()" is not matched';
    ok '())'   !~~ m/^ <recursive> $/, '"())" is not matched';
    ok 'a()'   !~~ m/^ <recursive> $/, '"a()" is not matched';
}

{
    regex m1 { '(' ~ ')' <m2> };
    regex m2 { a* <m1>*       };

    ok '()'     ~~ m/^ <m1> $/, 'mutually recursive "()"';
    ok '(a)'    ~~ m/^ <m1> $/, 'mutually recursive "(a)"';
    ok '(aa)'   ~~ m/^ <m1> $/, 'mutually recursive "(aa)"';
    ok '(a(a))' ~~ m/^ <m1> $/, 'mutually recursive "(a(a))"';
    ok '(()())' ~~ m/^ <m1> $/, 'mutually recursive "(()())"';
    #?rakudo 3 skip 'exceptions from regexes'
    ok '('     !~~ m/^ <m1> $/, '"(" is not matched';
    ok '(()'   !~~ m/^ <m1> $/, '"(()" is not matched';
    ok '())'   !~~ m/^ <m1> $/, '"())" is not matched';
    ok 'a()'   !~~ m/^ <m1> $/, '"a()" is not matched';
}
