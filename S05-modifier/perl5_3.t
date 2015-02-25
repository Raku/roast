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

is(("effgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $0), "effgz", 're_tests 311/1 (398)');
is(("effgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $1), Nil, 're_tests 311/2 (399)');
is(("ij" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $/), "ij", 're_tests 313/0 (403)');
is(("ij" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $0), "ij", 're_tests 313/1 (404)');
is(("ij" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $1), "j", 're_tests 313/2 (405)');
ok((not ("effg" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/)), 're_tests 315  (409)');
ok((not ("bcdd" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/)), 're_tests 317  (411)');
is(("reffgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $/), "effgz", 're_tests 319/0 (413)');
is(("reffgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $0), "effgz", 're_tests 319/1 (414)');
is(("reffgz" ~~ rx:P5/(bc+d$|ef*g.|h?i(j|k))/ && $1), Nil, 're_tests 319/2 (415)');
is(("a" ~~ rx:P5/((((((((((a))))))))))/ && $00), "a", 're_tests 321/10 (419)');
is(("a" ~~ rx:P5/((((((((((a))))))))))/ && $/.from), 0, 're_tests 323/0 (421)');
is(("a" ~~ rx:P5/((((((((((a))))))))))/ && $/[0].from), 0, 're_tests 325/10 (423)');
is(("aa" ~~ rx:P5/((((((((((a))))))))))\10/ && $/), "aa", 're_tests 327/0 (425)');
ok((not ("aa" ~~ rx:P5/((((((((((a))))))))))$bang/)), 're_tests 329  (427)');
is(("a!" ~~ rx:P5/((((((((((a))))))))))$bang/ && $/), "a!", 're_tests 330/0 (428)');
is(("a" ~~ rx:P5/(((((((((a)))))))))/ && $/), "a", 're_tests 331/0 (429)');
ok((not ("uh-uh" ~~ rx:P5/multiple words of text/)), 're_tests 333  (431)');
is(("multiple words, yeah" ~~ rx:P5/multiple words/ && $/), "multiple words", 're_tests 335/0 (433)');
is(("abcde" ~~ rx:P5/(.*)c(.*)/ && $/), "abcde", 're_tests 337/0 (435)');
is(("abcde" ~~ rx:P5/(.*)c(.*)/ && $0), "ab", 're_tests 337/1 (436)');
is(("abcde" ~~ rx:P5/(.*)c(.*)/ && $1), "de", 're_tests 337/2 (437)');
ok((not ("ab" ~~ rx:P5/[k]/)), 're_tests 339  (441)');
is(("ac" ~~ rx:P5/a[-]?c/ && $/), "ac", 're_tests 341/0 (443)');
is(("abcabc" ~~ rx:P5/(abc)\1/ && $0), "abc", 're_tests 343/1 (445)');
is(("abcabc" ~~ rx:P5/([a-c]*)\1/ && $0), "abc", 're_tests 345/1 (447)');
ok(("a" ~~ rx:P5/(a)|\1/), 're_tests 347  (449)');
ok((not ("x" ~~ rx:P5/(a)|\1/)), 're_tests 349  (451)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2)*/ && $/), "ababb", 're_tests 351/0 (453)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2)*/ && $0), "bb", 're_tests 351/1 (454)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2)*/ && $1), "b", 're_tests 351/2 (455)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2){3}/ && $/), "ababbbcbc", 're_tests 353/0 (459)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2){3}/ && $0), "cbc", 're_tests 353/1 (460)');
is(("ababbbcbc" ~~ rx:P5/(([a-c])b*?\2){3}/ && $1), "c", 're_tests 353/2 (461)');
ok((not ("aaxabxbaxbbx" ~~ rx:P5/((\3|b)\2(a)x)+/)), 're_tests 355  (465)');
is(("b" ~~ rx:P5/(a)|(b)/ && $/.from), 0, 're_tests 357/0 (467)');
is(("b" ~~ rx:P5/(a)|(b)/ && $/[1].from), 0, 're_tests 359/2 (469)');
is(("ABC" ~~ rx:P5/(?i)abc/ && $/), "ABC", 're_tests 361/0 (471)');
ok((not ("XBC" ~~ rx:P5/(?i)abc/)), 're_tests 363  (473)');
ok((not ("AXC" ~~ rx:P5/(?i)abc/)), 're_tests 365  (475)');
ok((not ("ABX" ~~ rx:P5/(?i)abc/)), 're_tests 367  (477)');
is(("XABCY" ~~ rx:P5/(?i)abc/ && $/), "ABC", 're_tests 369/0 (479)');
is(("ABABC" ~~ rx:P5/(?i)abc/ && $/), "ABC", 're_tests 371/0 (481)');
is(("ABC" ~~ rx:P5/(?i)ab*c/ && $/), "ABC", 're_tests 373/0 (483)');
is(("ABC" ~~ rx:P5/(?i)ab*bc/ && $/), "ABC", 're_tests 375/0 (485)');
is(("ABBC" ~~ rx:P5/(?i)ab*bc/ && $/), "ABBC", 're_tests 377/0 (487)');
is(("ABBBBC" ~~ rx:P5/(?i)ab*?bc/ && $/), "ABBBBC", 're_tests 379/0 (489)');
is(("ABBBBC" ~~ rx:P5/(?i)ab{0,}?bc/ && $/), "ABBBBC", 're_tests 381/0 (491)');
is(("ABBC" ~~ rx:P5/(?i)ab+?bc/ && $/), "ABBC", 're_tests 383/0 (493)');
ok((not ("ABC" ~~ rx:P5/(?i)ab+bc/)), 're_tests 385  (495)');
ok((not ("ABQ" ~~ rx:P5/(?i)ab+bc/)), 're_tests 387  (497)');
ok((not ("ABQ" ~~ rx:P5/(?i)ab{1,}bc/)), 're_tests 389  (499)');
is(("ABBBBC" ~~ rx:P5/(?i)ab+bc/ && $/), "ABBBBC", 're_tests 391/0 (501)');
is(("ABBBBC" ~~ rx:P5/(?i)ab{1,}?bc/ && $/), "ABBBBC", 're_tests 393/0 (503)');
is(("ABBBBC" ~~ rx:P5/(?i)ab{1,3}?bc/ && $/), "ABBBBC", 're_tests 395/0 (505)');
is(("ABBBBC" ~~ rx:P5/(?i)ab{3,4}?bc/ && $/), "ABBBBC", 're_tests 397/0 (507)');
ok((not ("ABBBBC" ~~ rx:P5/(?i)ab{4,5}?bc/)), 're_tests 399  (509)');
is(("ABBC" ~~ rx:P5/(?i)ab??bc/ && $/), "ABBC", 're_tests 401/0 (511)');
is(("ABC" ~~ rx:P5/(?i)ab??bc/ && $/), "ABC", 're_tests 403/0 (513)');
is(("ABC" ~~ rx:P5/(?i)ab{0,1}?bc/ && $/), "ABC", 're_tests 405/0 (515)');
ok((not ("ABBBBC" ~~ rx:P5/(?i)ab??bc/)), 're_tests 407  (517)');
is(("ABC" ~~ rx:P5/(?i)ab??c/ && $/), "ABC", 're_tests 409/0 (519)');
is(("ABC" ~~ rx:P5/(?i)ab{0,1}?c/ && $/), "ABC", 're_tests 411/0 (521)');
is(("ABC" ~~ rx:P5/(?i)^abc$/ && $/), "ABC", 're_tests 413/0 (523)');
ok((not ("ABCC" ~~ rx:P5/(?i)^abc$/)), 're_tests 415  (525)');
is(("ABCC" ~~ rx:P5/(?i)^abc/ && $/), "ABC", 're_tests 417/0 (527)');
ok((not ("AABC" ~~ rx:P5/(?i)^abc$/)), 're_tests 419  (529)');
is(("AABC" ~~ rx:P5/(?i)abc$/ && $/), "ABC", 're_tests 421/0 (531)');
is(("ABC" ~~ rx:P5/(?i)^/ && $/), "", 're_tests 423/0 (533)');
is(("ABC" ~~ rx:P5/(?i)$/ && $/), "", 're_tests 425/0 (535)');
is(("ABC" ~~ rx:P5/(?i)a.c/ && $/), "ABC", 're_tests 427/0 (537)');
is(("AXC" ~~ rx:P5/(?i)a.c/ && $/), "AXC", 're_tests 429/0 (539)');
is(("AXYZC" ~~ rx:P5/(?i)a.*?c/ && $/), "AXYZC", 're_tests 431/0 (541)');
ok((not ("AXYZD" ~~ rx:P5/(?i)a.*c/)), 're_tests 433  (543)');
ok((not ("ABC" ~~ rx:P5/(?i)a[bc]d/)), 're_tests 435  (545)');
is(("ABD" ~~ rx:P5/(?i)a[bc]d/ && $/), "ABD", 're_tests 437/0 (547)');
ok((not ("ABD" ~~ rx:P5/(?i)a[b-d]e/)), 're_tests 439  (549)');
is(("ACE" ~~ rx:P5/(?i)a[b-d]e/ && $/), "ACE", 're_tests 441/0 (551)');
is(("AAC" ~~ rx:P5/(?i)a[b-d]/ && $/), "AC", 're_tests 443/0 (553)');
is(("A-" ~~ rx:P5/(?i)a[-b]/ && $/), "A-", 're_tests 445/0 (555)');
is(("A-" ~~ rx:P5/(?i)a[b-]/ && $/), "A-", 're_tests 447/0 (557)');
is(("A]" ~~ rx:P5/(?i)a]/ && $/), "A]", 're_tests 449/0 (559)');
is(("A]B" ~~ rx:P5/(?i)a[]]b/ && $/), "A]B", 're_tests 451/0 (561)');
is(("AED" ~~ rx:P5/(?i)a[^bc]d/ && $/), "AED", 're_tests 453/0 (563)');
ok((not ("ABD" ~~ rx:P5/(?i)a[^bc]d/)), 're_tests 455  (565)');
is(("ADC" ~~ rx:P5/(?i)a[^-b]c/ && $/), "ADC", 're_tests 457/0 (567)');
ok((not ("A-C" ~~ rx:P5/(?i)a[^-b]c/)), 're_tests 459  (569)');
ok((not ("A]C" ~~ rx:P5/(?i)a[^]b]c/)), 're_tests 461  (571)');
is(("ADC" ~~ rx:P5/(?i)a[^]b]c/ && $/), "ADC", 're_tests 463/0 (573)');
is(("ABC" ~~ rx:P5/(?i)ab|cd/ && $/), "AB", 're_tests 465/0 (575)');
is(("ABCD" ~~ rx:P5/(?i)ab|cd/ && $/), "AB", 're_tests 467/0 (577)');
is(("DEF" ~~ rx:P5/(?i)()ef/ && $/), "EF", 're_tests 469/0 (579)');
is(("DEF" ~~ rx:P5/(?i)()ef/ && $0), "", 're_tests 469/1 (580)');
ok((not ("B" ~~ rx:P5/(?i)$b/)), 're_tests 471  (583)');
is(("A(B" ~~ rx:P5/(?i)a\(b/ && $/), "A(B", 're_tests 473/0 (585)');
is(("A(B" ~~ rx:P5/(?i)a\(b/ && $0), Nil, 're_tests 473/1 (586)');
is(("AB" ~~ rx:P5/(?i)a\(*b/ && $/), "AB", 're_tests 475/0 (589)');
is(("A((B" ~~ rx:P5/(?i)a\(*b/ && $/), "A((B", 're_tests 477/0 (591)');
is(("A\\B" ~~ rx:P5/(?i)a\\b/ && $/), "A\\B", 're_tests 479/0 (593)');
is(("A\\\\B" ~~ rx:P5/(?i)a\\*b/ && $/), "A\\\\B", 're_tests 479/0 (593)');

# vim: ft=perl6
