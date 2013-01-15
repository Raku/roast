use v6;

use Test;

plan 84;

#L<S05/Modifiers/"The extended syntax">

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

force_todo(18,67); # PCRE hard parsefails

my $b = 'x';
my $backspace = "\b";
my $bang = '!';

ok(("123\nabcabcabcabc\n" ~~ rx:P5/(?m)^.{9}abc.*\n/), 're_tests 1215  (1419)');
ok((not ("a" ~~ rx:P5/^(a)?(?(1)a|b)+$/)), 're_tests 1216  (1420)');
#?pugs todo
is(("aaaaaa" ~~ rx:P5/^(a\1?){4}$/ && $0), "aa", 're_tests 1218/1 (1422)');
ok(("x1" ~~ rx:P5/^(0+)?(?:x(1))?/), 're_tests 1220  (1424)');
ok(("012cxx0190" ~~ rx:P5/^([0-9a-fA-F]+)(?:x([0-9a-fA-F]+)?)(?:x([0-9a-fA-F]+))?/), 're_tests 1222  (1426)');
is(("bbbac" ~~ rx:P5/^(b+?|a){1,2}c/ && $0), "a", 're_tests 1224/1 (1428)');
is(("bbbbac" ~~ rx:P5/^(b+?|a){1,2}c/ && $0), "a", 're_tests 1226/1 (1430)');
ok(("aaaacccc" ~~ rx:P5/((?:aaaa|bbbb)cccc)?/), 're_tests 1228  (1432)');
ok(("bbbbcccc" ~~ rx:P5/((?:aaaa|bbbb)cccc)?/), 're_tests 1230  (1434)');
is(("a" ~~ rx:P5/(a)?(a)+/ && $0), "", 're_tests 1232/1 (1436)');
is(("a" ~~ rx:P5/(a)?(a)+/ && $1), "a", 're_tests 1232/2 (1437)');
is(("ab" ~~ rx:P5/(ab)?(ab)+/ && $0), "", 're_tests 1234/1 (1440)');
is(("ab" ~~ rx:P5/(ab)?(ab)+/ && $1), "ab", 're_tests 1234/2 (1441)');
is(("abc" ~~ rx:P5/(abc)?(abc)+/ && $0), "", 're_tests 1236/1 (1444)');
is(("abc" ~~ rx:P5/(abc)?(abc)+/ && $1), "abc", 're_tests 1236/2 (1445)');
ok((not ("a\nb\n" ~~ rx:P5/(?m)b\s^/)), 're_tests 1238  (1448)');
ok(("a" ~~ rx:P5/\ba/), 're_tests 1239  (1449)');
#?pugs skip "PCRE hard parsefail"
is(("ab" ~~ rx:P5/^(a(??{"(?!)"})|(a)(?{1}))b/ && $1), "a", 're_tests 1241/2 (1451)');
ok((not ("AbCd" ~~ rx:P5/ab(?i)cd/)), 're_tests 1242  (1452)');
ok(("abCd" ~~ rx:P5/ab(?i)cd/), 're_tests 1244  (1454)');
is(("CD" ~~ rx:P5/(A|B)*(?(1)(CD)|(CD))/ && $1), "", 're_tests 1246/2 (1456)');
is(("CD" ~~ rx:P5/(A|B)*(?(1)(CD)|(CD))/ && $2), "CD", 're_tests 1246/3 (1457)');
is(("ABCD" ~~ rx:P5/(A|B)*(?(1)(CD)|(CD))/ && $1), "CD", 're_tests 1248/2 (1460)');
is(("ABCD" ~~ rx:P5/(A|B)*(?(1)(CD)|(CD))/ && $2), "", 're_tests 1248/3 (1461)');
is(("CD" ~~ rx:P5/(A|B)*?(?(1)(CD)|(CD))/ && $1), "", 're_tests 1250/2 (1464)');
is(("CD" ~~ rx:P5/(A|B)*?(?(1)(CD)|(CD))/ && $2), "CD", 're_tests 1250/3 (1465)');
is(("ABCD" ~~ rx:P5/(A|B)*?(?(1)(CD)|(CD))/ && $1), "CD", 're_tests 1252/2 (1468)');
is(("ABCD" ~~ rx:P5/(A|B)*?(?(1)(CD)|(CD))/ && $2), "", 're_tests 1252/3 (1469)');
ok((not ("Oo" ~~ rx:P5/(?i)^(o)(?!.*\1)/)), 're_tests 1254  (1472)');
is(("abc12bc" ~~ rx:P5/(.*)\d+\1/ && $0), "bc", 're_tests 1256/1 (1474)');
is(("foo\n bar" ~~ rx:P5/(?m:(foo\s*$))/ && $0), "foo", 're_tests 1258/1 (1476)');
is(("abcd" ~~ rx:P5/(.*)c/ && $0), "ab", 're_tests 1259/1 (1477)');
is(("abcd" ~~ rx:P5/(.*)(?=c)/ && $0), "ab", 're_tests 1261/1 (1479)');
is(("abcd" ~~ rx:P5/(.*)(?=c)c/ && $0), "ab", 're_tests 1263/1 (1481)');
is(("abcd" ~~ rx:P5/(.*)(?=b|c)/ && $0), "ab", 're_tests 1265/1 (1483)');
is(("abcd" ~~ rx:P5/(.*)(?=b|c)c/ && $0), "ab", 're_tests 1267/1 (1485)');
is(("abcd" ~~ rx:P5/(.*)(?=c|b)/ && $0), "ab", 're_tests 1269/1 (1487)');
is(("abcd" ~~ rx:P5/(.*)(?=c|b)c/ && $0), "ab", 're_tests 1271/1 (1489)');
is(("abcd" ~~ rx:P5/(.*)(?=[bc])/ && $0), "ab", 're_tests 1273/1 (1491)');
is(("abcd" ~~ rx:P5/(.*)(?=[bc])c/ && $0), "ab", 're_tests 1275/1 (1493)');
is(("abcd" ~~ rx:P5/(.*)(?<=b)/ && $0), "ab", 're_tests 1277/1 (1495)');
is(("abcd" ~~ rx:P5/(.*)(?<=b)c/ && $0), "ab", 're_tests 1279/1 (1497)');
is(("abcd" ~~ rx:P5/(.*)(?<=b|c)/ && $0), "abc", 're_tests 1281/1 (1499)');
is(("abcd" ~~ rx:P5/(.*)(?<=b|c)c/ && $0), "ab", 're_tests 1283/1 (1501)');
is(("abcd" ~~ rx:P5/(.*)(?<=c|b)/ && $0), "abc", 're_tests 1285/1 (1503)');
is(("abcd" ~~ rx:P5/(.*)(?<=c|b)c/ && $0), "ab", 're_tests 1287/1 (1505)');
is(("abcd" ~~ rx:P5/(.*)(?<=[bc])/ && $0), "abc", 're_tests 1289/1 (1507)');
is(("abcd" ~~ rx:P5/(.*)(?<=[bc])c/ && $0), "ab", 're_tests 1291/1 (1509)');
is(("abcd" ~~ rx:P5/(.*?)c/ && $0), "ab", 're_tests 1293/1 (1511)');
is(("abcd" ~~ rx:P5/(.*?)(?=c)/ && $0), "ab", 're_tests 1295/1 (1513)');
is(("abcd" ~~ rx:P5/(.*?)(?=c)c/ && $0), "ab", 're_tests 1297/1 (1515)');
is(("abcd" ~~ rx:P5/(.*?)(?=b|c)/ && $0), "a", 're_tests 1299/1 (1517)');
is(("abcd" ~~ rx:P5/(.*?)(?=b|c)c/ && $0), "ab", 're_tests 1301/1 (1519)');
is(("abcd" ~~ rx:P5/(.*?)(?=c|b)/ && $0), "a", 're_tests 1303/1 (1521)');
is(("abcd" ~~ rx:P5/(.*?)(?=c|b)c/ && $0), "ab", 're_tests 1305/1 (1523)');
is(("abcd" ~~ rx:P5/(.*?)(?=[bc])/ && $0), "a", 're_tests 1307/1 (1525)');
is(("abcd" ~~ rx:P5/(.*?)(?=[bc])c/ && $0), "ab", 're_tests 1309/1 (1527)');
is(("abcd" ~~ rx:P5/(.*?)(?<=b)/ && $0), "ab", 're_tests 1311/1 (1529)');
is(("abcd" ~~ rx:P5/(.*?)(?<=b)c/ && $0), "ab", 're_tests 1313/1 (1531)');
is(("abcd" ~~ rx:P5/(.*?)(?<=b|c)/ && $0), "ab", 're_tests 1315/1 (1533)');
is(("abcd" ~~ rx:P5/(.*?)(?<=b|c)c/ && $0), "ab", 're_tests 1317/1 (1535)');
is(("abcd" ~~ rx:P5/(.*?)(?<=c|b)/ && $0), "ab", 're_tests 1319/1 (1537)');
is(("abcd" ~~ rx:P5/(.*?)(?<=c|b)c/ && $0), "ab", 're_tests 1321/1 (1539)');
is(("abcd" ~~ rx:P5/(.*?)(?<=[bc])/ && $0), "ab", 're_tests 1323/1 (1541)');
is(("abcd" ~~ rx:P5/(.*?)(?<=[bc])c/ && $0), "ab", 're_tests 1325/1 (1543)');
is(("2" ~~ rx:P5/2(]*)?$\1/ && $/), "2", 're_tests 1327/0 (1545)');
#?pugs skip "PCRE hard parsefail"
ok(("x" ~~ rx:P5/(??{})/), 're_tests 1329  (1547)');
is(("foobarbar" ~~ rx:P5/^.{3,4}(.+)\1\z/ && $0), "bar", 're_tests 1330/1 (1548)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){3,4}(.+)\1\z/ && $0), "bar", 're_tests 1332/1 (1550)');
is(("foobarbar" ~~ rx:P5/^.{3,4}((?:b|a|r)+)\1\z/ && $0), "bar", 're_tests 1334/1 (1552)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){3,4}((?:b|a|r)+)\1\z/ && $0), "bar", 're_tests 1336/1 (1554)');
is(("foobarbar" ~~ rx:P5/^.{3,4}(.+?)\1\z/ && $0), "bar", 're_tests 1338/1 (1556)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){3,4}(.+?)\1\z/ && $0), "bar", 're_tests 1340/1 (1558)');
is(("foobarbar" ~~ rx:P5/^.{3,4}((?:b|a|r)+?)\1\z/ && $0), "bar", 're_tests 1342/1 (1560)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){3,4}((?:b|a|r)+?)\1\z/ && $0), "bar", 're_tests 1344/1 (1562)');
is(("foobarbar" ~~ rx:P5/^.{2,3}?(.+)\1\z/ && $0), "bar", 're_tests 1346/1 (1564)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){2,3}?(.+)\1\z/ && $0), "bar", 're_tests 1348/1 (1566)');
is(("foobarbar" ~~ rx:P5/^.{2,3}?((?:b|a|r)+)\1\z/ && $0), "bar", 're_tests 1350/1 (1568)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){2,3}?((?:b|a|r)+)\1\z/ && $0), "bar", 're_tests 1352/1 (1570)');
is(("foobarbar" ~~ rx:P5/^.{2,3}?(.+?)\1\z/ && $0), "bar", 're_tests 1354/1 (1572)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){2,3}?(.+?)\1\z/ && $0), "bar", 're_tests 1356/1 (1574)');
is(("foobarbar" ~~ rx:P5/^.{2,3}?((?:b|a|r)+?)\1\z/ && $0), "bar", 're_tests 1358/1 (1576)');
is(("foobarbar" ~~ rx:P5/^(?:f|o|b){2,3}?((?:b|a|r)+?)\1\z/ && $0), "bar", 're_tests 1360/1 (1578)');
ok((not ("......abef" ~~ rx:P5/.*a(?!(b|cd)*e).*f/)), 're_tests 1362  (1580)');

# vim: ft=perl6
