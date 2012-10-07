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

is(~("ABC" ~~ rx:P5/(?i)((a))/ && $/), "A", 're_tests 481/0 (595)');
is(~("ABC" ~~ rx:P5/(?i)((a))/ && $0), "A", 're_tests 481/1 (596)');
is(~("ABC" ~~ rx:P5/(?i)((a))/ && $1), "A", 're_tests 481/2 (597)');
is(~("ABC" ~~ rx:P5/(?i)(a)b(c)/ && $/), "ABC", 're_tests 483/0 (601)');
is(~("ABC" ~~ rx:P5/(?i)(a)b(c)/ && $0), "A", 're_tests 483/1 (602)');
is(~("ABC" ~~ rx:P5/(?i)(a)b(c)/ && $1), "C", 're_tests 483/2 (603)');
is(~("AABBABC" ~~ rx:P5/(?i)a+b+c/ && $/), "ABC", 're_tests 485/0 (607)');
is(~("AABBABC" ~~ rx:P5/(?i)a{1,}b{1,}c/ && $/), "ABC", 're_tests 487/0 (609)');
is(~("ABCABC" ~~ rx:P5/(?i)a.+?c/ && $/), "ABC", 're_tests 489/0 (611)');
is(~("ABCABC" ~~ rx:P5/(?i)a.*?c/ && $/), "ABC", 're_tests 491/0 (613)');
is(~("ABCABC" ~~ rx:P5/(?i)a.{0,5}?c/ && $/), "ABC", 're_tests 493/0 (615)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)*/ && $/), "AB", 're_tests 495/0 (617)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)*/ && $0), "B", 're_tests 495/1 (618)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,}/ && $/), "AB", 're_tests 497/0 (621)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,}/ && $0), "B", 're_tests 497/1 (622)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)+/ && $/), "AB", 're_tests 499/0 (625)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)+/ && $0), "B", 're_tests 499/1 (626)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){1,}/ && $/), "AB", 're_tests 501/0 (629)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){1,}/ && $0), "B", 're_tests 501/1 (630)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)?/ && $/), "A", 're_tests 503/0 (633)');
is(~("AB" ~~ rx:P5/(?i)(a+|b)?/ && $0), "A", 're_tests 503/1 (634)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,1}/ && $/), "A", 're_tests 505/0 (637)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,1}/ && $0), "A", 're_tests 505/1 (638)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,1}?/ && $/), "", 're_tests 507/0 (641)');
is(~("AB" ~~ rx:P5/(?i)(a+|b){0,1}?/ && $0), "", 're_tests 507/1 (642)');
is(~("CDE" ~~ rx:P5/(?i)[^ab]*/ && $/), "CDE", 're_tests 509/0 (645)');
ok((not ("" ~~ rx:P5/(?i)abc/)), 're_tests 511  (647)');
is(~("" ~~ rx:P5/(?i)a*/ && $/), "", 're_tests 513/0 (649)');
is(~("ABBBCD" ~~ rx:P5/(?i)([abc])*d/ && $/), "ABBBCD", 're_tests 515/0 (651)');
is(~("ABBBCD" ~~ rx:P5/(?i)([abc])*d/ && $0), "C", 're_tests 515/1 (652)');
is(~("ABCD" ~~ rx:P5/(?i)([abc])*bcd/ && $/), "ABCD", 're_tests 517/0 (655)');
is(~("ABCD" ~~ rx:P5/(?i)([abc])*bcd/ && $0), "A", 're_tests 517/1 (656)');
is(~("E" ~~ rx:P5/(?i)a|b|c|d|e/ && $/), "E", 're_tests 519/0 (659)');
is(~("EF" ~~ rx:P5/(?i)(a|b|c|d|e)f/ && $/), "EF", 're_tests 521/0 (661)');
is(~("EF" ~~ rx:P5/(?i)(a|b|c|d|e)f/ && $0), "E", 're_tests 521/1 (662)');
is(~("ABCDEFG" ~~ rx:P5/(?i)abcd*efg/ && $/), "ABCDEFG", 're_tests 523/0 (665)');
is(~("XABYABBBZ" ~~ rx:P5/(?i)ab*/ && $/), "AB", 're_tests 525/0 (667)');
is(~("XAYABBBZ" ~~ rx:P5/(?i)ab*/ && $/), "A", 're_tests 527/0 (669)');
is(~("ABCDE" ~~ rx:P5/(?i)(ab|cd)e/ && $/), "CDE", 're_tests 529/0 (671)');
is(~("ABCDE" ~~ rx:P5/(?i)(ab|cd)e/ && $0), "CD", 're_tests 529/1 (672)');
is(~("HIJ" ~~ rx:P5/(?i)[abhgefdc]ij/ && $/), "HIJ", 're_tests 531/0 (675)');
is(~("ABCDEF" ~~ rx:P5/(?i)(abc|)ef/ && $/), "EF", 're_tests 533/0 (677)');
is(~("ABCDEF" ~~ rx:P5/(?i)(abc|)ef/ && $0), "", 're_tests 533/1 (678)');
is(~("ABCD" ~~ rx:P5/(?i)(a|b)c*d/ && $/), "BCD", 're_tests 535/0 (681)');
is(~("ABCD" ~~ rx:P5/(?i)(a|b)c*d/ && $0), "B", 're_tests 535/1 (682)');
is(~("ABC" ~~ rx:P5/(?i)(ab|ab*)bc/ && $/), "ABC", 're_tests 537/0 (685)');
is(~("ABC" ~~ rx:P5/(?i)(ab|ab*)bc/ && $0), "A", 're_tests 537/1 (686)');
is(~("ABC" ~~ rx:P5/(?i)a([bc]*)c*/ && $/), "ABC", 're_tests 539/0 (689)');
is(~("ABC" ~~ rx:P5/(?i)a([bc]*)c*/ && $0), "BC", 're_tests 539/1 (690)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c*d)/ && $/), "ABCD", 're_tests 541/0 (693)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c*d)/ && $0), "BC", 're_tests 541/1 (694)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c*d)/ && $1), "D", 're_tests 541/2 (695)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]+)(c*d)/ && $/), "ABCD", 're_tests 543/0 (699)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]+)(c*d)/ && $0), "BC", 're_tests 543/1 (700)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]+)(c*d)/ && $1), "D", 're_tests 543/2 (701)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c+d)/ && $/), "ABCD", 're_tests 545/0 (705)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c+d)/ && $0), "B", 're_tests 545/1 (706)');
is(~("ABCD" ~~ rx:P5/(?i)a([bc]*)(c+d)/ && $1), "CD", 're_tests 545/2 (707)');
is(~("ADCDCDE" ~~ rx:P5/(?i)a[bcd]*dcdcde/ && $/), "ADCDCDE", 're_tests 547/0 (711)');
ok(~(not ("ADCDCDE" ~~ rx:P5/(?i)a[bcd]+dcdcde/)), 're_tests 549  (713)');
is(~("ABC" ~~ rx:P5/(?i)(ab|a)b*c/ && $/), "ABC", 're_tests 551/0 (715)');
is(~("ABC" ~~ rx:P5/(?i)(ab|a)b*c/ && $0), "AB", 're_tests 551/1 (716)');
is(~("ALPHA" ~~ rx:P5/(?i)[a-zA-Z_][a-zA-Z0-9_]*/ && $/), "ALPHA", 're_tests 553/0 (719)');
is(~("ABH" ~~ rx:P5/(?i)^a(bc+|b[eh])g|.h$/ && $/), "BH", 're_tests 555/0 (721)');
is(~("ABH" ~~ rx:P5/(?i)^a(bc+|b[eh])g|.h$/ && $0), "", 're_tests 555/1 (722)');
is(~("EFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $/), "EFFGZ", 're_tests 557/0 (725)');
is(~("EFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $0), "EFFGZ", 're_tests 557/1 (726)');
is(~("EFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $1), "", 're_tests 557/2 (727)');
is(~("IJ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $/), "IJ", 're_tests 559/0 (731)');
is(~("IJ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $0), "IJ", 're_tests 559/1 (732)');
is(~("IJ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $1), "J", 're_tests 559/2 (733)');
ok(~(not ("EFFG" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/)), 're_tests 561  (737)');
ok(~(not ("BCDD" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/)), 're_tests 563  (739)');
is(~("REFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $/), "EFFGZ", 're_tests 565/0 (741)');
is(~("REFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $0), "EFFGZ", 're_tests 565/1 (742)');
is(~("REFFGZ" ~~ rx:P5/(?i)(bc+d$|ef*g.|h?i(j|k))/ && $1), "", 're_tests 565/2 (743)');
is(~("A" ~~ rx:P5/(?i)((((((((((a))))))))))/ && $00), "A", 're_tests 567/10 (747)');
is(~("AA" ~~ rx:P5/(?i)((((((((((a))))))))))\10/ && $/), "AA", 're_tests 569/0 (749)');
ok((not ("AA" ~~ rx:P5/(?i)((((((((((a))))))))))$bang/)), 're_tests 571  (751)');
#?rakudo todo "variable interpolation"
is(~("A!" ~~ rx:P5/(?i)((((((((((a))))))))))$bang/ && $/), "A!", 're_tests 572/0 (752)');
is(~("A" ~~ rx:P5/(?i)(((((((((a)))))))))/ && $/), "A", 're_tests 573/0 (753)');
is(~("A" ~~ rx:P5/(?i)(?:(?:(?:(?:(?:(?:(?:(?:(?:(a))))))))))/ && $0), "A", 're_tests 575/1 (755)');
is(~("C" ~~ rx:P5/(?i)(?:(?:(?:(?:(?:(?:(?:(?:(?:(a|b|c))))))))))/ && $0), "C", 're_tests 577/1 (757)');
ok((not ("UH-UH" ~~ rx:P5/(?i)multiple words of text/)), 're_tests 579  (759)');
is(~("MULTIPLE WORDS, YEAH" ~~ rx:P5/(?i)multiple words/ && $/), "MULTIPLE WORDS", 're_tests 581/0 (761)');
is(~("ABCDE" ~~ rx:P5/(?i)(.*)c(.*)/ && $/), "ABCDE", 're_tests 583/0 (763)');
is(~("ABCDE" ~~ rx:P5/(?i)(.*)c(.*)/ && $0), "AB", 're_tests 583/1 (764)');
is(~("ABCDE" ~~ rx:P5/(?i)(.*)c(.*)/ && $1), "DE", 're_tests 583/2 (765)');
ok((not ("AB" ~~ rx:P5/(?i)[k]/)), 're_tests 585  (769)');
is(~("AC" ~~ rx:P5/(?i)a[-]?c/ && $/), "AC", 're_tests 587/0 (771)');
is(~("ABCABC" ~~ rx:P5/(?i)(abc)\1/ && $0), "ABC", 're_tests 589/1 (773)');
is(~("ABCABC" ~~ rx:P5/(?i)([a-c]*)\1/ && $0), "ABC", 're_tests 591/1 (775)');
is(~("abad" ~~ rx:P5/a(?!b)./ && $/), "ad", 're_tests 593/0 (777)');
is(~("abad" ~~ rx:P5/a(?=d)./ && $/), "ad", 're_tests 595/0 (779)');
is(~("abad" ~~ rx:P5/a(?=c|d)./ && $/), "ad", 're_tests 597/0 (781)');
is(~("ace" ~~ rx:P5/a(?:b|c|d)(.)/ && $0), "e", 're_tests 599/1 (783)');
is(~("ace" ~~ rx:P5/a(?:b|c|d)*(.)/ && $0), "e", 're_tests 601/1 (785)');
is(~("ace" ~~ rx:P5/a(?:b|c|d)+?(.)/ && $0), "e", 're_tests 603/1 (787)');
is(~("acdbcdbe" ~~ rx:P5/a(?:b|c|d)+?(.)/ && $0), "d", 're_tests 605/1 (789)');
is(~("acdbcdbe" ~~ rx:P5/a(?:b|c|d)+(.)/ && $0), "e", 're_tests 607/1 (791)');

# vim: ft=perl6
