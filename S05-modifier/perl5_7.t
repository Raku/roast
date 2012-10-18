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

is(("b\naa" ~~ rx:P5/(?m)aa$/ && $/.from), 2, 're_tests 913/0 (1117)');
ok((not ("ac\nb\n" ~~ rx:P5/aa\Z/)), 're_tests 914  (1118)');
ok((not ("ac\nb\n" ~~ rx:P5/aa\z/)), 're_tests 916  (1120)');
ok((not ("ac\nb\n" ~~ rx:P5/aa$/)), 're_tests 918  (1122)');
ok((not ("b\nac\n" ~~ rx:P5/aa\Z/)), 're_tests 919  (1123)');
ok((not ("b\nac\n" ~~ rx:P5/aa\z/)), 're_tests 921  (1125)');
ok((not ("b\nac\n" ~~ rx:P5/aa$/)), 're_tests 923  (1127)');
ok((not ("b\nac" ~~ rx:P5/aa\Z/)), 're_tests 924  (1128)');
ok((not ("b\nac" ~~ rx:P5/aa\z/)), 're_tests 926  (1130)');
ok((not ("b\nac" ~~ rx:P5/aa$/)), 're_tests 928  (1132)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)aa\Z/)), 're_tests 929  (1133)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 930  (1134)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)aa$/)), 're_tests 931  (1135)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)aa\Z/)), 're_tests 932  (1136)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 933  (1137)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)aa$/)), 're_tests 934  (1138)');
ok((not ("b\nac" ~~ rx:P5/(?m)aa\Z/)), 're_tests 935  (1139)');
ok((not ("b\nac" ~~ rx:P5/(?m)aa\z/)), 're_tests 936  (1140)');
ok((not ("b\nac" ~~ rx:P5/(?m)aa$/)), 're_tests 937  (1141)');
ok((not ("ca\nb\n" ~~ rx:P5/aa\Z/)), 're_tests 938  (1142)');
ok((not ("ca\nb\n" ~~ rx:P5/aa\z/)), 're_tests 940  (1144)');
ok((not ("ca\nb\n" ~~ rx:P5/aa$/)), 're_tests 942  (1146)');
ok((not ("b\nca\n" ~~ rx:P5/aa\Z/)), 're_tests 943  (1147)');
ok((not ("b\nca\n" ~~ rx:P5/aa\z/)), 're_tests 945  (1149)');
ok((not ("b\nca\n" ~~ rx:P5/aa$/)), 're_tests 947  (1151)');
ok((not ("b\nca" ~~ rx:P5/aa\Z/)), 're_tests 948  (1152)');
ok((not ("b\nca" ~~ rx:P5/aa\z/)), 're_tests 950  (1154)');
ok((not ("b\nca" ~~ rx:P5/aa$/)), 're_tests 952  (1156)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)aa\Z/)), 're_tests 953  (1157)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 954  (1158)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)aa$/)), 're_tests 955  (1159)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)aa\Z/)), 're_tests 956  (1160)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)aa\z/)), 're_tests 957  (1161)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)aa$/)), 're_tests 958  (1162)');
ok((not ("b\nca" ~~ rx:P5/(?m)aa\Z/)), 're_tests 959  (1163)');
ok((not ("b\nca" ~~ rx:P5/(?m)aa\z/)), 're_tests 960  (1164)');
ok((not ("b\nca" ~~ rx:P5/(?m)aa$/)), 're_tests 961  (1165)');
ok((not ("ab\nb\n" ~~ rx:P5/ab\Z/)), 're_tests 962  (1166)');
ok((not ("ab\nb\n" ~~ rx:P5/ab\z/)), 're_tests 964  (1168)');
ok((not ("ab\nb\n" ~~ rx:P5/ab$/)), 're_tests 966  (1170)');
is(("b\nab\n" ~~ rx:P5/ab\Z/ && $/.from), 2, 're_tests 967/0 (1171)');
ok((not ("b\nab\n" ~~ rx:P5/ab\z/)), 're_tests 969  (1173)');
is(("b\nab\n" ~~ rx:P5/ab$/ && $/.from), 2, 're_tests 971/0 (1175)');
is(("b\nab" ~~ rx:P5/ab\Z/ && $/.from), 2, 're_tests 972/0 (1176)');
is(("b\nab" ~~ rx:P5/ab\z/ && $/.from), 2, 're_tests 974/0 (1178)');
is(("b\nab" ~~ rx:P5/ab$/ && $/.from), 2, 're_tests 976/0 (1180)');
ok((not ("ab\nb\n" ~~ rx:P5/(?m)ab\Z/)), 're_tests 977  (1181)');
ok((not ("ab\nb\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 978  (1182)');
is(("ab\nb\n" ~~ rx:P5/(?m)ab$/ && $/.from), 0, 're_tests 979/0 (1183)');
is(("b\nab\n" ~~ rx:P5/(?m)ab\Z/ && $/.from), 2, 're_tests 980/0 (1184)');
ok((not ("b\nab\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 981  (1185)');
is(("b\nab\n" ~~ rx:P5/(?m)ab$/ && $/.from), 2, 're_tests 982/0 (1186)');
is(("b\nab" ~~ rx:P5/(?m)ab\Z/ && $/.from), 2, 're_tests 983/0 (1187)');
is(("b\nab" ~~ rx:P5/(?m)ab\z/ && $/.from), 2, 're_tests 984/0 (1188)');
is(("b\nab" ~~ rx:P5/(?m)ab$/ && $/.from), 2, 're_tests 985/0 (1189)');
ok((not ("ac\nb\n" ~~ rx:P5/ab\Z/)), 're_tests 986  (1190)');
ok((not ("ac\nb\n" ~~ rx:P5/ab\z/)), 're_tests 988  (1192)');
ok((not ("ac\nb\n" ~~ rx:P5/ab$/)), 're_tests 990  (1194)');
ok((not ("b\nac\n" ~~ rx:P5/ab\Z/)), 're_tests 991  (1195)');
ok((not ("b\nac\n" ~~ rx:P5/ab\z/)), 're_tests 993  (1197)');
ok((not ("b\nac\n" ~~ rx:P5/ab$/)), 're_tests 995  (1199)');
ok((not ("b\nac" ~~ rx:P5/ab\Z/)), 're_tests 996  (1200)');
ok((not ("b\nac" ~~ rx:P5/ab\z/)), 're_tests 998  (1202)');
ok((not ("b\nac" ~~ rx:P5/ab$/)), 're_tests 1000  (1204)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1001  (1205)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 1002  (1206)');
ok((not ("ac\nb\n" ~~ rx:P5/(?m)ab$/)), 're_tests 1003  (1207)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1004  (1208)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 1005  (1209)');
ok((not ("b\nac\n" ~~ rx:P5/(?m)ab$/)), 're_tests 1006  (1210)');
ok((not ("b\nac" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1007  (1211)');
ok((not ("b\nac" ~~ rx:P5/(?m)ab\z/)), 're_tests 1008  (1212)');
ok((not ("b\nac" ~~ rx:P5/(?m)ab$/)), 're_tests 1009  (1213)');
ok((not ("ca\nb\n" ~~ rx:P5/ab\Z/)), 're_tests 1010  (1214)');
ok((not ("ca\nb\n" ~~ rx:P5/ab\z/)), 're_tests 1012  (1216)');
ok((not ("ca\nb\n" ~~ rx:P5/ab$/)), 're_tests 1014  (1218)');
ok((not ("b\nca\n" ~~ rx:P5/ab\Z/)), 're_tests 1015  (1219)');
ok((not ("b\nca\n" ~~ rx:P5/ab\z/)), 're_tests 1017  (1221)');
ok((not ("b\nca\n" ~~ rx:P5/ab$/)), 're_tests 1019  (1223)');
ok((not ("b\nca" ~~ rx:P5/ab\Z/)), 're_tests 1020  (1224)');
ok((not ("b\nca" ~~ rx:P5/ab\z/)), 're_tests 1022  (1226)');
ok((not ("b\nca" ~~ rx:P5/ab$/)), 're_tests 1024  (1228)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1025  (1229)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 1026  (1230)');
ok((not ("ca\nb\n" ~~ rx:P5/(?m)ab$/)), 're_tests 1027  (1231)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1028  (1232)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)ab\z/)), 're_tests 1029  (1233)');
ok((not ("b\nca\n" ~~ rx:P5/(?m)ab$/)), 're_tests 1030  (1234)');
ok((not ("b\nca" ~~ rx:P5/(?m)ab\Z/)), 're_tests 1031  (1235)');
ok((not ("b\nca" ~~ rx:P5/(?m)ab\z/)), 're_tests 1032  (1236)');
ok((not ("b\nca" ~~ rx:P5/(?m)ab$/)), 're_tests 1033  (1237)');
ok((not ("abb\nb\n" ~~ rx:P5/abb\Z/)), 're_tests 1034  (1238)');
ok((not ("abb\nb\n" ~~ rx:P5/abb\z/)), 're_tests 1036  (1240)');
ok((not ("abb\nb\n" ~~ rx:P5/abb$/)), 're_tests 1038  (1242)');
is(("b\nabb\n" ~~ rx:P5/abb\Z/ && $/.from), 2, 're_tests 1039/0 (1243)');
ok((not ("b\nabb\n" ~~ rx:P5/abb\z/)), 're_tests 1041  (1245)');
is(("b\nabb\n" ~~ rx:P5/abb$/ && $/.from), 2, 're_tests 1043/0 (1247)');
is(("b\nabb" ~~ rx:P5/abb\Z/ && $/.from), 2, 're_tests 1044/0 (1248)');
is(("b\nabb" ~~ rx:P5/abb\z/ && $/.from), 2, 're_tests 1046/0 (1250)');
is(("b\nabb" ~~ rx:P5/abb$/ && $/.from), 2, 're_tests 1048/0 (1252)');

# vim: ft=perl6
