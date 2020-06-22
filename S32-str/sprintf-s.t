use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%s".  The @info array is intialized with the
# flags (as a string), the size/precision specification (either a string or a
# number), and the expected strings for the values "", "Foo" and "🦋🦋🦋".  The
# flags values will be expanded to all possible permutations to ensure that the
# order of the flags is irrelevant.  Each flag permutation is combined with
# the size/permutation value to create a proper format string.

my ($v0, $v1, $v4) =
                        "" ,     "Foo" ,     "🦋🦋🦋" ;
my @info = ( # |-----------|-----------|--------------|
             # no size or size explicitely 0
       '',   '',         "",      "Foo",      "🦋🦋🦋",
      ' ',   '',         "",      "Foo",      "🦋🦋🦋",
      '0',   '',         "",      "Foo",      "🦋🦋🦋",
     '0 ',   '',         "",      "Foo",      "🦋🦋🦋",
      '+',   '',         "",      "Foo",      "🦋🦋🦋",
     '+ ',   '',         "",      "Foo",      "🦋🦋🦋",
     '+0',   '',         "",      "Foo",      "🦋🦋🦋",
    '+0 ',   '',         "",      "Foo",      "🦋🦋🦋",
      '-',   '',         "",      "Foo",      "🦋🦋🦋",
     '-+',   '',         "",      "Foo",      "🦋🦋🦋",
     '- ',   '',         "",      "Foo",      "🦋🦋🦋",
    '-+ ',   '',         "",      "Foo",      "🦋🦋🦋",
     '-0',   '',         "",      "Foo",      "🦋🦋🦋",
    '-+0',   '',         "",      "Foo",      "🦋🦋🦋",
    '-0 ',   '',         "",      "Foo",      "🦋🦋🦋",
   '-+0 ',   '',         "",      "Foo",      "🦋🦋🦋",

             # no size, precision 0
       '', '.0',         "",         "",           "",
      ' ', '.0',         "",         "",           "",
      '0', '.0',         "",         "",           "",
     '0 ', '.0',         "",         "",           "",
      '+', '.0',         "",         "",           "",
     '+ ', '.0',         "",         "",           "",
     '+0', '.0',         "",         "",           "",
    '+0 ', '.0',         "",         "",           "",
      '-', '.0',         "",         "",           "",
     '-+', '.0',         "",         "",           "",
     '- ', '.0',         "",         "",           "",
    '-+ ', '.0',         "",         "",           "",
     '-0', '.0',         "",         "",           "",
    '-+0', '.0',         "",         "",           "",
    '-0 ', '.0',         "",         "",           "",
   '-+0 ', '.0',         "",         "",           "",

             # 2 positions, usually doesn't fit
       '',    2,       "  ",      "Foo",      "🦋🦋🦋",
      ' ',    2,       "  ",      "Foo",      "🦋🦋🦋",
      '0',    2,       "00",      "Foo",      "🦋🦋🦋",
     '0 ',    2,       "00",      "Foo",      "🦋🦋🦋",
      '+',    2,       "  ",      "Foo",      "🦋🦋🦋",
     '+ ',    2,       "  ",      "Foo",      "🦋🦋🦋",
     '+0',    2,       "00",      "Foo",      "🦋🦋🦋",
    '+0 ',    2,       "00",      "Foo",      "🦋🦋🦋",
      '-',    2,       "  ",      "Foo",      "🦋🦋🦋",
     '-+',    2,       "  ",      "Foo",      "🦋🦋🦋",
     '- ',    2,       "  ",      "Foo",      "🦋🦋🦋",
    '-+ ',    2,       "  ",      "Foo",      "🦋🦋🦋",
     '-0',    2,       "  ",      "Foo",      "🦋🦋🦋",
    '-+0',    2,       "  ",      "Foo",      "🦋🦋🦋",
    '-0 ',    2,       "  ",      "Foo",      "🦋🦋🦋",
   '-+0 ',    2,       "  ",      "Foo",      "🦋🦋🦋",

             # 8 positions, should always fit
       '',    8, "        ", "     Foo", "     🦋🦋🦋",
      ' ',    8, "        ", "     Foo", "     🦋🦋🦋",
      '0',    8, "00000000", "00000Foo", "00000🦋🦋🦋",
     '0 ',    8, "00000000", "00000Foo", "00000🦋🦋🦋",
      '+',    8, "        ", "     Foo", "     🦋🦋🦋",
     '+ ',    8, "        ", "     Foo", "     🦋🦋🦋",
     '+0',    8, "00000000", "00000Foo", "00000🦋🦋🦋",
    '+0 ',    8, "00000000", "00000Foo", "00000🦋🦋🦋",
      '-',    8, "        ", "Foo     ", "🦋🦋🦋     ",
     '-+',    8, "        ", "Foo     ", "🦋🦋🦋     ",
     '- ',    8, "        ", "Foo     ", "🦋🦋🦋     ",
    '-+ ',    8, "        ", "Foo     ", "🦋🦋🦋     ",
     '-0',    8, "        ", "Foo     ", "🦋🦋🦋     ",
    '-+0',    8, "        ", "Foo     ", "🦋🦋🦋     ",
    '-0 ',    8, "        ", "Foo     ", "🦋🦋🦋     ",
   '-+0 ',    8, "        ", "Foo     ", "🦋🦋🦋     ",

             # 8 positions with precision, precision fits sometimes
       '',  8.2, "        ", "      Fo",  "      🦋🦋",
      ' ',  8.2, "        ", "      Fo",  "      🦋🦋",
      '0',  8.2, "        ", "      Fo",  "      🦋🦋",
     '0 ',  8.2, "        ", "      Fo",  "      🦋🦋",
      '+',  8.2, "        ", "      Fo",  "      🦋🦋",
     '+ ',  8.2, "        ", "      Fo",  "      🦋🦋",
     '+0',  8.2, "        ", "      Fo",  "      🦋🦋",
    '+0 ',  8.2, "        ", "      Fo",  "      🦋🦋",
      '-',  8.2, "        ", "Fo      ",  "🦋🦋      ",
     '-+',  8.2, "        ", "Fo      ",  "🦋🦋      ",
     '- ',  8.2, "        ", "Fo      ",  "🦋🦋      ",
    '-+ ',  8.2, "        ", "Fo      ",  "🦋🦋      ",
     '-0',  8.2, "        ", "Fo      ",  "🦋🦋      ",
    '-+0',  8.2, "        ", "Fo      ",  "🦋🦋      ",
    '-0 ',  8.2, "        ", "Fo      ",  "🦋🦋      ",
   '-+0 ',  8.2, "        ", "Fo      ",  "🦋🦋      ",

).map: -> $flags, $size, $r0, $r1, $r4 {
    my @flat;
    @flat.append(
      '%' ~ $_ ~ $size ~ 's',
      ($r0 => "", $r1 => "Foo", $r4 => "🦋🦋🦋")
    ) for $flags.comb.permutations>>.join;
    @flat.append(
      '%' ~ $_ ~ $size ~ 's',
      ($r0 => "", $r1 => "Foo", $r4 => "🦋🦋🦋")
    ) for "#$flags".comb.permutations>>.join;
    |@flat
}

plan @info/2;

for @info -> $format, @tests {
    subtest {
        plan +@tests;

        is-deeply sprintf($format, |.value), .key,
          qq/sprintf("$format",{.value.list.join(",")}) eq '{.key}'/
          for @tests;
    }, "Tested '$format'";
}

# vim: expandtab shiftwidth=4
