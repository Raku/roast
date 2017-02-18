use v6;
use Test;

plan 29;

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
    ok '('     !~~ m/^ <&recursive> $/, '"(" is not matched';
    ok '(()'   !~~ m/^ <&recursive> $/, '"(()" is not matched';
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
    ok '('     !~~ m/^ <&m1> $/, '"(" is not matched';
    ok '(()'   !~~ m/^ <&m1> $/, '"(()" is not matched';
    ok '())'   !~~ m/^ <&m1> $/, '"())" is not matched';
    ok 'a()'   !~~ m/^ <&m1> $/, '"a()" is not matched';
}

{
    my regex even_a { ['a' ~ 'a' <&even_a> ]? };
    ok 'aaaa' ~~ m/^ <&even_a> $ /, 'backtracking into tilde rule (1)';
    ok 'aaa' !~~ m/^ <&even_a> $ /, 'backtracking into tilde rule (2)';
}

{
    my regex even_b { 'a' ~ 'a' <&even_b>? };
    ok 'aaaa' ~~ m/^ <&even_b> $/, 'tilde regex backtracks to find its goal';
    ok 'aaa' !~~ m/^ <&even_b> $/, '...and fails for odd numbers';
}

{
    "abc" ~~ /a ~ (c) (b)/;
    is ($0,$1), ("c","b"), "~ operator in regexp does not revert capture order";
}

# RT #72440
ok "(f)oo" ~~ /^ \( ~ \) foo $/, 'Only take single atom after goal (1)';
nok "(fo)o" ~~ /^ \( ~ \) foo $/, 'Only take single atom after goal (2)';

# vim: ft=perl6
