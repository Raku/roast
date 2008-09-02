use v6;

use Test;

plan 41;

{ # L<S03/"Changes to Perl 5 operators"/imposes boolean context/>
  is ?True,    True,  "? context forcer works (1)";
  is ?False,   False, "? context forcer works (2)";

  is ?1,       True,  "? context forcer works (3)";
  is ?0,       False, "? context forcer works (4)";
  is ?(?1),    True,  "? context forcer works (5)";
  is ?(?0),    False, "? context forcer works (6)";

  is ?"hi",    True,  "? context forcer works (7)";
  is ?"",      False, "? context forcer works (8)";
  is ?(?"hi"), True,  "? context forcer works (9)";
  is ?(?""),   False, "? context forcer works (10)";

  is ?"3",     True,  "? context forcer works (11)";
  is ?"0",     False, "? context forcer works (12)";
  is ?(?"3"),  True,  "? context forcer works (13)";
  is ?(?"0"),  False, "? context forcer works (14)";

  is ?undef,   False, "? context forcer works (15)";
}
{ # L<S02/"Names and Variables" /In boolean contexts/>
  is ?[],      False,  "? context forcer: empty container is false";
  is ?[1],     True,   "? context forcer: non-empty container is true";
}
{ # L<SO2/"Names and Variables" /In a boolean context, a Hash/>
  is ?{},      False,  "? context forcer: empty hash is false";
  is ?{:a},    True,   "? context forcer: non-empty hash is true";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a numeric context/>
  is +1,           1, "+ context forcer works (1)";
  is +0,           0, "+ context forcer works (2)";
  is +"1",         1, "+ context forcer works (3)";
  is +"0",         0, "+ context forcer works (4)";
  is +"",          0, "+ context forcer works (5)";
  is +undef,       0, "+ context forcer works (6)";
  is +"Inf",     Inf, "+ context forcer works (7)";
  is +"-Inf",   -Inf, "+ context forcer works (8)";
  is +"NaN",     NaN, "+ context forcer works (9)";
  is +"3e5",  300000, "+ context forcer works (10)";
  is +(?0),        0, "+ context forcer works (11)";
  is +(?3),        1, "+ context forcer works (11)";
}

{ # L<S03/"Changes to Perl 5 operators" /imposes a string context/>
  is ~1,         "1", "~ context forcer works (1)";
  is ~0,         "0", "~ context forcer works (2)";
  is ~"1",       "1", "~ context forcer works (3)";
  is ~"0",       "0", "~ context forcer works (4)";
  is ~"",         "", "~ context forcer works (5)";
  is ~undef,      "", "~ context forcer works (6)";
  is ~"Inf",   "Inf", "~ context forcer works (7)";
  is ~"-Inf", "-Inf", "~ context forcer works (8)";
  is ~"NaN",   "NaN", "~ context forcer works (9)";
  is ~"3e5",   "3e5", "~ context forcer works (10)";
}
