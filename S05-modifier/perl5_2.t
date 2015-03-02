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

ok(("a b" ~~ rx:P5/a[\s]b/), 're_tests 171  (201)');
ok((not ("a-b" ~~ rx:P5/a[\s]b/)), 're_tests 173  (203)');
ok((not ("a b" ~~ rx:P5/a[\S]b/)), 're_tests 175  (205)');
ok(("a-b" ~~ rx:P5/a[\S]b/), 're_tests 177  (207)');
ok(("1" ~~ rx:P5/[\d]/), 're_tests 179  (209)');
ok((not ("-" ~~ rx:P5/[\d]/)), 're_tests 181  (211)');
ok((not ("1" ~~ rx:P5/[\D]/)), 're_tests 183  (213)');
ok(("-" ~~ rx:P5/[\D]/), 're_tests 185  (215)');
is(("abc" ~~ rx:P5/ab|cd/ && $/), "ab", 're_tests 187/0 (217)');
is(("abcd" ~~ rx:P5/ab|cd/ && $/), "ab", 're_tests 189/0 (219)');
is(("def" ~~ rx:P5/()ef/ && $/), "ef", 're_tests 191/0 (221)');
is(("def" ~~ rx:P5/()ef/ && $0), "", 're_tests 191/1 (222)');
is(("def" ~~ rx:P5/()ef/ && $/.from), 1, 're_tests 193/0 (225)');
is(("def" ~~ rx:P5/()ef/ && $/[0].from), 1, 're_tests 195/1 (227)');
ok((not ("b" ~~ rx:P5/$b/)), 're_tests 197  (229)');
is(("a(b" ~~ rx:P5/a\(b/ && $/), "a(b", 're_tests 199/0 (231)');
is(("a(b" ~~ rx:P5/a\(b/ && $0), Nil, 're_tests 199/1 (232)');
is(("ab" ~~ rx:P5/a\(*b/ && $/), "ab", 're_tests 201/0 (235)');
is(("a((b" ~~ rx:P5/a\(*b/ && $/), "a((b", 're_tests 203/0 (237)');
is(("a\b" ~~ rx:P5/a$backspace/ && $/), "a\b", 're_tests 205/0 (239)');
is(("a\\b" ~~ rx:P5/a\\b/ && $/), "a\\b", 're_tests 205/0 (239)');
is(("abc" ~~ rx:P5/((a))/ && $/), "a", 're_tests 207/0 (241)');
is(("abc" ~~ rx:P5/((a))/ && $0), "a", 're_tests 207/1 (242)');
is(("abc" ~~ rx:P5/((a))/ && $1), "a", 're_tests 207/2 (243)');
is(("abc" ~~ rx:P5/(a)b(c)/ && $/), "abc", 're_tests 209/0 (247)');
is(("abc" ~~ rx:P5/(a)b(c)/ && $0), "a", 're_tests 209/1 (248)');
is(("abc" ~~ rx:P5/(a)b(c)/ && $1), "c", 're_tests 209/2 (249)');
is(("aabbabc" ~~ rx:P5/a+b+c/ && $/), "abc", 're_tests 211/0 (253)');
is(("aabbabc" ~~ rx:P5/a{1,}b{1,}c/ && $/), "abc", 're_tests 213/0 (255)');
is(("abcabc" ~~ rx:P5/a.+?c/ && $/), "abc", 're_tests 215/0 (257)');
is(("ab" ~~ rx:P5/(a+|b)*/ && $/), "ab", 're_tests 217/0 (259)');
is(("ab" ~~ rx:P5/(a+|b)*/ && $0), "b", 're_tests 217/1 (260)');
is(("ab" ~~ rx:P5/(a+|b)*/ && $/.from), 0, 're_tests 219/0 (263)');
is(("ab" ~~ rx:P5/(a+|b)*/ && $/[0].from), 1, 're_tests 221/1 (265)');
is(("ab" ~~ rx:P5/(a+|b){0,}/ && $/), "ab", 're_tests 223/0 (267)');
is(("ab" ~~ rx:P5/(a+|b){0,}/ && $0), "b", 're_tests 223/1 (268)');
is(("ab" ~~ rx:P5/(a+|b)+/ && $/), "ab", 're_tests 225/0 (271)');
is(("ab" ~~ rx:P5/(a+|b)+/ && $0), "b", 're_tests 225/1 (272)');
is(("ab" ~~ rx:P5/(a+|b){1,}/ && $/), "ab", 're_tests 227/0 (275)');
is(("ab" ~~ rx:P5/(a+|b){1,}/ && $0), "b", 're_tests 227/1 (276)');
is(("ab" ~~ rx:P5/(a+|b)?/ && $/), "a", 're_tests 229/0 (279)');
is(("ab" ~~ rx:P5/(a+|b)?/ && $0), "a", 're_tests 229/1 (280)');
is(("ab" ~~ rx:P5/(a+|b){0,1}/ && $/), "a", 're_tests 231/0 (283)');
is(("ab" ~~ rx:P5/(a+|b){0,1}/ && $0), "a", 're_tests 231/1 (284)');
is(("cde" ~~ rx:P5/[^ab]*/ && $/), "cde", 're_tests 233/0 (287)');
ok((not ("" ~~ rx:P5/abc/)), 're_tests 235  (289)');
is(("" ~~ rx:P5/a*/ && $/), "", 're_tests 237/0 (291)');
is(("abbbcd" ~~ rx:P5/([abc])*d/ && $/), "abbbcd", 're_tests 239/0 (293)');
is(("abbbcd" ~~ rx:P5/([abc])*d/ && $0), "c", 're_tests 239/1 (294)');
is(("abcd" ~~ rx:P5/([abc])*bcd/ && $/), "abcd", 're_tests 241/0 (297)');
is(("abcd" ~~ rx:P5/([abc])*bcd/ && $0), "a", 're_tests 241/1 (298)');
is(("e" ~~ rx:P5/a|b|c|d|e/ && $/), "e", 're_tests 243/0 (301)');
is(("ef" ~~ rx:P5/(a|b|c|d|e)f/ && $/), "ef", 're_tests 245/0 (303)');
is(("ef" ~~ rx:P5/(a|b|c|d|e)f/ && $0), "e", 're_tests 245/1 (304)');
is(("ef" ~~ rx:P5/(a|b|c|d|e)f/ && $/.from), 0, 're_tests 247/0 (307)');
is(("ef" ~~ rx:P5/(a|b|c|d|e)f/ && $/[0].from), 0, 're_tests 249/1 (309)');
is(("abcdefg" ~~ rx:P5/abcd*efg/ && $/), "abcdefg", 're_tests 251/0 (311)');
is(("xabyabbbz" ~~ rx:P5/ab*/ && $/), "ab", 're_tests 253/0 (313)');
is(("xayabbbz" ~~ rx:P5/ab*/ && $/), "a", 're_tests 255/0 (315)');
is(("abcde" ~~ rx:P5/(ab|cd)e/ && $/), "cde", 're_tests 257/0 (317)');
is(("abcde" ~~ rx:P5/(ab|cd)e/ && $0), "cd", 're_tests 257/1 (318)');
is(("hij" ~~ rx:P5/[abhgefdc]ij/ && $/), "hij", 're_tests 259/0 (321)');
is(("abcdef" ~~ rx:P5/(abc|)ef/ && $/), "ef", 're_tests 261/0 (323)');
is(("abcdef" ~~ rx:P5/(abc|)ef/ && $0), "", 're_tests 261/1 (324)');
is(("abcd" ~~ rx:P5/(a|b)c*d/ && $/), "bcd", 're_tests 263/0 (327)');
is(("abcd" ~~ rx:P5/(a|b)c*d/ && $0), "b", 're_tests 263/1 (328)');
is(("abc" ~~ rx:P5/(ab|ab*)bc/ && $/), "abc", 're_tests 265/0 (331)');
is(("abc" ~~ rx:P5/(ab|ab*)bc/ && $0), "a", 're_tests 265/1 (332)');
is(("abc" ~~ rx:P5/a([bc]*)c*/ && $/), "abc", 're_tests 267/0 (335)');
is(("abc" ~~ rx:P5/a([bc]*)c*/ && $0), "bc", 're_tests 267/1 (336)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $/), "abcd", 're_tests 269/0 (339)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $0), "bc", 're_tests 269/1 (340)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $1), "d", 're_tests 269/2 (341)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $/.from), 0, 're_tests 271/0 (345)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $/[0].from), 1, 're_tests 273/1 (347)');
is(("abcd" ~~ rx:P5/a([bc]*)(c*d)/ && $/[1].from), 3, 're_tests 275/2 (349)');
is(("abcd" ~~ rx:P5/a([bc]+)(c*d)/ && $/), "abcd", 're_tests 277/0 (351)');
is(("abcd" ~~ rx:P5/a([bc]+)(c*d)/ && $0), "bc", 're_tests 277/1 (352)');
is(("abcd" ~~ rx:P5/a([bc]+)(c*d)/ && $1), "d", 're_tests 277/2 (353)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $/), "abcd", 're_tests 279/0 (357)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $0), "b", 're_tests 279/1 (358)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $1), "cd", 're_tests 279/2 (359)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $/.from), 0, 're_tests 281/0 (363)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $/[0].from), 1, 're_tests 283/1 (365)');
is(("abcd" ~~ rx:P5/a([bc]*)(c+d)/ && $/[1].from), 2, 're_tests 285/2 (367)');
is(("adcdcde" ~~ rx:P5/a[bcd]*dcdcde/ && $/), "adcdcde", 're_tests 287/0 (369)');
ok((not ("adcdcde" ~~ rx:P5/a[bcd]+dcdcde/)), 're_tests 289  (371)');
is(("abc" ~~ rx:P5/(ab|a)b*c/ && $/), "abc", 're_tests 291/0 (373)');
is(("abc" ~~ rx:P5/(ab|a)b*c/ && $0), "ab", 're_tests 291/1 (374)');
is(("abc" ~~ rx:P5/(ab|a)b*c/ && $/.from), 0, 're_tests 293/0 (377)');
is(("abc" ~~ rx:P5/(ab|a)b*c/ && $/[0].from), 0, 're_tests 295/1 (379)');
is(("abcd" ~~ rx:P5/((a)(b)c)(d)/ && $/.from), 0, 're_tests 297/0 (381)');
is(("abcd" ~~ rx:P5/((a)(b)c)(d)/ && $/[0].from), 0, 're_tests 299/1 (383)');
is(("abcd" ~~ rx:P5/((a)(b)c)(d)/ && $/[1].from), 0, 're_tests 301/2 (385)');
is(("abcd" ~~ rx:P5/((a)(b)c)(d)/ && $/[2].from), 1, 're_tests 303/3 (387)');
is(("abcd" ~~ rx:P5/((a)(b)c)(d)/ && $/[3].from), 3, 're_tests 305/4 (389)');
is(("alpha" ~~ rx:P5/[a-zA-Z_][a-zA-Z0-9_]*/ && $/), "alpha", 're_tests 307/0 (391)');
is(("abh" ~~ rx:P5/^a(bc+|b[eh])g|.h$/ && $/), "bh", 're_tests 309/0 (393)');
is(("abh" ~~ rx:P5/^a(bc+|b[eh])g|.h$/ && $0), Nil, 're_tests 309/1 (394)');
is(("effgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $/), "effgz", 're_tests 311/0 (397)');

# vim: ft=perl6
