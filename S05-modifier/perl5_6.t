use v6;

use Test;

plan 104;

#L<S05/Modifiers/"The extended syntax">

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

my $b = 'x';
my $backspace = "\b";
my $bang = '!';

is(("a\nb\nc\n" ~~ rx:P5/((?m)^b)/ && $0), "b", 're_tests 763/1 (959)');
#?pugs 2 skip 'reference to non-existent subpattern'
ok((not ("a" ~~ rx:P5/(?(1)a|b)/)), 're_tests 764  (960)');
is(("a" ~~ rx:P5/(?(1)b|a)/ && $/), "a", 're_tests 766/0 (962)');
ok((not ("a" ~~ rx:P5/(x)?(?(1)a|b)/)), 're_tests 768  (964)');
is(("a" ~~ rx:P5/(x)?(?(1)b|a)/ && $/), "a", 're_tests 770/0 (966)');
is(("a" ~~ rx:P5/()?(?(1)b|a)/ && $/), "a", 're_tests 772/0 (968)');
ok((not ("a" ~~ rx:P5/()(?(1)b|a)/)), 're_tests 774  (970)');
is(("a" ~~ rx:P5/()?(?(1)a|b)/ && $/), "a", 're_tests 776/0 (972)');
is(("(blah)" ~~ rx:P5/^(\()?blah(?(1)(\)))$/ && $1), ")", 're_tests 778/2 (974)');
ok((not ("blah)" ~~ rx:P5/^(\()?blah(?(1)(\)))$/)), 're_tests 780  (976)');
ok((not ("(blah" ~~ rx:P5/^(\()?blah(?(1)(\)))$/)), 're_tests 782  (978)');
is(("(blah)" ~~ rx:P5/^(\(+)?blah(?(1)(\)))$/ && $1), ")", 're_tests 784/2 (980)');
ok((not ("blah)" ~~ rx:P5/^(\(+)?blah(?(1)(\)))$/)), 're_tests 786  (982)');
ok((not ("(blah" ~~ rx:P5/^(\(+)?blah(?(1)(\)))$/)), 're_tests 788  (984)');
#?pugs 4 skip 'assertion expected after (?(")'
ok((not ("a" ~~ rx:P5/(?(?{0})a|b)/)), 're_tests 790  (986)');
is(("a" ~~ rx:P5/(?(?{0})b|a)/ && $/), "a", 're_tests 791/0 (987)');
ok((not ("a" ~~ rx:P5/(?(?{1})b|a)/)), 're_tests 792  (988)');
is(("a" ~~ rx:P5/(?(?{1})a|b)/ && $/), "a", 're_tests 793/0 (989)');
ok((not ("a" ~~ rx:P5/(?(?!a)a|b)/)), 're_tests 794  (990)');
is(("a" ~~ rx:P5/(?(?!a)b|a)/ && $/), "a", 're_tests 795/0 (991)');
ok((not ("a" ~~ rx:P5/(?(?=a)b|a)/)), 're_tests 796  (992)');
is(("a" ~~ rx:P5/(?(?=a)a|b)/ && $/), "a", 're_tests 797/0 (993)');
is(("aaab" ~~ rx:P5/(?=(a+?))(\1ab)/ && $1), "aab", 're_tests 798/2 (994)');
ok((not ("aaab" ~~ rx:P5/^(?=(a+?))\1ab/)), 're_tests 800  (996)');
is(("one:" ~~ rx:P5/(\w+:)+/ && $0), "one:", 're_tests 802/1 (998)');
is(("a" ~~ rx:P5/$(?<=^(a))/ && $0), "a", 're_tests 804/1 (1000)');
is(("aaab" ~~ rx:P5/(?=(a+?))(\1ab)/ && $1), "aab", 're_tests 806/2 (1002)');
ok((not ("aaab" ~~ rx:P5/^(?=(a+?))\1ab/)), 're_tests 808  (1004)');
ok((not ("abcd:" ~~ rx:P5/([\w:]+::)?(\w+)$/)), 're_tests 810  (1006)');
is(("abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $0), "", 're_tests 812/1 (1008)');
is(("abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $1), "abcd", 're_tests 812/2 (1009)');
is(("xy:z:::abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $0), "xy:z:::", 're_tests 814/1 (1012)');
is(("xy:z:::abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $1), "abcd", 're_tests 814/2 (1013)');
is(("aexycd" ~~ rx:P5/^[^bcd]*(c+)/ && $0), "c", 're_tests 816/1 (1016)');
is(("caab" ~~ rx:P5/(a*)b+/ && $0), "aa", 're_tests 818/1 (1018)');
ok((not ("abcd:" ~~ rx:P5/([\w:]+::)?(\w+)$/)), 're_tests 820  (1020)');
is(("abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $0), "", 're_tests 822/1 (1022)');
is(("abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $1), "abcd", 're_tests 822/2 (1023)');
is(("xy:z:::abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $0), "xy:z:::", 're_tests 824/1 (1026)');
is(("xy:z:::abcd" ~~ rx:P5/([\w:]+::)?(\w+)$/ && $1), "abcd", 're_tests 824/2 (1027)');
is(("aexycd" ~~ rx:P5/^[^bcd]*(c+)/ && $0), "c", 're_tests 826/1 (1030)');
ok((not ("aaab" ~~ rx:P5/(>a+)ab/)), 're_tests 828  (1032)');
ok(("aaab" ~~ rx:P5/(?>a+)b/), 're_tests 829  (1033)');
is(("a:[b]:" ~~ rx:P5/([[:]+)/ && $0), ":[", 're_tests 831/1 (1035)');
is(("a=[b]=" ~~ rx:P5/([[=]+)/ && $0), "=[", 're_tests 832/1 (1036)');
is(("a.[b]." ~~ rx:P5/([[.]+)/ && $0), ".[", 're_tests 833/1 (1037)');
is(("abc" ~~ rx:P5/[a[:]b[:c]/ && $/), "abc", 're_tests 834/0 (1038)');
is(("abc" ~~ rx:P5/[a[:]b[:c]/ && $/), "abc", 're_tests 835/0 (1039)');
is(("aaab" ~~ rx:P5/((?>a+)b)/ && $0), "aaab", 're_tests 836/1 (1040)');
is(("aaab" ~~ rx:P5/(?>(a+))b/ && $0), "aaa", 're_tests 838/1 (1042)');
is(("((abc(ade)ufh()()x" ~~ rx:P5/((?>[^()]+)|\([^()]*\))+/ && $/), "abc(ade)ufh()()x", 're_tests 840/0 (1044)');
is(("a\nb\n" ~~ rx:P5/\Z/ && $/.from), 3, 're_tests 842/0 (1046)');
is(("a\nb\n" ~~ rx:P5/\z/ && $/.from), 4, 're_tests 844/0 (1048)');
is(("a\nb\n" ~~ rx:P5/$/ && $/.from), 3, 're_tests 846/0 (1050)');
is(("b\na\n" ~~ rx:P5/\Z/ && $/.from), 3, 're_tests 847/0 (1051)');
is(("b\na\n" ~~ rx:P5/\z/ && $/.from), 4, 're_tests 849/0 (1053)');
is(("b\na\n" ~~ rx:P5/$/ && $/.from), 3, 're_tests 851/0 (1055)');
is(("b\na" ~~ rx:P5/\Z/ && $/.from), 3, 're_tests 852/0 (1056)');
is(("b\na" ~~ rx:P5/\z/ && $/.from), 3, 're_tests 854/0 (1058)');
is(("b\na" ~~ rx:P5/$/ && $/.from), 3, 're_tests 856/0 (1060)');
is(("a\nb\n" ~~ rx:P5/(?m)\Z/ && $/.from), 3, 're_tests 857/0 (1061)');
is(("a\nb\n" ~~ rx:P5/(?m)\z/ && $/.from), 4, 're_tests 858/0 (1062)');
is(("a\nb\n" ~~ rx:P5/(?m)$/ && $/.from), 1, 're_tests 859/0 (1063)');
is(("b\na\n" ~~ rx:P5/(?m)\Z/ && $/.from), 3, 're_tests 860/0 (1064)');
is(("b\na\n" ~~ rx:P5/(?m)\z/ && $/.from), 4, 're_tests 861/0 (1065)');
is(("b\na\n" ~~ rx:P5/(?m)$/ && $/.from), 1, 're_tests 862/0 (1066)');
is(("b\na" ~~ rx:P5/(?m)\Z/ && $/.from), 3, 're_tests 863/0 (1067)');
is(("b\na" ~~ rx:P5/(?m)\z/ && $/.from), 3, 're_tests 864/0 (1068)');
is(("b\na" ~~ rx:P5/(?m)$/ && $/.from), 1, 're_tests 865/0 (1069)');
ok((not ("a\nb\n" ~~ rx:P5/a\Z/)), 're_tests 866  (1070)');
ok((not ("a\nb\n" ~~ rx:P5/a\z/)), 're_tests 868  (1072)');
ok((not ("a\nb\n" ~~ rx:P5/a$/)), 're_tests 870  (1074)');
is(("b\na\n" ~~ rx:P5/a\Z/ && $/.from), 2, 're_tests 871/0 (1075)');
ok((not ("b\na\n" ~~ rx:P5/a\z/)), 're_tests 873  (1077)');
is(("b\na\n" ~~ rx:P5/a$/ && $/.from), 2, 're_tests 875/0 (1079)');
is(("b\na" ~~ rx:P5/a\Z/ && $/.from), 2, 're_tests 876/0 (1080)');
is(("b\na" ~~ rx:P5/a\z/ && $/.from), 2, 're_tests 878/0 (1082)');
is(("b\na" ~~ rx:P5/a$/ && $/.from), 2, 're_tests 880/0 (1084)');
ok((not ("a\nb\n" ~~ rx:P5/(?m)a\Z/)), 're_tests 881  (1085)');
ok((not ("a\nb\n" ~~ rx:P5/(?m)a\z/)), 're_tests 882  (1086)');
is(("a\nb\n" ~~ rx:P5/(?m)a$/ && $/.from), 0, 're_tests 883/0 (1087)');
is(("b\na\n" ~~ rx:P5/(?m)a\Z/ && $/.from), 2, 're_tests 884/0 (1088)');
ok((not ("b\na\n" ~~ rx:P5/(?m)a\z/)), 're_tests 885  (1089)');
is(("b\na\n" ~~ rx:P5/(?m)a$/ && $/.from), 2, 're_tests 886/0 (1090)');
is(("b\na" ~~ rx:P5/(?m)a\Z/ && $/.from), 2, 're_tests 887/0 (1091)');
is(("b\na" ~~ rx:P5/(?m)a\z/ && $/.from), 2, 're_tests 888/0 (1092)');
is(("b\na" ~~ rx:P5/(?m)a$/ && $/.from), 2, 're_tests 889/0 (1093)');
ok((not ("aa\nb\n" ~~ rx:P5/aa\Z/)), 're_tests 890  (1094)');
ok((not ("aa\nb\n" ~~ rx:P5/aa\z/)), 're_tests 892  (1096)');
ok((not ("aa\nb\n" ~~ rx:P5/aa$/)), 're_tests 894  (1098)');
is(("b\naa\n" ~~ rx:P5/aa\Z/ && $/.from), 2, 're_tests 895/0 (1099)');
ok((not ("b\naa\n" ~~ rx:P5/aa\z/)), 're_tests 897  (1101)');
is(("b\naa\n" ~~ rx:P5/aa$/ && $/.from), 2, 're_tests 899/0 (1103)');
is(("b\naa" ~~ rx:P5/aa\Z/ && $/.from), 2, 're_tests 900/0 (1104)');
is(("b\naa" ~~ rx:P5/aa\z/ && $/.from), 2, 're_tests 902/0 (1106)');
is(("b\naa" ~~ rx:P5/aa$/ && $/.from), 2, 're_tests 904/0 (1108)');
ok((not ("aa\nb\n" ~~ rx:P5/(?m)aa\Z/)), 're_tests 905  (1109)');
ok((not ("aa\nb\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 906  (1110)');
is(("aa\nb\n" ~~ rx:P5/(?m)aa$/ && $/.from), 0, 're_tests 907/0 (1111)');
is(("b\naa\n" ~~ rx:P5/(?m)aa\Z/ && $/.from), 2, 're_tests 908/0 (1112)');
ok((not ("b\naa\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 909  (1113)');
is(("b\naa\n" ~~ rx:P5/(?m)aa$/ && $/.from), 2, 're_tests 910/0 (1114)');
is(("b\naa" ~~ rx:P5/(?m)aa\Z/ && $/.from), 2, 're_tests 911/0 (1115)');
is(("b\naa" ~~ rx:P5/(?m)aa\z/ && $/.from), 2, 're_tests 912/0 (1116)');

# vim: ft=perl6
