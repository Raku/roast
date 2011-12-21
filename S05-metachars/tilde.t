use v6;
use Test;

plan 26;

# L<S05/New metacharacters/"The ~ operator is a helper for matching
# nested subrules with a specific terminator">

my regex t1 {
    '(' ~ ')' 'ab'
}

ok 'c(ab)d' ~~ m/<&t1>/, 'Can work with ~ and constant atoms (match)';
ok 'ab)d'  !~~ m/<&t1>/, '~ and constant atoms (missing opening bracket)';
ok '(a)d'  !~~ m/<&t1>/, '~ and constant atoms (wrong content)';
# this shouldn't throw an exception. See here:
# http://irclog.perlgeek.de/perl6/2009-01-08#i_816425
#?rakudo skip 'should not throw exceptions'
#?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
ok 'x(ab'  !~~ m/<&t1>/,  '~ and constant atoms (missing closing bracket)';

{
    my regex recursive {
        '(' ~ ')' [ 'a'* <&recursive>* ]
    };

    ok '()'     ~~ m/^ <&recursive> $/, 'recursive "()"';
    ok '(a)'    ~~ m/^ <&recursive> $/, 'recursive "(a)"';
    ok '(aa)'   ~~ m/^ <&recursive> $/, 'recursive "(aa)"';
    ok '(a(a))' ~~ m/^ <&recursive> $/, 'recursive "(a(a))"';
    ok '(()())' ~~ m/^ <&recursive> $/, 'recursive "(()())"';
    #?rakudo 4 skip 'should not throw exceptions'
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '('     !~~ m/^ <&recursive> $/, '"(" is not matched';
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '(()'   !~~ m/^ <&recursive> $/, '"(()" is not matched';
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '())'   !~~ m/^ <&recursive> $/, '"())" is not matched';
    ok 'a()'   !~~ m/^ <&recursive> $/, '"a()" is not matched';
}

{
    my regex m1 { '(' ~ ')' <&m2> };
    my regex m2 { a* <&m1>*       };

    ok '()'     ~~ m/^ <&m1> $/, 'mutually recursive "()"';
    ok '(a)'    ~~ m/^ <&m1> $/, 'mutually recursive "(a)"';
    ok '(aa)'   ~~ m/^ <&m1> $/, 'mutually recursive "(aa)"';
    ok '(a(a))' ~~ m/^ <&m1> $/, 'mutually recursive "(a(a))"';
    ok '(()())' ~~ m/^ <&m1> $/, 'mutually recursive "(()())"';
    #?rakudo 3 skip 'exceptions from regexes'
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '('     !~~ m/^ <&m1> $/, '"(" is not matched';
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '(()'   !~~ m/^ <&m1> $/, '"(()" is not matched';
    #?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
    ok '())'   !~~ m/^ <&m1> $/, '"())" is not matched';
    ok 'a()'   !~~ m/^ <&m1> $/, '"a()" is not matched';
}

#?rakudo skip 'backtracking into ~'
#?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
{
    my regex even_a { ['a' ~ 'a' <&even_a> ]? };
    ok 'aaaa' ~~ m/^ <&even_a> $ /, 'backtracking into tilde rule (1)';
    ok 'aaa' !~~ m/^ <&even_a> $ /, 'backtracking into tilde rule (2)';
}

#?rakudo skip 'backtracking to find ~ goal'
#?niecza skip 'Unable to resolve method FAILGOAL in class Cursor'
{
    my regex even_b { 'a' ~ 'a' <&even_b>? };
    ok 'aaaa' ~~ m/^ <&even_b> /, 'tilde regex backtracks to find its goal';
    ok 'aaa' !~~ m/^ <&even_b> /, '...and fails for odd numbers';
}  

# vim: ft=perl6
