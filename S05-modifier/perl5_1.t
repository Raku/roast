use v6;

use Test;

plan 100;

#L<S05/Modifiers/"The extended syntax">

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

my $b = 'x';
my $backspace = "\b";
my $bang = '!';

is(("abc" ~~ rx:P5/abc/ && $/), "abc", 're_tests 1/0 (1)');
is(("abc" ~~ rx:P5/abc/ && $/.from), 0, 're_tests 1/0 (2)');
ok((not ("xbc" ~~ rx:P5/abc/)), 're_tests 3  (5)');
ok((not ("axc" ~~ rx:P5/abc/)), 're_tests 5  (7)');
ok((not ("abx" ~~ rx:P5/abc/)), 're_tests 7  (9)');
is(("xabcy" ~~ rx:P5/abc/ && $/), "abc", 're_tests 9/0 (11)');
is(("xabcy" ~~ rx:P5/abc/ && $/.from), 1, 're_tests 9/0 (12)');
is(("ababc" ~~ rx:P5/abc/ && $/), "abc", 're_tests 11/0 (15)');
is(("ababc" ~~ rx:P5/abc/ && $/.from), 2, 're_tests 11/0 (16)');
is(("abc" ~~ rx:P5/ab*c/ && $/), "abc", 're_tests 13/0 (19)');
is(("abc" ~~ rx:P5/ab*c/ && $/.from), 0, 're_tests 13/0 (20)');
is(("abc" ~~ rx:P5/ab*bc/ && $/), "abc", 're_tests 15/0 (23)');
is(("abc" ~~ rx:P5/ab*bc/ && $/.from), 0, 're_tests 15/0 (24)');
is(("abbc" ~~ rx:P5/ab*bc/ && $/), "abbc", 're_tests 17/0 (27)');
is(("abbc" ~~ rx:P5/ab*bc/ && $/.from), 0, 're_tests 17/0 (28)');
is(("abbbbc" ~~ rx:P5/ab*bc/ && $/), "abbbbc", 're_tests 19/0 (31)');
is(("abbbbc" ~~ rx:P5/ab*bc/ && $/.from), 0, 're_tests 19/0 (32)');
is(("abbbbc" ~~ rx:P5/.{1}/ && $/), "a", 're_tests 21/0 (35)');
is(("abbbbc" ~~ rx:P5/.{1}/ && $/.from), 0, 're_tests 21/0 (36)');
is(("abbbbc" ~~ rx:P5/.{3,4}/ && $/), "abbb", 're_tests 23/0 (39)');
is(("abbbbc" ~~ rx:P5/.{3,4}/ && $/.from), 0, 're_tests 23/0 (40)');
is(("abbbbc" ~~ rx:P5/ab{0,}bc/ && $/), "abbbbc", 're_tests 25/0 (43)');
is(("abbbbc" ~~ rx:P5/ab{0,}bc/ && $/.from), 0, 're_tests 25/0 (44)');
is(("abbc" ~~ rx:P5/ab+bc/ && $/), "abbc", 're_tests 27/0 (47)');
is(("abbc" ~~ rx:P5/ab+bc/ && $/.from), 0, 're_tests 27/0 (48)');
ok((not ("abc" ~~ rx:P5/ab+bc/)), 're_tests 29  (51)');
ok((not ("abq" ~~ rx:P5/ab+bc/)), 're_tests 31  (53)');
ok((not ("abq" ~~ rx:P5/ab{1,}bc/)), 're_tests 33  (55)');
is(("abbbbc" ~~ rx:P5/ab+bc/ && $/), "abbbbc", 're_tests 35/0 (57)');
is(("abbbbc" ~~ rx:P5/ab+bc/ && $/.from), 0, 're_tests 35/0 (58)');
is(("abbbbc" ~~ rx:P5/ab{1,}bc/ && $/), "abbbbc", 're_tests 37/0 (61)');
is(("abbbbc" ~~ rx:P5/ab{1,}bc/ && $/.from), 0, 're_tests 37/0 (62)');
is(("abbbbc" ~~ rx:P5/ab{1,3}bc/ && $/), "abbbbc", 're_tests 39/0 (65)');
is(("abbbbc" ~~ rx:P5/ab{1,3}bc/ && $/.from), 0, 're_tests 39/0 (66)');
is(("abbbbc" ~~ rx:P5/ab{3,4}bc/ && $/), "abbbbc", 're_tests 41/0 (69)');
is(("abbbbc" ~~ rx:P5/ab{3,4}bc/ && $/.from), 0, 're_tests 41/0 (70)');
ok((not ("abbbbc" ~~ rx:P5/ab{4,5}bc/)), 're_tests 43  (73)');
is(("abbc" ~~ rx:P5/ab?bc/ && $/), "abbc", 're_tests 45/0 (75)');
is(("abc" ~~ rx:P5/ab?bc/ && $/), "abc", 're_tests 47/0 (77)');
is(("abc" ~~ rx:P5/ab{0,1}bc/ && $/), "abc", 're_tests 49/0 (79)');
ok((not ("abbbbc" ~~ rx:P5/ab?bc/)), 're_tests 51  (81)');
is(("abc" ~~ rx:P5/ab?c/ && $/), "abc", 're_tests 53/0 (83)');
is(("abc" ~~ rx:P5/ab{0,1}c/ && $/), "abc", 're_tests 55/0 (85)');
is(("abc" ~~ rx:P5/^abc$/ && $/), "abc", 're_tests 57/0 (87)');
ok((not ("abcc" ~~ rx:P5/^abc$/)), 're_tests 59  (89)');
is(("abcc" ~~ rx:P5/^abc/ && $/), "abc", 're_tests 61/0 (91)');
ok((not ("aabc" ~~ rx:P5/^abc$/)), 're_tests 63  (93)');
is(("aabc" ~~ rx:P5/abc$/ && $/), "abc", 're_tests 65/0 (95)');
ok((not ("aabcd" ~~ rx:P5/abc$/)), 're_tests 67  (97)');
is(("abc" ~~ rx:P5/^/ && $/), "", 're_tests 69/0 (99)');
is(("abc" ~~ rx:P5/$/ && $/), "", 're_tests 71/0 (101)');
is(("abc" ~~ rx:P5/a.c/ && $/), "abc", 're_tests 73/0 (103)');
is(("axc" ~~ rx:P5/a.c/ && $/), "axc", 're_tests 75/0 (105)');
is(("axyzc" ~~ rx:P5/a.*c/ && $/), "axyzc", 're_tests 77/0 (107)');
ok((not ("axyzd" ~~ rx:P5/a.*c/)), 're_tests 79  (109)');
ok((not ("abc" ~~ rx:P5/a[bc]d/)), 're_tests 81  (111)');
is(("abd" ~~ rx:P5/a[bc]d/ && $/), "abd", 're_tests 83/0 (113)');
ok((not ("abd" ~~ rx:P5/a[b-d]e/)), 're_tests 85  (115)');
is(("ace" ~~ rx:P5/a[b-d]e/ && $/), "ace", 're_tests 87/0 (117)');
is(("aac" ~~ rx:P5/a[b-d]/ && $/), "ac", 're_tests 89/0 (119)');
is(("a-" ~~ rx:P5/a[-b]/ && $/), "a-", 're_tests 91/0 (121)');
is(("a-" ~~ rx:P5/a[b-]/ && $/), "a-", 're_tests 93/0 (123)');
is(("a]" ~~ rx:P5/a]/ && $/), "a]", 're_tests 95/0 (125)');
is(("a]b" ~~ rx:P5/a[]]b/ && $/), "a]b", 're_tests 97/0 (127)');
is(("aed" ~~ rx:P5/a[^bc]d/ && $/), "aed", 're_tests 99/0 (129)');
ok((not ("abd" ~~ rx:P5/a[^bc]d/)), 're_tests 101  (131)');
is(("adc" ~~ rx:P5/a[^-b]c/ && $/), "adc", 're_tests 103/0 (133)');
ok((not ("a-c" ~~ rx:P5/a[^-b]c/)), 're_tests 105  (135)');
ok((not ("a]c" ~~ rx:P5/a[^]b]c/)), 're_tests 107  (137)');
is(("adc" ~~ rx:P5/a[^]b]c/ && $/), "adc", 're_tests 109/0 (139)');
ok(("a-" ~~ rx:P5/\ba\b/), 're_tests 111  (141)');
ok(("-a" ~~ rx:P5/\ba\b/), 're_tests 113  (143)');
ok(("-a-" ~~ rx:P5/\ba\b/), 're_tests 115  (145)');
ok((not ("xy" ~~ rx:P5/\by\b/)), 're_tests 117  (147)');
ok((not ("yz" ~~ rx:P5/\by\b/)), 're_tests 119  (149)');
ok((not ("xyz" ~~ rx:P5/\by\b/)), 're_tests 121  (151)');
ok((not ("a-" ~~ rx:P5/\Ba\B/)), 're_tests 123  (153)');
ok((not ("-a" ~~ rx:P5/\Ba\B/)), 're_tests 125  (155)');
ok((not ("-a-" ~~ rx:P5/\Ba\B/)), 're_tests 127  (157)');
ok(("xy" ~~ rx:P5/\By\b/), 're_tests 129  (159)');
is(("xy" ~~ rx:P5/\By\b/ && $/.from), 1, 're_tests 131/0 (161)');
ok(("xy" ~~ rx:P5/\By\b/), 're_tests 133  (163)');
ok(("yz" ~~ rx:P5/\by\B/), 're_tests 135  (165)');
ok(("xyz" ~~ rx:P5/\By\B/), 're_tests 137  (167)');
ok(("a" ~~ rx:P5/\w/), 're_tests 139  (169)');
ok((not ("-" ~~ rx:P5/\w/)), 're_tests 141  (171)');
ok((not ("a" ~~ rx:P5/\W/)), 're_tests 143  (173)');
ok(("-" ~~ rx:P5/\W/), 're_tests 145  (175)');
ok(("a b" ~~ rx:P5/a\sb/), 're_tests 147  (177)');
ok((not ("a-b" ~~ rx:P5/a\sb/)), 're_tests 149  (179)');
ok((not ("a b" ~~ rx:P5/a\Sb/)), 're_tests 151  (181)');
ok(("a-b" ~~ rx:P5/a\Sb/), 're_tests 153  (183)');
ok(("1" ~~ rx:P5/\d/), 're_tests 155  (185)');
ok((not ("-" ~~ rx:P5/\d/)), 're_tests 157  (187)');
ok((not ("1" ~~ rx:P5/\D/)), 're_tests 159  (189)');
ok(("-" ~~ rx:P5/\D/), 're_tests 161  (191)');
ok(("a" ~~ rx:P5/[\w]/), 're_tests 163  (193)');
ok((not ("-" ~~ rx:P5/[\w]/)), 're_tests 165  (195)');
ok((not ("a" ~~ rx:P5/[\W]/)), 're_tests 167  (197)');
ok(("-" ~~ rx:P5/[\W]/), 're_tests 169  (199)');

# vim: ft=perl6
