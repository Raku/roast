use v6.c;
use Test;

## test combinations of flags for "%b"

plan 165;

is sprintf("%b",      9),          "1001", '%b; positive int';
is sprintf("%b",     -9),         "-1001", '%b; negative int';
is sprintf("%10b",    9),    "      1001", '%b; size; positive int';
is sprintf("%2b",     9),          "1001", '%b; size; size not needed; positive int';
is sprintf("%10b",   -9),    "     -1001", '%b; size; negative int';
is sprintf("%2b",    -9),         "-1001", '%b; size; size not needed; negative int';
is sprintf("%010b",   9),    "0000001001", '%b; size; flag zero; positive int';
is sprintf("%02b",    9),          "1001", '%b; size; flag zero; size not needed; positive int';
is sprintf("%010b",  -9),    "-000001001", '%b; size; flag zero; negative int';
is sprintf("%02b",   -9),         "-1001", '%b; size; flag zero; size not needed; negative int';
is sprintf("%-10b",   9),    "1001      ", '%b; size; flag minus; positive int';
is sprintf("%-2b",    9),          "1001", '%b; size; flag minus; size not needed; positive int';
is sprintf("%-10b",  -9),    "-1001     ", '%b; size; flag minus; negative int';
is sprintf("%-2b",   -9),         "-1001", '%b; size; flag minus; size not needed; negative int';
is sprintf("%+10b",   9),    "     +1001", '%b; size; flag plus; positive int';
is sprintf("%+2b",    9),         "+1001", '%b; size; flag plus; size not needed; positive int';
is sprintf("%+10b",  -9),    "     -1001", '%b; size; flag plus; negative int';
is sprintf("%+2b",   -9),         "-1001", '%b; size; flag plus; size not needed; negative int';
is sprintf("% 10b",   9),    "      1001", '%b; size; flag space; positive int';
is sprintf("% 2b",    9),         " 1001", '%b; size; flag space; size not needed; positive int';
is sprintf("% 10b",  -9),    "     -1001", '%b; size; flag space; negative int';
is sprintf("% 2b",   -9),         "-1001", '%b; size; flag space; size not needed; negative int';
is sprintf("%#10b",   9),    "    0b1001", '%b; size; flag hash; positive int';
is sprintf("%#2b",    9),        "0b1001", '%b; size; flag hash; size not needed; positive int';
is sprintf("%#10b",  -9),    "   -0b1001", '%b; size; flag hash; negative int';
is sprintf("%#2b",   -9),       "-0b1001", '%b; size; flag hash; size not needed; negative int';
## flags zero and minus together are the same as only minus (left justify)
is sprintf("%0-10b",  9),    "1001      ", '%b; size; flag zero+minus; positive int';
is sprintf("%0-2b",   9),          "1001", '%b; size; flag zero+minus; size not needed; positive int';
is sprintf("%0-10b", -9),    "-1001     ", '%b; size; flag zero+minus; negative int';
is sprintf("%0-2b",  -9),         "-1001", '%b; size; flag zero+minus; size not needed; negative int';
is sprintf("%-010b", -9),    "-1001     ", '%b; size; flag minus+zero; negative int';
## flags zero and plus can be combined
is sprintf("%0+10b",  9),    "+000001001", '%b; size; flag zero+plus; positive int';
is sprintf("%0+2b",   9),         "+1001", '%b; size; flag zero+plus; size not needed; positive int';
is sprintf("%0+10b", -9),    "-000001001", '%b; size; flag zero+plus; negative int';
is sprintf("%0+2b",  -9),         "-1001", '%b; size; flag zero+plus; size not needed; negative int';
is sprintf("%+010b",  9),    "+000001001", '%b; size; flag plus+zero; positive int';
## flags zero and space can be combined
is sprintf("%0 10b",  9),    " 000001001", '%b; size; flag zero+space; positive int';
is sprintf("%0 2b",  9),          " 1001", '%b; size; flag zero+space; size not needed; positive int';
is sprintf("%0 10b", -9),    "-000001001", '%b; size; flag zero+space; negative int';
is sprintf("%0 2b", -9),          "-1001", '%b; size; flag zero+space; size not needed; negative int';
is sprintf("% 010b", -9),    "-000001001", '%b; size; flag space+zero; negative int';
## flags zero and hash can be combined
is sprintf("%0#10b",  9),    "0b00001001", '%b; size; flag zero+hash; positive int';
is sprintf("%0#2b",  9),         "0b1001", '%b; size; flag zero+hash; size not needed; positive int';
is sprintf("%0#10b", -9),    "-0b0001001", '%b; size; flag zero+hash; negative int';
is sprintf("%0#2b", -9),        "-0b1001", '%b; size; flag zero+hash; size not needed; negative int';
is sprintf("%#010b", -9),    "-0b0001001", '%b; size; flag hash+zero; negative int';
## flags minus and plus can be combined
is sprintf("%-+10b",  9),    "+1001     ", '%b; size; flag minus+plus; positive int';
is sprintf("%-+2b",  9),          "+1001", '%b; size; flag minus+plus; size not needed; positive int';
is sprintf("%-+10b", -9),    "-1001     ", '%b; size; flag minus+plus; negative int';
is sprintf("%-+2b", -9),          "-1001", '%b; size; flag minus+plus; size not needed; negative int';
is sprintf("%+-10b", -9),    "-1001     ", '%b; size; flag plus+minus; negative int';
## flags minus and space can be combined
is sprintf("% -10b", 9),     " 1001     ", '%b; size; flag space+minus; positive int';
is sprintf("% -2b",  9),          " 1001", '%b; size; flag space+minus; size not needed; positive int';
is sprintf("% -10b", -9),    "-1001     ", '%b; size; flag space+minus; negative int';
is sprintf("% -2b",  -9),         "-1001", '%b; size; flag space+minus; size not needed; negative int';
#?rakudo skip '"%- 10b" dies with "Unsupported use of %- variable;" RT #124707'
is sprintf("%- 10b", 9),     " 1001     ", '%b; size; flag minus+space; positive int';
## flags minus and hash can be combined
is sprintf("%#-10b", 9),     "0b1001    ", '%b; size; flag hash+minus; positive int';
is sprintf("%#-2b",  9),         "0b1001", '%b; size; flag hash+minus; size not needed; positive int';
is sprintf("%#-10b", -9),    "-0b1001   ", '%b; size; flag hash+minus; negative int';
is sprintf("%#-2b",  -9),       "-0b1001", '%b; size; flag hash+minus; size not needed; negative int';
is sprintf("%-#10b", 9),     "0b1001    ", '%b; size; flag minus+hash; positive int';
## flags plus and space together are the same as only plus (sign is always there)
is sprintf("% +10b", 9),     "     +1001", '%b; size; flag space+plus; positive int';
is sprintf("% +2b",  9),          "+1001", '%b; size; flag space+plus; size not needed; positive int';
is sprintf("% +10b", -9),    "     -1001", '%b; size; flag space+plus; negative int';
is sprintf("% +2b",  -9),         "-1001", '%b; size; flag space+plus; size not needed; negative int';
#?rakudo skip '"%+ 10b" dies with "Unsupported use of %+ variable;" RT #124710'
is sprintf("%+ 10b", 9),     " 1001     ", '%b; size; flag plus+space; positive int';
## flags plus and hash can be combined
is sprintf("%#+10b", 9),     "   +0b1001", '%b; size; flag hash+plus; positive int';
is sprintf("%#+2b",  9),        "+0b1001", '%b; size; flag hash+plus; size not needed; positive int';
is sprintf("%#+10b", -9),    "   -0b1001", '%b; size; flag hash+plus; negative int';
is sprintf("%#+2b",  -9),       "-0b1001", '%b; size; flag hash+plus; size not needed; negative int';
is sprintf("%+#10b", 9),     "   +0b1001", '%b; size; flag plus+hash; positive int';
## flags space and hash can be combined
is sprintf("%# 10b", 9),     "    0b1001", '%b; size; flag hash+space; positive int';
is sprintf("%# 2b",  9),        " 0b1001", '%b; size; flag hash+space; size not needed; positive int';
is sprintf("%# 10b", -9),    "   -0b1001", '%b; size; flag hash+space; negative int';
is sprintf("%# 2b",  -9),       "-0b1001", '%b; size; flag hash+space; size not needed; negative int';
is sprintf("% #10b", 9),     "    0b1001", '%b; size; flag space+hash; positive int';
## flags zero, minus and plus are the same as only minus and plus
is sprintf("%0-+10b",  9),   "+1001     ", '%b; size; flag zero+minus+plus; positive int';
is sprintf("%+0-2b",  9),         "+1001", '%b; size; flag zero+plus+minus; size not needed; positive int';
is sprintf("%-+010b", -9),   "-1001     ", '%b; size; flag zero+plus+minus; negative int';
is sprintf("%0-+2b", -9),         "-1001", '%b; size; flag zero+minus+plus; size not needed; negative int';
is sprintf("%-0+10b", -9),   "-1001     ", '%b; size; flag zero+plus+minus; negative int';
## flags zero, minus and space are the same as only minus and space
is sprintf("%0 -10b", 9),    " 1001     ", '%b; size; flag zero+space+minus; positive int';
is sprintf("%0- 2b",  9),         " 1001", '%b; size; flag zero+space+minus; size not needed; positive int';
is sprintf("% -010b", -9),   "-1001     ", '%b; size; flag space+minus+zero; negative int';
is sprintf("%-0 2b",  -9),        "-1001", '%b; size; flag zero+space+minus; size not needed; negative int';
#?rakudo skip '"%- 10b" dies with "unsupported use of %- variable;" RT #124715'
is sprintf("%- 010b", -9),   "-1001     ", '%b; size; flag minus+space+zero; negative int';
## flags zero, minus and hash are the same as only minus and hash
is sprintf("%0#-10b", 9),    "0b1001    ", '%b; size; flag zero+hash+minus; positive int';
is sprintf("%#0-2b",  9),        "0b1001", '%b; size; flag hash+zero+minus; size not needed; positive int';
is sprintf("%#-010b", -9),   "-0b1001   ", '%b; size; flag hash+minus+zero; negative int';
is sprintf("%0#-2b",  -9),      "-0b1001", '%b; size; flag zero+hash+minus; size not needed; negative int';
is sprintf("%-0#10b", 9),    "0b1001    ", '%b; size; flag minus+zero+hash; positive int';
## flags zero, plus and space are the same as only zero and plus
is sprintf("%0+ 10b", 9),    "+000001001", '%b; size; flag zero+plus+space; positive int';
is sprintf("%0 +2b",  9),         "+1001", '%b; size; flag zero+space+plus; size not needed; positive int';
is sprintf("% 0+10b", -9),   "-000001001", '%b; size; flag space+zero+plus; negative int';
is sprintf("%+0 2b",  -9),        "-1001", '%b; size; flag zero+plus+space; size not needed; negative int';
#?rakudo skip '"%+ 010b" dies with "unsupported use of %+ variable;" RT #124718'
is sprintf("%+ 010b", 9),    "+000001001", '%b; size; flag plus+space+zero; positive int';
## flags zero, plus and hash can be combined
is sprintf("%0#+10b", 9),    "+0b0001001", '%b; size; flag zero+hash+plus; positive int';
is sprintf("%0+#2b",  9),       "+0b1001", '%b; size; flag zero+plus+hash; size not needed; positive int';
is sprintf("%#0+10b", -9),   "-0b0001001", '%b; size; flag hash+zero+plus; negative int';
is sprintf("%+#02b", -9),       "-0b1001", '%b; size; flag plus+hash+zero; size not needed; negative int';
## flags zero, space and hash can be combined
is sprintf("%0 #10b", 9),    " 0b0001001", '%b; size; flag hash+space; positive int';
is sprintf("%0# 2b",  9),       " 0b1001", '%b; size; flag hash+space; size not needed; positive int';
is sprintf("%#0 10b", -9),   "-0b0001001", '%b; size; flag hash+space; negative int';
is sprintf("% #02b",  -9),      "-0b1001", '%b; size; flag hash+space; size not needed; negative int';
## flags minus, plus and space are the same as only minus and plus
is sprintf("%+- 10b", 9),    "+1001     ", '%b; size; flag plus+minus+space; positive int';
is sprintf("%-+ 2b",  9),         "+1001", '%b; size; flag minus+plus+space; size not needed; positive int';
is sprintf("% -+10b", -9),   "-1001     ", '%b; size; flag space+minus+plus; negative int';
is sprintf("% +-2b",  -9),        "-1001", '%b; size; flag space+plus+minus; size not needed; negative int';
#?rakudo skip '"%- +10b" dies with "unsupported use of %- variable;" RT #124722'
is sprintf("%- +10b", -9),   "-1001     ", '%b; size; flag minus+space+plus; negative int';
## flags minus, plus and hash can be combined
is sprintf("%-#+10b", 9),    "+0b1001   ", '%b; size; flag minus+hash+plus; positive int';
is sprintf("%#-+2b",  9),       "+0b1001", '%b; size; flag hash+minus+plus; size not needed; positive int';
is sprintf("%#+-10b", -9),   "-0b1001   ", '%b; size; flag hash+plus+minus; negative int';
is sprintf("%-+#2b",  -9),      "-0b1001", '%b; size; flag minus+plus+hash; size not needed; negative int';
## flags minus, space and hash can be combined
is sprintf("%# -10b", 9),    " 0b1001   ", '%b; size; flag hash+space+minus; positive int';
is sprintf("%#- 2b",  9),       " 0b1001", '%b; size; flag hash+minus+space; size not needed; positive int';
is sprintf("% #-10b", -9),   "-0b1001   ", '%b; size; flag space+hash+minus; negative int';
is sprintf("% -#2b",  -9),      "-0b1001", '%b; size; flag space+minus+hash; size not needed; negative int';
#?rakudo skip '"%- #10b" dies with "unsupported use of %- variable;" RT #124725'
is sprintf("%- #10b", -9),   "-0b1001   ", '%b; size; flag minus+space+plus; negative int';
## flags plus, space and hash are the same as only plus and hash
is sprintf("% #+10b", 9),    "   +0b1001", '%b; size; flag space+hash+plus; positive int';
is sprintf("%+# 2b",  9),       "+0b1001", '%b; size; flag plus+hash+space; size not needed; positive int';
is sprintf("%# +10b", -9),   "   -0b1001", '%b; size; flag hash+space+plus; negative int';
is sprintf("%#+ 2b", -9),       "-0b1001", '%b; size; flag hash+plus+space; size not needed; negative int';
#?rakudo skip '"%+ #10b" dies with "unsupported use of %+ variable;" RT #124727'
is sprintf("%+ #10b", -9),   "   -0b1001", '%b; size; flag plus+space+hash; negative int';
## flags zero, minus, plus and space are the same as only minus and plus
is sprintf("%0-+ 10b", 9),   "+1001     ", '%b; size; flag zero+minus+plus+space; positive int';
is sprintf("%+- 02b",  9),        "+1001", '%b; size; flag plus+minus+space+zero; size not needed; positive int';
is sprintf("%0 +-10b", -9),  "-1001     ", '%b; size; flag zero+space+plus+minus; negative int';
is sprintf("% 0-+2b",  -9),       "-1001", '%b; size; flag space+zero+minus+plus; size not needed; negative int';
## flags zero, minus, plus and hash are the same as only minus, plus and hash
is sprintf("%0-+#10b", 9),   "+0b1001   ", '%b; size; flag zero+minus+plus+hash; positive int';
is sprintf("%#0+-2b",  9),      "+0b1001", '%b; size; flag hash+zero+plus+minus; size not needed; positive int';
is sprintf("%+#-010b", -9),  "-0b1001   ", '%b; size; flag plus+hash+minus+zero; negative int';
is sprintf("%-+0#2b",  -9),     "-0b1001", '%b; size; flag minus+plus+zero+hash; size not needed; negative int';
## flags zero, minus, space and hash are the same as only minus, space and hash
is sprintf("%0# -10b", 9),   " 0b1001   ", '%b; size; flag zero+hash+space+minus; positive int';
is sprintf("%#0- 2b",  9),      " 0b1001", '%b; size; flag hash+zero+minus+space; size not needed; positive int';
is sprintf("% #0-10b", -9),  "-0b1001   ", '%b; size; flag space+hash+zero+minus; negative int';
is sprintf("% -#02b",  -9),     "-0b1001", '%b; size; flag space+minus+hash+zero; size not needed; negative int';
## flags zero, plus, space and hash are the same as only zero, plus and hash
is sprintf("% 0#+10b", 9),   "+0b0001001", '%b; size; flag space+zero+hash+plus; positive int';
is sprintf("%0 +#2b",  9),      "+0b1001", '%b; size; flag zero+space+plus+hash; size not needed; positive int';
is sprintf("%#0 +10b", -9),  "-0b0001001", '%b; size; flag hash+zero++spaceplus; negative int';
is sprintf("%+#0 2b", -9),      "-0b1001", '%b; size; flag plus+hash+zero+space; size not needed; negative int';
## flags minus, plus, space and hash are the same as only minus, plus and hash
is sprintf("% -#+10b", 9),   "+0b1001   ", '%b; size; flag space+minus+hash+plus; positive int';
is sprintf("%# -+2b",  9),      "+0b1001", '%b; size; flag hash+space+minus+plus; size not needed; positive int';
is sprintf("%#+ -10b", -9),  "-0b1001   ", '%b; size; flag hash+plus+space+minus; negative int';
is sprintf("%-+# 2b",  -9),     "-0b1001", '%b; size; flag minus+plus+hash+space; size not needed; negative int';
## flags zero, minus, plus, space and hash are the same as only minus, plus and hash
is sprintf("%0 -#+10b", 9),  "+0b1001   ", '%b; size; flag zero+space+minus+hash+plus; positive int';
is sprintf("%#0 -+2b",  9),     "+0b1001", '%b; size; flag hash+zero+space+minus+plus; size not needed; positive int';
is sprintf("%#+0 -10b", -9), "-0b1001   ", '%b; size; flag hash+plus+zero+space+minus; negative int';
is sprintf("%-+#0 2b",  -9),    "-0b1001", '%b; size; flag minus+plus+hash+zero+space; size not needed; negative int';

## tests for low value of precision (less than characters needed)
is sprintf("%.0b", 0),                 "", '%b; precision 0; value 0';
is sprintf("%.0b", 9),             "1001", '%b; precision 0; value > 0';
is sprintf("%.0b", -9),           "-1001", '%b; precision 0; value < 0';
is sprintf("%10.0b", 0),     "          ", '%b; size; precision 0; value 0';
is sprintf("%10.0b", 9),     "      1001", '%b; size; precision 0; value > 0';
is sprintf("%10.0b", -9),    "     -1001", '%b; size; precision 0; value < 0';
is sprintf("%.1b", 0),                "0", '%b; precision 1; value 0';
is sprintf("%.1b", 9),             "1001", '%b; precision 1; value > 0';
is sprintf("%.1b", -9),           "-1001", '%b; precision 1; value < 0';
is sprintf("%10.1b", 0),     "         0", '%b; size; precision 1; value 0';
is sprintf("%10.1b", 9),     "      1001", '%b; size; precision 1; value > 0';
is sprintf("%10.1b", -9),    "     -1001", '%b; size; precision 1; value < 0';
## tests for medium value of precision (more than digits needed, less than width/size)
is sprintf("%10.8b", 9),     "  00001001", '%b; size 10; precision 8; value > 0';
is sprintf("%10.8b", -9),    " -00001001", '%b; size 10; precision 8; value < 0';
## tests for high value of precision (more than digits needed, more than width/size)
is sprintf("%.8b", 9),         "00001001", '%b; no size; precision 8; value > 0';
is sprintf("%.8b", -9),       "-00001001", '%b; no size; precision 8; value < 0';
is sprintf("%2.8b", 9),        "00001001", '%b; size 2; precision 8; value > 0';
is sprintf("%2.8b", -9),      "-00001001", '%b; size 2; precision 8; value < 0';

# TODO combinations of $<precision> with flags

# vim: ft=perl6
