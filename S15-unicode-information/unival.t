use v6;

use Test;

plan 25;

#use unicode :v(6.3);

# L<S15/Numeric Value>

#?niecza 25 skip "unival NYI"
#?pugs 25 skip "unival NYI"

is unival(0x30).WHAT.gist, '(Int)', "0x30 is Int";
is unival(0x30), 0, "0x30 has numeric value 0";
is unival('0'), 0, "'0' has numeric value 0";
is unival(0x39), 9, "0x39 has numeric value 9";
is unival('9'), 9, "'9' has numeric value 9";

is unival('⅓').WHAT.gist, '(Rat)', "'⅓' is a Rat";
is unival('⅓'), 1/3, "'⅓' has the value 1/3";

is unival("\c[VULGAR FRACTION ONE TENTH]").WHAT.gist, '(Rat)', "'⅒' is a Rat";
is unival('⅒'), 1/10, "'⅒' has the value 1/10";

is unival('⅚'), 5/6, "'⅚' has the value 5/6";

is unival('ⅵ'), 6, "'ⅵ' has the value 6";
is unival('ↇ'), 50000, "'ↇ' has the value 50000";

is unival('༲'), 8.5, "'༲' has the value 8.5";

is unival('𒐳'), 432000, "'𒐳' has the value 432000";

is unival('仟'), 1000, "'仟' has the value 1000";
is unival('千'), 1000, "'千' has the value 1000";
is unival('阡'), 1000, "'阡' has the value 1000";
is unival('万'), 1_0000, "'万' has the value 1_0000";
is unival('萬'), 1_0000, "'萬' has the value 1_0000";
is unival('億'), 1_0000_0000, "'億' has the value 1_0000_0000";
is unival('亿'), 1_0000_0000, "'亿' has the value 1_0000_0000";
is unival('兆'), 1_0000_0000_0000, "'兆' has the value 1_0000_0000_0000";

is unival("\x19DA"), 1, "NEW TAI LUE THAM DIGIT ONE has value 1";
is unival("\c[AEGEAN NUMBER NINETY THOUSAND]"), 90000, "AEGEAN NUMBER NINETY THOUSAND has value 90000";
is unival("\c[MATHEMATICAL MONOSPACE DIGIT FIVE]"), 5, "MATHEMATICAL MONOSPACE DIGIT FIVE has value 5";
