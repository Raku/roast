use v6;

use Test;

plan 103;

#L<S05/Modifiers/"The extended syntax">

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

# force_todo(73..75); # PCRE hard parsefails

my $b = 'x';
my $backspace = "\b";
my $bang = '!';

ok((not ("abb\nb\n" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1049  (1253)');
ok((not ("abb\nb\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1050  (1254)');
is(("abb\nb\n" ~~ rx:P5/(?m)abb$/ && $/.from), 0, 're_tests 1051/0 (1255)');
is(("b\nabb\n" ~~ rx:P5/(?m)abb\Z/ && $/.from), 2, 're_tests 1052/0 (1256)');
ok((not ("b\nabb\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1053  (1257)');
is(("b\nabb\n" ~~ rx:P5/(?m)abb$/ && $/.from), 2, 're_tests 1054/0 (1258)');
is(("b\nabb" ~~ rx:P5/(?m)abb\Z/ && $/.from), 2, 're_tests 1055/0 (1259)');
is(("b\nabb" ~~ rx:P5/(?m)abb\z/ && $/.from), 2, 're_tests 1056/0 (1260)');
is(("b\nabb" ~~ rx:P5/(?m)abb$/ && $/.from), 2, 're_tests 1057/0 (1261)');
ok((not ("ac\nb\n" ~~ rx:P5/abb\Z/)), 're_tests 1058  (1262)');
ok((not ("ac\nb\n" ~~ rx:P5/abb\z/)), 're_tests 1060  (1264)');
ok((not ("ac\nb\n" ~~ rx:P5/abb$/)), 're_tests 1062  (1266)');
ok((not ("b\nac\n" ~~ rx:P5/abb\Z/)), 're_tests 1063  (1267)');
ok((not ("b\nac\n" ~~ rx:P5/abb\z/)), 're_tests 1065  (1269)');
ok((not ("b\nac\n" ~~ rx:P5/abb$/)), 're_tests 1067  (1271)');
ok((not ("b\nac" ~~ rx:P5/abb\Z/)), 're_tests 1068  (1272)');
ok((not ("b\nac" ~~ rx:P5/abb\z/)), 're_tests 1070  (1274)');
ok((not ("b\nac" ~~ rx:P5/abb$/)), 're_tests 1072  (1276)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1073  (1277)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1074  (1278)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)abb$/)), 're_tests 1075  (1279)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1076  (1280)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1077  (1281)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)abb$/)), 're_tests 1078  (1282)');
ok((not ("b\nac" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1079  (1283)');
ok((not ("b\nac" ~~ rx:P5/(?m)abb\z/)), 're_tests 1080  (1284)');
ok((not ("b\nac" ~~ rx:P5/(?m)abb$/)), 're_tests 1081  (1285)');
ok((not ("ca\nb\n" ~~ rx:P5/abb\Z/)), 're_tests 1082  (1286)');
ok((not ("ca\nb\n" ~~ rx:P5/abb\z/)), 're_tests 1084  (1288)');
ok((not ("ca\nb\n" ~~ rx:P5/abb$/)), 're_tests 1086  (1290)');
ok((not ("b\nca\n" ~~ rx:P5/abb\Z/)), 're_tests 1087  (1291)');
ok((not ("b\nca\n" ~~ rx:P5/abb\z/)), 're_tests 1089  (1293)');
ok((not ("b\nca\n" ~~ rx:P5/abb$/)), 're_tests 1091  (1295)');
ok((not ("b\nca" ~~ rx:P5/abb\Z/)), 're_tests 1092  (1296)');
ok((not ("b\nca" ~~ rx:P5/abb\z/)), 're_tests 1094  (1298)');
ok((not ("b\nca" ~~ rx:P5/abb$/)), 're_tests 1096  (1300)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1097  (1301)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1098  (1302)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)abb$/)), 're_tests 1099  (1303)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1100  (1304)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)abb\z/)), 're_tests 1101  (1305)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)abb$/)), 're_tests 1102  (1306)');
ok((not ("b\nca" ~~ rx:P5/(?m)abb\Z/)), 're_tests 1103  (1307)');
ok((not ("b\nca" ~~ rx:P5/(?m)abb\z/)), 're_tests 1104  (1308)');
ok((not ("b\nca" ~~ rx:P5/(?m)abb$/)), 're_tests 1105  (1309)');
is(("ca" ~~ rx:P5/(^|x)(c)/ && $1), "c", 're_tests 1106/2 (1310)');
ok((not ("x" ~~ rx:P5/a*abc?xyz+pqr{3}ab{2,}xy{4,5}pq{0,6}AB{0,}zz/)), 're_tests 1108  (1312)');
#?rakudo todo '(?>...) NYI'
is(("_I(round(xs * sz),1)" ~~ rx:P5/round\(((?>[^()]+))\)/ && $0), "xs * sz", 're_tests 1110/1 (1314)');
ok(("foo.bart" ~~ rx:P5/foo.bart/), 're_tests 1112  (1316)');
ok(("abcd\ndxxx" ~~ rx:P5/(?m)^d[x][x][x]/), 're_tests 1114  (1318)');
#?rakudo 18 skip 'expensive quantifier'
#?pugs todo "pugs regression"
ok(("bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+X/), 're_tests 1115  (1319)');
#?pugs todo "pugs regression"
ok(("bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+XX/), 're_tests 1117  (1321)');
#?pugs todo "pugs regression"
ok(("bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.XX(.+)+X/), 're_tests 1119  (1323)');
ok((not ("bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+X/)), 're_tests 1121  (1325)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+XX/)), 're_tests 1123  (1327)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.XX(.+)+X/)), 're_tests 1125  (1329)');
#?pugs 3 todo 'bug'
ok(("bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+[X]/), 're_tests 1127  (1331)');
ok(("bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+[X][X]/), 're_tests 1129  (1333)');
ok(("bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.XX(.+)+[X]/), 're_tests 1131  (1335)');
ok((not ("bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+[X]/)), 're_tests 1133  (1337)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.X(.+)+[X][X]/)), 're_tests 1135  (1339)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.XX(.+)+[X]/)), 're_tests 1137  (1341)');
#?pugs 3 todo 'bug'
ok(("bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X](.+)+[X]/), 're_tests 1139  (1343)');
ok(("bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X](.+)+[X][X]/), 're_tests 1141  (1345)');
ok(("bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X][X](.+)+[X]/), 're_tests 1143  (1347)');
ok((not ("bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X](.+)+[X]/)), 're_tests 1145  (1349)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X](.+)+[X][X]/)), 're_tests 1147  (1351)');
ok((not ("bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ~~ rx:P5/.[X][X](.+)+[X]/)), 're_tests 1149  (1353)');
ok(("xxxtt" ~~ rx:P5/tt+$/), 're_tests 1151  (1355)');
#?rakudo 6 skip 'character classes in enumerated range'
is(("za-9z" ~~ rx:P5/([a-\d]+)/ && $0), "a-9", 're_tests 1153/1 (1357)');
is(("a0-za" ~~ rx:P5/([\d-z]+)/ && $0), "0-z", 're_tests 1155/1 (1359)');
is(("a0- z" ~~ rx:P5/([\d-\s]+)/ && $0), "0- ", 're_tests 1157/1 (1361)');
#?pugs skip "PCRE hard parsefail"
is(("za-9z" ~~ rx:P5/([a-[:digit:]]+)/ && $0), "a-9", 're_tests 1159/1 (1363)');
is(("=0-z=" ~~ rx:P5/([[:digit:]-z]+)/ && $0), "0-z", 're_tests 1160/1 (1364)');
is(("=0-z=" ~~ rx:P5/([[:digit:]-[:alpha:]]+)/ && $0), "0-z", 're_tests 1161/1 (1365)');
#?rakudo skip '\G'
ok((not ("aaaXbX" ~~ rx:P5/\GX.*X/)), 're_tests 1162  (1366)');
is(("3.1415926" ~~ rx:P5/(\d+\.\d+)/ && $0), "3.1415926", 're_tests 1163/1 (1367)');
is(("have a web browser" ~~ rx:P5/(\ba.{0,10}br)/ && $0), "a web br", 're_tests 1165/1 (1369)');
ok((not ("Changes" ~~ rx:P5/(?i)\.c(pp|xx|c)?$/)), 're_tests 1167  (1371)');
ok(("IO.c" ~~ rx:P5/(?i)\.c(pp|xx|c)?$/), 're_tests 1169  (1373)');
is(("IO.c" ~~ rx:P5/(?i)(\.c(pp|xx|c)?$)/ && $0), ".c", 're_tests 1171/1 (1375)');
ok((not ("C:/" ~~ rx:P5/^([a-z]:)/)), 're_tests 1173  (1377)');
ok(("\nx aa" ~~ rx:P5/(?m)^\S\s+aa$/), 're_tests 1175  (1379)');
ok(("ab" ~~ rx:P5/(^|a)b/), 're_tests 1176  (1380)');
ok((not ("abcab" ~~ rx:P5/(\w)?(abc)\1b/)), 're_tests 1178  (1382)');
ok(("a,b,c" ~~ rx:P5/^(?:.,){2}c/), 're_tests 1180  (1384)');
is(("a,b,c" ~~ rx:P5/^(.,){2}c/ && $0), "b,", 're_tests 1182/1 (1386)');
ok(("a,b,c" ~~ rx:P5/^(?:[^,]*,){2}c/), 're_tests 1184  (1388)');
is(("a,b,c" ~~ rx:P5/^([^,]*,){2}c/ && $0), "b,", 're_tests 1186/1 (1390)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]*,){3}d/ && $0), "c,", 're_tests 1188/1 (1392)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]*,){3,}d/ && $0), "c,", 're_tests 1190/1 (1394)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]*,){0,3}d/ && $0), "c,", 're_tests 1192/1 (1396)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,3},){3}d/ && $0), "c,", 're_tests 1194/1 (1398)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,3},){3,}d/ && $0), "c,", 're_tests 1196/1 (1400)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,3},){0,3}d/ && $0), "c,", 're_tests 1198/1 (1402)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,},){3}d/ && $0), "c,", 're_tests 1200/1 (1404)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,},){3,}d/ && $0), "c,", 're_tests 1202/1 (1406)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{1,},){0,3}d/ && $0), "c,", 're_tests 1204/1 (1408)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{0,3},){3}d/ && $0), "c,", 're_tests 1206/1 (1410)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{0,3},){3,}d/ && $0), "c,", 're_tests 1208/1 (1412)');
is(("aaa,b,c,d" ~~ rx:P5/^([^,]{0,3},){0,3}d/ && $0), "c,", 're_tests 1210/1 (1414)');
ok(("" ~~ rx:P5/(?i)/), 're_tests 1212  (1416)');
ok(("a\nxb\n" ~~ rx:P5/(?m)(?!\A)x/), 're_tests 1214  (1418)');

# vim: ft=perl6
