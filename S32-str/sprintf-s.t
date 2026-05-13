use v6.e.PREVIEW;
BEGIN %*ENV<RAKU_TEST_DIE_ON_FAIL> = True;
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
       '',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
      ' ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
      '0',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '0 ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
      '+',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '+ ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '+0',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
    '+0 ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
      '-',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '-+',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '- ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
    '-+ ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
     '-0',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
    '-+0',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
    '-0 ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,
   '-+0 ',   '',         "",      "Foo",      "🦋🦋🦋", $?LINE,

             # no size, precision 0
       '', '.0',         "",         "",           "", $?LINE,
      ' ', '.0',         "",         "",           "", $?LINE,
      '0', '.0',         "",         "",           "", $?LINE,
     '0 ', '.0',         "",         "",           "", $?LINE,
      '+', '.0',         "",         "",           "", $?LINE,
     '+ ', '.0',         "",         "",           "", $?LINE,
     '+0', '.0',         "",         "",           "", $?LINE,
    '+0 ', '.0',         "",         "",           "", $?LINE,
      '-', '.0',         "",         "",           "", $?LINE,
     '-+', '.0',         "",         "",           "", $?LINE,
     '- ', '.0',         "",         "",           "", $?LINE,
    '-+ ', '.0',         "",         "",           "", $?LINE,
     '-0', '.0',         "",         "",           "", $?LINE,
    '-+0', '.0',         "",         "",           "", $?LINE,
    '-0 ', '.0',         "",         "",           "", $?LINE,
   '-+0 ', '.0',         "",         "",           "", $?LINE,

             # 2 positions, usually doesn't fit
       '',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
      ' ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
      '0',    2,       "00",      "Foo",      "🦋🦋🦋", $?LINE,
     '0 ',    2,       "00",      "Foo",      "🦋🦋🦋", $?LINE,
      '+',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
     '+ ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
     '+0',    2,       "00",      "Foo",      "🦋🦋🦋", $?LINE,
    '+0 ',    2,       "00",      "Foo",      "🦋🦋🦋", $?LINE,
      '-',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
     '-+',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
     '- ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
    '-+ ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
     '-0',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
    '-+0',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
    '-0 ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,
   '-+0 ',    2,       "  ",      "Foo",      "🦋🦋🦋", $?LINE,

             # 8 positions, should always fit
       '',    8, "        ", "     Foo", "     🦋🦋🦋", $?LINE,
      ' ',    8, "        ", "     Foo", "     🦋🦋🦋", $?LINE,
      '0',    8, "00000000", "00000Foo", "00000🦋🦋🦋", $?LINE,
     '0 ',    8, "00000000", "00000Foo", "00000🦋🦋🦋", $?LINE,
      '+',    8, "        ", "     Foo", "     🦋🦋🦋", $?LINE,
     '+ ',    8, "        ", "     Foo", "     🦋🦋🦋", $?LINE,
     '+0',    8, "00000000", "00000Foo", "00000🦋🦋🦋", $?LINE,
    '+0 ',    8, "00000000", "00000Foo", "00000🦋🦋🦋", $?LINE,
      '-',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
     '-+',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
     '- ',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
    '-+ ',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
     '-0',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
    '-+0',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
    '-0 ',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,
   '-+0 ',    8, "        ", "Foo     ", "🦋🦋🦋     ", $?LINE,

             # 8 positions with precision, precision fits sometimes
       '',  8.2, "        ", "      Fo",  "      🦋🦋", $?LINE,
      ' ',  8.2, "        ", "      Fo",  "      🦋🦋", $?LINE,
      '0',  8.2, "00000000", "000000Fo",  "000000🦋🦋", $?LINE,
     '0 ',  8.2, "00000000", "000000Fo",  "000000🦋🦋", $?LINE,
      '+',  8.2, "        ", "      Fo",  "      🦋🦋", $?LINE,
     '+ ',  8.2, "        ", "      Fo",  "      🦋🦋", $?LINE,
     '+0',  8.2, "00000000", "000000Fo",  "000000🦋🦋", $?LINE,
    '+0 ',  8.2, "00000000", "000000Fo",  "000000🦋🦋", $?LINE,
      '-',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
     '-+',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
     '- ',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
    '-+ ',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
     '-0',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
    '-+0',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
    '-0 ',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,
   '-+0 ',  8.2, "        ", "Fo      ",  "🦋🦋      ", $?LINE,

).map: -> $flags, $size, $r0, $r1, $r4, $line {
    my @flat;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 's',
      ($r0 => "", $r1 => "Foo", $r4 => "🦋🦋🦋")
    ) for $flags.comb.permutations>>.join;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 's',
      ($r0 => "", $r1 => "Foo", $r4 => "🦋🦋🦋")
    ) for "#$flags".comb.permutations>>.join;
    |@flat
}

plan @info/3;

for @info -> $line, $format, @tests {
    subtest "Tested '$format' at line $line" => {
        plan +@tests;

        is-deeply sprintf($format, |.value), .key,
          qq/sprintf("$format",{.value.list.join(",")}) eq '{.key}'/
          for @tests;
    }
}

# vim: expandtab shiftwidth=4
